using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace TimeClock
{
    public partial class frmTimeClock2 : Form
    {
        frmTimeClock parent;
        public frmTimeClock2(frmTimeClock Parent, string ID)
        {
            InitializeComponent();
            parent = Parent;
            idLabel.Text = ID;
        }

        private string sendDetails(string ID, string oldPassword, string newPassword)
        {
            if (!parent.Connect()) return "";
            string insert = "declare @employeeCode int, @answer nvarchar(100) select @employeeCode = (select code from Employees where ID = @id) if @employeeCode is null begin select @answer = 'User or Password are Wrong!' end else begin if not exists(select * from Passwords where Password = @password and IsActive = 1 and EmployeeCode = @employeeCode) begin select @answer = 'User or Password are Wrong!' end else begin if exists(select * from Passwords where EmployeeCode = @employeeCode and Password = @newPassword) begin select @answer = 'You used this password before. Please enter another password' end else begin update Passwords set IsActive = 0 where EmployeeCode = @employeeCode insert into Passwords values(@employeeCode, @newPassword, GETDATE() +180, 1) select @answer = 'Updating the Password ended successfully. The expiry date is in 180 days' end end end select @answer";

            SqlCommand command = new SqlCommand(insert, parent.connection);
            command.Parameters.AddWithValue("@id", ID);
            command.Parameters.AddWithValue("@password", oldPassword);
            command.Parameters.AddWithValue("@newPassword", newPassword);

            string answer = command.ExecuteScalar().ToString();
            parent.connection.Close();
            return answer;
        }

        private void okBtn_Click(object sender, EventArgs e)
        {
            if (oldPassTextBox.Text != string.Empty && newPassTextBox.Text != string.Empty && validPassTextBox.Text != string.Empty)
            {
                if (newPassTextBox.Text == validPassTextBox.Text)
                {
                    string response = sendDetails(idLabel.Text, oldPassTextBox.Text, newPassTextBox.Text);
                    MessageBox.Show(response);      
                    if (response == "Updating the Password ended successfully. The expiry date is in 180 days")
                    {
                        Close();
                    }
                }
                else
                {
                    MessageBox.Show("The password validation failed");
                    return;
                }
            }
            else
            {
                MessageBox.Show("Please enter all the details");
            }
        }
    }
}

