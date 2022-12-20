-- :����� ����� ���� ���� ������ 

--1. ����� �� ������
declare @id nvarchar(10) = '1234', @password nvarchar(10) = '1212', 
@employeeCode int, @answer nvarchar(100)
-------------------------------------------------------------------
--2. ����� �� ���� ���� - �� ����
select @employeeCode = (select code from Employees where ID = @id)
--3. �� �� ����, ����� ������ 
if @employeeCode is null 
begin 
	select @answer = 'User or Password are Wrong! You have 3 more times to enter the system'
end
--4. �� ����, ����� �� ������ - �� ��� ����� ����� ��� ��� �����
else
begin 
	if not exists (select code from Passwords where Password = @password and IsActive = 1 
						and EmployeeCode = @employeeCode)
    --5. �� �� ����, ����� ������ 
	begin
		select @answer = 'User or Password are Wrong! You have 3 more times to enter the system'
	end
	--6. �� ������ �����, ����� �� ������ �� ������ - �� ����� ���
	else 
	begin
		if not exists (select code from Passwords where Password = @password and IsActive = 1 
						and EmployeeCode = @employeeCode and Expiry > GETDATE())
		--7. �� ����� �� ������ ��� - ����� �����
		begin
			select @answer = 'Your Password Expired! Please change your Password'
		end
		--8. ����� ��� ����� ���� ����� �� �����
		else 
		begin 
			if not exists (select code from Times where EmployeeCode = @employeeCode
							and ExitTime is null)
			--9. ����� ��� �����  - ������� ��� ����� �������� ����� ������
			begin 
			insert into Times values(@employeeCode, GETDATE(), null)
			select @answer = 'Entry Time: ' + CONVERT(nvarchar(20), GETDATE(), 3) + ' ' + CONVERT(nvarchar(20), GETDATE(), 108)
			end
			else 
			--10. ������� ��� ����� ����� ������� �������� ����� �����
			begin
				update Times set ExitTime = GETDATE() where EmployeeCode = @employeeCode
					and ExitTime is null
				select @answer = 'Exit Time: ' + CONVERT(nvarchar(20), GETDATE(), 3) + ' ' + CONVERT(nvarchar(20), GETDATE(), 108)
			end
		end
	end
end
select @answer

------------------------------------------------------------------------------------
select * from Times
select * from Passwords
------------------------------------------------------------------------------------

-- ����� ����� ������ �����

-- ����� ������
declare @id nvarchar(10) = '1234', @password nvarchar(10) = '1212', 
@employeeCode int, @answer nvarchar(100), @newPassword nvarchar(10) = '2468'

-- ����� ��� ���� ��� ���� ����
select @employeeCode = (select code from Employees where ID = @id)
-- ����� �� ���� �����
if @employeeCode is null 
begin 
	select @answer = 'User or Password are Wrong!'
end
else
begin
	-- ����� �� ������ ����� ���� ����� ������
	if not exists (select * from Passwords where Password = @password and IsActive = 1 
			and EmployeeCode = @employeeCode)
	begin
		select @answer = 'User or Password are Wrong!'
	end
	else 
	begin
	-- ����� �� ������ ����� ��� ����� ������ ����  
		if exists (select * from Passwords where EmployeeCode = @employeeCode 
					and Password = @newPassword)
		begin 
			select @answer = 'You used this password before. Please enter another password'
		end
		else 
		begin
			-- �� �������� ������� �� ����� ����� ��� ������
			update Passwords set IsActive = 0 where EmployeeCode = @employeeCode
			-- ����� ����� ����
			insert into Passwords values(@employeeCode, @newPassword, GETDATE() + 180, 1)
			select @answer = 'Updating the Password ended successfully. The expiry date is in 180 days'
		end
	end
end
select @answer

----------------------------------------------
-- ���� ���
-- ����� ��� ���� ��� ���� ����
select @employeeCode = (select code from Employees where ID = @id)
-- ����� �� ���� �����
if @employeeCode is null 
begin 
	select @answer = 'User or Password are Wrong!'
end
else
begin
	-- ����� ����� ������ �� ������ ����� ��� ����� ���
	if exists (select code from Passwords where Password = @password and IsActive = 1 
			and EmployeeCode = @employeeCode and Expiry < GETDATE())
	begin
	--����� ������ �� ������ �� ���� ���� ���� ����� �� ������ 
	select @answer = 'Your Password Expired! Please change your Password'
	update Passwords set IsActive = 0  
	where EmployeeCode = @employeeCode

	insert into Passwords values(@employeeCode, @newPassword, GETDATE() + 180, 1)
	select @answer = 'Updating the Password ended successfully'
	end
	else 
	begin
	if exists (select code from Passwords where Password = @password and IsActive = 1 
			and EmployeeCode = @employeeCode and Expiry > GETDATE())
	begin 
		select @answer = 'Your password is up to date'
	end
	end
end

select @answer

--update Passwords set Expiry =  GETDATE() - 1