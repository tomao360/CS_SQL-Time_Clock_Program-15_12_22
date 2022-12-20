--Create Employee Table
create table Employees(code int primary key identity, 
ID nvarchar(10), FirstName nvarchar(30), LastName nvarchar(30),
Cellphone nvarchar(10))

select * from Employees

select ID as 'מספר זהות', FirstName + ' ' + LastName as 'שם מלא', 
Cellphone as 'מספר טלפון'
from Employees

---------------------------------------------------------
--Create Password Table
create table Passwords(code int primary key identity, 
--שדה המקשר עם הטבלה של העובדים
EmployeeCode int foreign key references Employees (code), 
Password nvarchar(10), Expiry date, IsActive bit)

---------------------------------------------------------
--Create Times Table
create table Times(code int primary key identity, 
--שדה המקשר עם הטבלה של העובדים
EmployeeCode int foreign key references Employees (code), 
EntryTime datetime, ExitTime datetime)

---------------------------------------------------------
--הכנסת עובד חדש עם סיסמא זמנית
--הצהרה על משתנים
declare @id nvarchar(10) = '1234', @firstName nvarchar(30) = 'Tamara',
@lastName nvarchar(30) = 'Osipov', @cellphone nvarchar(10) = '052-222',
@tempPassword nvarchar(10) = '1234', @employeeCode int,
@answer nvarchar(100)

--בדיקה האם מספר הזהות של העובד קיים כבר במערכת 
if exists(select * from Employees where ID = @id)
begin -- פתיחת סוגריים
	update Employees set FirstName = @firstName, LastName = @lastName,
		Cellphone = @cellphone where ID = @id
		-- קבלת קוד עובד
		select @employeeCode = (select code from Employees where ID = @id)
		select @answer = 'Employee' + @firstName + ' ' + @lastName + 'Updated Successfully'
end -- סגירת סוגריים
else -- אם העובד לא קיים במערכת, מכניסים אותו למערכת 
begin
	insert into Employees values(@id, @firstName, @lastName, @cellphone)
	-- קבלת קוד עובד 
	select @employeeCode = @@IDENTITY
	select @answer = 'The employee was successfully inserted into the system'
end

-- הכנסת סיסמא זמנית 
insert into Passwords values(@employeeCode, @tempPassword, GETDATE(), 1)
select @answer = @answer + '. The temporary passwors is ' + @tempPassword  

select @answer

-------------------------------
select * from Employees
select * from Passwords
-- קבלת עובדים עם סיסמאות
select * from Employees E
inner join Passwords P on P.code = E.code 
---------------------------------------------------------


	
