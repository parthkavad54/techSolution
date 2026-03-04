# Troubleshooting Guide

## Common Issues and Solutions

### 1. React Router Warnings

**Issue:** 
```
⚠️ React Router Future Flag Warning: React Router will begin wrapping state updates in `React.startTransition` in v7
```

**Solution:** 
- Fixed by adding future flags to Router in `App.js`
- These are just warnings and don't affect functionality
- The flags have been added to prepare for React Router v7

### 2. 403 Forbidden on Signup

**Issue:** Getting 403 error when trying to sign up

**Possible Causes:**
- Trying to sign up as 'employee' role (not allowed)
- Form default role was set to 'employee'

**Solution:**
- Fixed: Default role is now 'admin'
- Only Admin and HR roles can self-register
- First user can be created with any role (for initial setup)
- Employees must be created by Admin/HR through "Create Employee" page

### 3. 401 Unauthorized on Signin

**Issue:** Getting 401 error when trying to sign in

**Possible Causes:**
- Wrong email/employee ID or password
- Email case sensitivity
- User doesn't exist in database
- MongoDB connection issue

**Solutions:**
- Check that email/employee ID and password are correct
- Email is now case-insensitive (automatically converted to lowercase)
- Verify user exists in database
- Check MongoDB connection in backend logs
- Ensure backend server is running on port 5000
- Check `.env` file has correct MongoDB URI

### 4. First Admin Can't Login

**Issue:** After creating first admin account, can't login

**Possible Causes:**
- Password was hashed incorrectly
- User wasn't saved to database
- MongoDB connection issue during signup

**Solutions:**
- Check backend logs for errors during signup
- Verify MongoDB is connected (check backend console)
- Try creating the admin account again
- Check that password meets requirements (min 6 characters)
- Verify `.env` file has correct MongoDB URI

### 5. Email Not Sending

**Issue:** Employee credentials email not being sent

**Possible Causes:**
- Email credentials not configured in `.env`
- Gmail app password not set up correctly
- Email service error

**Solutions:**
- Check `EMAIL_USER` and `EMAIL_PASS` in backend `.env`
- Verify Gmail app password is correct (16 characters, no spaces)
- Check backend logs for email errors
- Employee creation will still work, temporary password is shown in response
- You can manually share the temporary password with employee

### 6. Password Change Not Working

**Issue:** Can't change password on first login

**Possible Causes:**
- Temporary password incorrect
- Password change endpoint error
- Network/CORS issue

**Solutions:**
- Verify temporary password from email or admin response
- Check browser console for errors
- Ensure backend is running
- Check that `mustChangePassword` flag is true for employee

### 7. MongoDB Connection Error

**Issue:** Backend can't connect to MongoDB

**Possible Causes:**
- MongoDB Atlas connection string incorrect
- IP address not whitelisted
- Database user credentials wrong
- Network/firewall issue

**Solutions:**
- Verify MongoDB Atlas connection string format:
  ```
  mongodb+srv://username:password@cluster.mongodb.net/dayflow?retryWrites=true&w=majority
  ```
- Check IP whitelist in MongoDB Atlas (add 0.0.0.0/0 for all IPs during development)
- Verify database user has correct permissions
- Test connection string in MongoDB Compass
- Check backend console for specific error message

### 8. CORS Errors

**Issue:** Frontend can't connect to backend API

**Possible Causes:**
- Backend not running
- Wrong API URL in frontend
- CORS not configured

**Solutions:**
- Ensure backend is running on port 5000
- Check `REACT_APP_API_URL` in frontend `.env` (defaults to http://localhost:5000/api)
- Verify backend CORS is enabled (already configured)
- Check browser console for specific CORS error

### 9. Token/Authorization Errors

**Issue:** Getting unauthorized errors after login

**Possible Causes:**
- Token not stored correctly
- Token expired
- JWT_SECRET mismatch

**Solutions:**
- Clear browser localStorage and login again
- Check that token is being stored: `localStorage.getItem('token')`
- Verify `JWT_SECRET` in backend `.env` is set
- Token expires after 7 days, login again if expired

### 10. Page Not Found / Routing Issues

**Issue:** Getting 404 or wrong page after navigation

**Possible Causes:**
- React Router configuration issue
- Protected route access without login

**Solutions:**
- Ensure you're logged in before accessing protected routes
- Check that routes are defined in `App.js`
- Verify user role matches route requirements (admin routes need admin/HR role)

## Debugging Steps

1. **Check Backend Logs:**
   - Look at terminal where backend is running
   - Check for error messages
   - Verify MongoDB connection message

2. **Check Frontend Console:**
   - Open browser DevTools (F12)
   - Check Console tab for errors
   - Check Network tab for failed requests

3. **Verify Environment Variables:**
   - Backend `.env` file exists and has all variables
   - Frontend `.env` file (optional, has defaults)
   - Values are correct (no extra spaces, correct format)

4. **Test API Endpoints:**
   - Use Postman or curl to test backend directly
   - Check `/api/health` endpoint works
   - Test signup/signin endpoints

5. **Database Verification:**
   - Check MongoDB Atlas dashboard
   - Verify database and collection exist
   - Check if users are being created

## Still Having Issues?

1. Clear browser cache and localStorage
2. Restart both backend and frontend servers
3. Check all environment variables are set correctly
4. Verify MongoDB connection
5. Review error messages in console/logs for specific details

