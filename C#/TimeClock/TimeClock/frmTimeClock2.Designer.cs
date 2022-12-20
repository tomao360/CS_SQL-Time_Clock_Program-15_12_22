namespace TimeClock
{
    partial class frmTimeClock2
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.oldPassTextBox = new System.Windows.Forms.TextBox();
            this.newPassTextBox = new System.Windows.Forms.TextBox();
            this.validPassTextBox = new System.Windows.Forms.TextBox();
            this.okBtn = new System.Windows.Forms.Button();
            this.idLabel = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe Print", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(235, 87);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(102, 23);
            this.label1.TabIndex = 0;
            this.label1.Text = "סיסמא ישנה";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe Print", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(227, 150);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(110, 23);
            this.label2.TabIndex = 1;
            this.label2.Text = "סיסמא חדשה";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe Print", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(226, 203);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(111, 46);
            this.label3.TabIndex = 2;
            this.label3.Text = "אימות סיסמא\r\nחדשה";
            // 
            // oldPassTextBox
            // 
            this.oldPassTextBox.Location = new System.Drawing.Point(70, 88);
            this.oldPassTextBox.Name = "oldPassTextBox";
            this.oldPassTextBox.Size = new System.Drawing.Size(150, 22);
            this.oldPassTextBox.TabIndex = 3;
            // 
            // newPassTextBox
            // 
            this.newPassTextBox.Location = new System.Drawing.Point(70, 151);
            this.newPassTextBox.Name = "newPassTextBox";
            this.newPassTextBox.Size = new System.Drawing.Size(150, 22);
            this.newPassTextBox.TabIndex = 4;
            // 
            // validPassTextBox
            // 
            this.validPassTextBox.Location = new System.Drawing.Point(70, 215);
            this.validPassTextBox.Name = "validPassTextBox";
            this.validPassTextBox.Size = new System.Drawing.Size(150, 22);
            this.validPassTextBox.TabIndex = 5;
            // 
            // okBtn
            // 
            this.okBtn.BackColor = System.Drawing.SystemColors.GrayText;
            this.okBtn.Font = new System.Drawing.Font("Comic Sans MS", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.okBtn.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.okBtn.Location = new System.Drawing.Point(111, 287);
            this.okBtn.Name = "okBtn";
            this.okBtn.Size = new System.Drawing.Size(109, 39);
            this.okBtn.TabIndex = 6;
            this.okBtn.Text = "אישור";
            this.okBtn.UseVisualStyleBackColor = false;
            this.okBtn.Click += new System.EventHandler(this.okBtn_Click);
            // 
            // idLabel
            // 
            this.idLabel.AutoSize = true;
            this.idLabel.BackColor = System.Drawing.SystemColors.Info;
            this.idLabel.Font = new System.Drawing.Font("Segoe Print", 7.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.idLabel.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
            this.idLabel.Location = new System.Drawing.Point(127, 27);
            this.idLabel.Name = "idLabel";
            this.idLabel.Size = new System.Drawing.Size(96, 23);
            this.idLabel.TabIndex = 7;
            this.idLabel.Text = "תעודת זהות";
            // 
            // frmTimeClock2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlDark;
            this.ClientSize = new System.Drawing.Size(361, 388);
            this.Controls.Add(this.idLabel);
            this.Controls.Add(this.okBtn);
            this.Controls.Add(this.validPassTextBox);
            this.Controls.Add(this.newPassTextBox);
            this.Controls.Add(this.oldPassTextBox);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "frmTimeClock2";
            this.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.Text = "frmTimeClock2";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox oldPassTextBox;
        private System.Windows.Forms.TextBox newPassTextBox;
        private System.Windows.Forms.TextBox validPassTextBox;
        private System.Windows.Forms.Button okBtn;
        private System.Windows.Forms.Label idLabel;
    }
}