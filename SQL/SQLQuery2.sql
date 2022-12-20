-- :העובד מכניס מספר זהות וסיסמא 

--1. הצהרה על משתנים
declare @id nvarchar(10) = '1234', @password nvarchar(10) = '1212', 
@employeeCode int, @answer nvarchar(100)
-------------------------------------------------------------------
--2. בדיקה על מספר זהות - אם קיים
select @employeeCode = (select code from Employees where ID = @id)
--3. אם לא קיים, תשובה שלילית 
if @employeeCode is null 
begin 
	select @answer = 'User or Password are Wrong! You have 3 more times to enter the system'
end
--4. אם קיים, בדיקה על הסיסמא - אם היא קיימת לעובד ואם היא בתוקף
else
begin 
	if not exists (select code from Passwords where Password = @password and IsActive = 1 
						and EmployeeCode = @employeeCode)
    --5. אם לא קיים, תשובה שלילית 
	begin
		select @answer = 'User or Password are Wrong! You have 3 more times to enter the system'
	end
	--6. אם הסיסמא נכונה, בדיקה על התאריך של הסיסמא - על התוקף שלה
	else 
	begin
		if not exists (select code from Passwords where Password = @password and IsActive = 1 
						and EmployeeCode = @employeeCode and Expiry > GETDATE())
		--7. אם התוקף של הסיסמא עבר - החלפת סיסמא
		begin
			select @answer = 'Your Password Expired! Please change your Password'
		end
		--8. בדיקה האם העובד מבצע כניסה או יציאה
		else 
		begin 
			if not exists (select code from Times where EmployeeCode = @employeeCode
							and ExitTime is null)
			--9. במידה וזו כניסה  - מכניסים שעת כניסה ומחזירים תשובה ראשונה
			begin 
			insert into Times values(@employeeCode, GETDATE(), null)
			select @answer = 'Entry Time: ' + CONVERT(nvarchar(20), GETDATE(), 3) + ' ' + CONVERT(nvarchar(20), GETDATE(), 108)
			end
			else 
			--10. מכניסים שעת יציאה בשורה המתאימה ומחזירים תשובה שנייה
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

-- החלפת סיסמא לסיסמא קבועה

-- הצהרת משתנים
declare @id nvarchar(10) = '1234', @password nvarchar(10) = '1212', 
@employeeCode int, @answer nvarchar(100), @newPassword nvarchar(10) = '2468'

-- מציאת קוד עובד לפי מספר זהות
select @employeeCode = (select code from Employees where ID = @id)
-- בדיקה על מספר הזהות
if @employeeCode is null 
begin 
	select @answer = 'User or Password are Wrong!'
end
else
begin
	-- בדיקה על הסיסמא הישנה שהיא נכונה ופעילה
	if not exists (select * from Passwords where Password = @password and IsActive = 1 
			and EmployeeCode = @employeeCode)
	begin
		select @answer = 'User or Password are Wrong!'
	end
	else 
	begin
	-- בדיקה על הסיסמא החדשה שלא הייתה בשימוש בעבר  
		if exists (select * from Passwords where EmployeeCode = @employeeCode 
					and Password = @newPassword)
		begin 
			select @answer = 'You used this password before. Please enter another password'
		end
		else 
		begin
			-- כל הסיסמאות הקודמות של העובד נהפכו ללא פעילות
			update Passwords set IsActive = 0 where EmployeeCode = @employeeCode
			-- הכנסת סיסמא חדשה
			insert into Passwords values(@employeeCode, @newPassword, GETDATE() + 180, 1)
			select @answer = 'Updating the Password ended successfully. The expiry date is in 180 days'
		end
	end
end
select @answer

----------------------------------------------
-- הדרך שלי
-- מציאת קוד עובד לפי מספר זהות
select @employeeCode = (select code from Employees where ID = @id)
-- בדיקה על מספר הזהות
if @employeeCode is null 
begin 
	select @answer = 'User or Password are Wrong!'
end
else
begin
	-- הכנסת סיסמא ובדיקה אם הסיסמא קיימת ואת התוקף שלה
	if exists (select code from Passwords where Password = @password and IsActive = 1 
			and EmployeeCode = @employeeCode and Expiry < GETDATE())
	begin
	--במידה והתוקף של הסיסמא פג צריך לחדש אותה ולבטל את הקודמת 
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