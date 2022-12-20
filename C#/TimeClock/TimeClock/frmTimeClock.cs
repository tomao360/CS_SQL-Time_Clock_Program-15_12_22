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
    public partial class frmTimeClock : Form
    {
        public frmTimeClock()
        {
            InitializeComponent();
            //Open the connection to DB 
            connection = new SqlConnection(connectionString);
            //Connect();
        }

        //Example to ConnectionString with user and password
        //string connectionString = @"data source=localhost\SQLEXPRESS; initial catalog=Time_Clock; user id=sa;password=1234";

        string connectionString = @"data source=localhost\SQLEXPRESS; initial catalog=Time_Clock;  integrated security = SSPI; persist security info=False;";
        //Object that contains the connection string to DB
        public SqlConnection connection; 

        //A function that connects to the DB and returns if the connection string is working
        public bool Connect()
        {
            try
            {
                connection.Open();
                //MessageBox.Show("The Connection to DB Worked");
                return true;
            }
            catch (SqlException ex)
            {
                //MessageBox.Show(ex.Message);
                return false;
            }
        }

        //A function that sends user data to DB and gets an answer from DB
        private string sendDetails(string ID, string password)
        {
            //Connect to DB - if failed => return
            if (!Connect())
            {
                return "Connection failed";
            }
            else
            {
                //The query in SQL
                string insert = "declare @employeeCode int, @answer nvarchar(100) select @employeeCode = (select code from Employees where ID = @id) if @employeeCode is null begin select @answer = 'User or Password are Wrong! You have 3 more times to enter the system' end else begin if not exists(select code from Passwords where Password = @password and IsActive = 1 and EmployeeCode = @employeeCode) begin select @answer = 'User or Password are Wrong! You have 3 more times to enter the system' end else begin if not exists(select code from Passwords where Password = @password and IsActive = 1 and EmployeeCode = @employeeCode and Expiry > GETDATE()) begin select @answer = 'Your Password Expired! Please change your Password' end else begin if not exists(select code from Times where EmployeeCode = @employeeCode and ExitTime is null) begin insert into Times values(@employeeCode, GETDATE(), null) select @answer = 'Entry Time: ' + CONVERT(nvarchar(20), GETDATE(), 3) + ' ' + CONVERT(nvarchar(20), GETDATE(), 108) end else begin update Times set ExitTime = GETDATE() where EmployeeCode = @employeeCode and ExitTime is null select @answer = 'Exit Time: ' + CONVERT(nvarchar(20), GETDATE(), 3) + ' ' + CONVERT(nvarchar(20), GETDATE(), 108) end end end end select @answer";

                //Creating the execution object and adding the query and connection to the object
                SqlCommand command = new SqlCommand(insert, connection);
                //Adding parameters
                command.Parameters.AddWithValue("@id", ID);
                command.Parameters.AddWithValue("@password", password);
                //Old way to declare parameters:
                //command.Parameters.Add("@password", SqlDbType.NVarChar, 10);
                //command.Parameters["@password"].Value = password;

                //Executing the query and returnning the answer in string
                string answer = command.ExecuteScalar().ToString();
                //closing the connection
                connection.Close();
                return answer;
            }
        }
     
        private bool checkID(string ID)
        {
            return true;
        }

        private void passwordTextBox_KeyPress(object sender, KeyPressEventArgs e)
        {
            // Check if the user entered correct ID and Password
            if (e.KeyChar == (char)Keys.Enter)
            {
                if (IdTextBox.Text == "" || passwordTextBox.Text == string.Empty)
                {
                    MessageBox.Show("נא להכניס מספר זהות וסיסמא", "מספר זהות וסיסמא", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return; //To not continue the function if there is a error
                }

                MessageBox.Show(sendDetails(IdTextBox.Text, passwordTextBox.Text));
            }
        }

        private void changePasswordBtn_Click(object sender, EventArgs e)
        {
            string ID = IdTextBox.Text;
            while (ID == string.Empty)
            {
                ID = Microsoft.VisualBasic.Interaction.InputBox("נא הכנס מספר זהות", "החלפת סיסמא");

            }

            frmTimeClock2 formPassword = new frmTimeClock2(this, ID);
            formPassword.Show();
        }
    }
}
