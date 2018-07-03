# For MARS
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'mars',
        'HOST': 'testdb',
        'PORT': '5432',
        'USER': 'django',
        'PASSWORD': 'djangotest',
    },
    'archive': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'metadata',
        'HOST': 'testdb',
        'PORT': '5432',
        'USER': 'django',
        'PASSWORD': 'djangotest',
    },
}
LOCAL_SETTINGS = 'TEST'
ALLOWED_HOSTS = ['*']
DEBUG=True
