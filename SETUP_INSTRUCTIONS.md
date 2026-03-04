# Dayflow HRMS - Setup Instructions

## Environment Variables Setup

### Backend (.env file)

The `.env` file has been created in the `backend` folder. You need to update it with your actual values:

```env
PORT=5000
MONGODB_URI=mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/dayflow?retryWrites=true&w=majority
JWT_SECRET=change_this_to_a_strong_random_secret_key_minimum_32_characters_long
NODE_ENV=development
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_app_password_here
FRONTEND_URL=http://localhost:3000
```

#### How to get MongoDB Atlas URI:

1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a free account or sign in
3. Create a new cluster (free tier available)
4. Click "Connect" on your cluster
5. Choose "Connect your application"
6. Copy the connection string
7. Replace `<password>` with your database user password
8. Replace `<dbname>` with `dayflow` or your preferred database name
9. Paste it in `MONGODB_URI` in the `.env` file

#### How to get Gmail App Password (for email):

1. Go to your Google Account settings
2. Enable 2-Step Verification
3. Go to "App passwords" (under Security)
4. Generate a new app password for "Mail"
5. Copy the 16-character password
6. Paste it in `EMAIL_PASS` in the `.env` file
7. Put your Gmail address in `EMAIL_USER`

**Note:** For production, use a dedicated email service like SendGrid, Mailgun, or AWS SES.

#### JWT Secret:

Generate a strong random string (minimum 32 characters). You can use:
- Online generator: https://randomkeygen.com/
- Or run: `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"`

### Frontend (.env file - Optional)

Create a `.env` file in the `frontend` folder if you need to change the API URL:

```env
REACT_APP_API_URL=http://localhost:5000/api
```

## Important Changes Made

### 1. Employee Creation Flow

- **Employees can ONLY be created by Admin/HR** through the "Create Employee" page
- When an employee is created:
  - A temporary password is automatically generated
  - Credentials are sent to the employee's email
  - Employee must change password on first login

### 2. Sign Up Restriction

- Regular signup is now **only for Admin/HR roles**
- Employees cannot self-register
- Employees receive their credentials via email from admin

### 3. First Login Flow

- When an employee logs in with temporary password:
  - They are immediately prompted to change password
  - Cannot access the system until password is changed
  - After changing password, they can login normally

### 4. Login Options

- Users can login with either:
  - Email + Password
  - Employee ID + Password

## Setup Steps

1. **Update Backend .env file:**
   - Set MongoDB Atlas connection string
   - Set email credentials (Gmail app password)
   - Set a strong JWT_SECRET

2. **Install dependencies:**
   ```bash
   cd backend
   npm install
   
   cd ../frontend
   npm install
   ```

3. **Start MongoDB** (if using local MongoDB) or ensure MongoDB Atlas is accessible

4. **Start Backend:**
   ```bash
   cd backend
   npm start
   ```

5. **Start Frontend:**
   ```bash
   cd frontend
   npm start
   ```

6. **Create First Admin Account:**
   - Go to http://localhost:3000
   - Click "Sign Up"
   - Create an Admin or HR account
   - Sign in

7. **Create Employees:**
   - After signing in as Admin/HR
   - Go to "Create Employee" from the navigation
   - Fill in employee details
   - Employee will receive email with credentials

## Testing Email Functionality

If email is not configured or you want to test without email:

1. The employee creation will still work
2. The temporary password will be shown in the response
3. You can manually share this password with the employee
4. Employee can still login and change password

## Troubleshooting

### Email Not Sending
- Check Gmail app password is correct
- Ensure 2-Step Verification is enabled
- Check email credentials in `.env`
- Check server logs for email errors

### MongoDB Connection Error
- Verify MongoDB Atlas connection string
- Check IP whitelist in MongoDB Atlas (add 0.0.0.0/0 for all IPs during development)
- Verify database user credentials

### Password Change Not Working
- Ensure user is logged in
- Check that current password is correct
- Verify new password meets requirements (min 6 characters)

