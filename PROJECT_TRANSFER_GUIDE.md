# Food Ordering System - Project Transfer Guide

## 📋 Project Overview

**Project Name:** Food Ordering System  
**Framework:** Django 4.2.7  
**Database:** PostgreSQL  
**Developed By:** [Your Name]  
**Transfer Date:** December 2025  

### 🎯 Project Purpose
A comprehensive restaurant management system with QR code ordering, table management, kitchen operations, and payment integration.

---

## 🗂️ Project Structure

```
food ordering system/
├── manage.py                    # Django management script
├── requirements.txt             # Python dependencies
├── .env.example                 # Environment variables template
├── docker-compose.yml           # Docker configuration
├── Dockerfile                   # Docker image configuration
├── setup.bat                    # Windows setup script
├── food_ordering/              # Main Django project
│   ├── settings.py             # Project settings
│   ├── urls.py                 # Main URL configuration
│   └── wsgi.py                 # WSGI configuration
├── accounts/                   # User authentication system
├── menu/                       # Menu management
├── orders/                     # Order processing
├── restaurant/                 # Restaurant management
├── customer/                   # Customer features
├── core/                       # Core utilities
├── templates/                  # HTML templates
├── static/                     # Static files (CSS, JS, images)
├── media/                      # User uploaded files
└── docs/                       # Documentation
```

---

## 🛠️ Technology Stack

### Backend
- **Framework:** Django 4.2.7
- **Database:** PostgreSQL (psycopg2-binary)
- **Server:** Gunicorn
- **Authentication:** Django's built-in auth system

### Frontend
- **Styling:** Tailwind CSS
- **JavaScript:** Vanilla JS with AJAX
- **Templates:** Django Template Engine

### Third-Party Integrations
- **Payment:** Razorpay
- **SMS:** Twilio
- **QR Codes:** qrcode library
- **PDF Generation:** ReportLab

### Security Features
- Django Axes for brute force protection
- Rate limiting
- Content Security Policy
- Environment variable management

---

## 📦 Installation Guide

### Prerequisites
- Python 3.8 or higher
- PostgreSQL 17 or higher
- Git
- Virtual environment (recommended)

### Step 1: Clone Repository
```bash
git clone <repository-url>
cd "food ordering system"
```

### Step 2: Create Virtual Environment
```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Linux/Mac
python3 -m venv venv
source venv/bin/activate
```

### Step 3: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 4: Environment Setup
```bash
# Copy environment template
copy .env.example .env

# Edit .env file with your settings
```

### Step 5: Database Setup
```bash
# Create PostgreSQL database
createdb food_ordering_db

# Run migrations
python manage.py makemigrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Load initial data (optional)
python manage.py loaddata initial_data.json
```

### Step 6: Collect Static Files
```bash
python manage.py collectstatic
```

### Step 7: Run Development Server
```bash
python manage.py runserver
```

---

## 🚀 Quick Start (Windows)

Run the provided batch file:
```bash
setup.bat
```

This will:
1. Create virtual environment
2. Install dependencies
3. Guide you through environment setup
4. Run initial migrations

---

## 🔧 Configuration

### Environment Variables (.env)
```env
# Database
DB_NAME=food_ordering_db
DB_USER=postgres
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432

# Django Settings
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Email Settings
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password

# Razorpay (if using)
RAZORPAY_KEY_ID=your-razorpay-key
RAZORPAY_KEY_SECRET=your-razorpay-secret

# Twilio (if using SMS)
TWILIO_ACCOUNT_SID=your-twilio-sid
TWILIO_AUTH_TOKEN=your-twilio-token
TWILIO_PHONE_NUMBER=your-twilio-number
```

---

## 📊 Database Schema

### Core Models
1. **User (Django's built-in)**
   - Staff, Manager, Customer roles

2. **MenuItem**
   - Name, description, price, category, image

3. **Order**
   - Table number, items, total amount, status

4. **TableOrder**
   - Table-specific orders with QR codes

5. **RestaurantProfile**
   - Restaurant settings and configurations

### Key Relationships
- User → Orders (One-to-Many)
- Order → OrderItems (One-to-Many)
- MenuItem → OrderItems (One-to-Many)
- Table → TableOrders (One-to-Many)

---

## 🔐 Security Considerations

1. **Environment Variables**
   - Never commit .env file
   - Use strong secret keys
   - Rotate keys periodically

2. **Database Security**
   - Use strong passwords
   - Limit database user permissions
   - Enable SSL in production

3. **API Security**
   - Implement rate limiting
   - Use HTTPS in production
   - Validate all inputs

4. **File Uploads**
   - Limit file types and sizes
   - Scan uploads for malware
   - Store outside web root

---

## 🧪 Testing

### Run Tests
```bash
# Run all tests
python manage.py test

# Run specific app tests
python manage.py test orders
python manage.py test menu

# Run with coverage
pip install coverage
coverage run --source='.' manage.py test
coverage report
```

### Test Coverage Areas
- User authentication
- Order processing
- Payment integration
- QR code generation
- Email notifications

---

## 📝 Deployment

### Production Checklist
1. Set `DEBUG=False`
2. Configure `ALLOWED_HOSTS`
3. Set up production database
4. Configure static file serving
5. Set up SSL certificate
6. Configure domain and DNS
7. Set up monitoring and logging
8. Backup strategy

### Docker Deployment
```bash
# Build image
docker build -t food-ordering .

# Run with docker-compose
docker-compose up -d
```

### Heroku Deployment
```bash
# Install Heroku CLI
heroku create your-app-name
heroku config:set DEBUG=False
git push heroku main
heroku run python manage.py migrate
heroku run python manage.py createsuperuser
```

---

## 🐛 Common Issues & Solutions

### Issue: ModuleNotFoundError
**Solution:** Activate virtual environment and install requirements

### Issue: Database connection error
**Solution:** Check PostgreSQL service and .env configuration

### Issue: Static files not loading
**Solution:** Run `collectstatic` and check STATIC_URL settings

### Issue: Permission denied
**Solution:** Check file permissions and database user privileges

---

## 📞 Support & Maintenance

### Regular Tasks
1. Update dependencies: `pip install --upgrade -r requirements.txt`
2. Backup database regularly
3. Monitor logs for errors
4. Update security patches
5. Review and optimize queries

### Contact Information
- Developer: [Your Email]
- Documentation: Check `docs/` folder
- Issues: Create GitHub issue

---

## 📚 Additional Documentation

- `INSTALLATION_DEPLOYMENT_GUIDE.md` - Detailed setup guide
- `FOOD_ORDERING_SYSTEM_COMPLETE_DOCUMENTATION.md` - Full system documentation
- `ENCRYPTION_SECURITY_DOCUMENTATION.md` - Security implementation
- `API_DOCUMENTATION.md` - API endpoints guide

---

## 🔄 Version History

- **v1.0** - Initial release with basic ordering
- **v2.0** - Added QR code ordering
- **v3.0** - Payment integration
- **v4.0** - Enhanced security features
- **v5.0** - Mobile optimization and analytics

---

## 📋 Handover Checklist

- [ ] Source code transferred
- [ ] Database backup provided
- [ ] Environment variables documented
- [ ] Deployment credentials shared
- [ ] Documentation reviewed
- [ ] Training completed
- [ ] Support contact established

---

**Project successfully transferred!** 🎉

For any questions or issues, refer to the documentation or contact the development team.
