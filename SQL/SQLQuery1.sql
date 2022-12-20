--Create Employee Table
create table Employees(code int primary key identity, 
ID nvarchar(10), FirstName nvarchar(30), LastName nvarchar(30),
Cellphone nvarchar(10))

select * from Employees

select ID as '���� ����', FirstName + ' ' + LastName as '�� ���', 
Cellphone as '���� �����'
from Employees

---------------------------------------------------------
--Create Password Table
create table Passwords(code int primary key identity, 
--��� ����� �� ����� �� �������
EmployeeCode int foreign key references Employees (code), 
Password nvarchar(10), Expiry date, IsActive bit)

---------------------------------------------------------
--Create Times Table
create table Times(code int primary key identity, 
--��� ����� �� ����� �� �������
EmployeeCode int foreign key references Employees (code), 
EntryTime datetime, ExitTime datetime)

---------------------------------------------------------
--����� ���� ��� �� ����� �����
--����� �� ������
declare @id nvarchar(10) = '1234', @firstName nvarchar(30) = 'Tamara',
@lastName nvarchar(30) = 'Osipov', @cellphone nvarchar(10) = '052-222',
@tempPassword nvarchar(10) = '1234', @employeeCode int,
@answer nvarchar(100)

--����� ��� ���� ����� �� ����� ���� ��� ������ 
if exists(select * from Employees where ID = @id)
begin -- ����� �������
	update Employees set FirstName = @firstName, LastName = @lastName,
		Cellphone = @cellphone where ID = @id
		-- ���� ��� ����
		select @employeeCode = (select code from Employees where ID = @id)
		select @answer = 'Employee' + @firstName + ' ' + @lastName + 'Updated Successfully'
end -- ����� �������
else -- �� ����� �� ���� ������, ������� ���� ������ 
begin
	insert into Employees values(@id, @firstName, @lastName, @cellphone)
	-- ���� ��� ���� 
	select @employeeCode = @@IDENTITY
	select @answer = 'The employee was successfully inserted into the system'
end

-- ����� ����� ����� 
insert into Passwords values(@employeeCode, @tempPassword, GETDATE(), 1)
select @answer = @answer + '. The temporary passwors is ' + @tempPassword  

select @answer

-------------------------------
select * from Employees
select * from Passwords
-- ���� ������ �� �������
select * from Employees E
inner join Passwords P on P.code = E.code 
---------------------------------------------------------


	
