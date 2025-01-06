#!/bin/bash
function create_structure {
    project_name=$1
    
    echo "Creating project directories..."
    mkdir -p "$project_name/app/src/css" "$project_name/app/src/img" "$project_name/app/src/js"

    php_ini_content="; PHP Configuration File
[PHP]
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
post_max_size = 8M
upload_max_filesize = 2M
error_reporting = E_ALL
display_errors = On
log_errors = Off
short_open_tag = On
date.timezone = \"UTC\"
"
    echo -e "$php_ini_content" > "$project_name/php.ini"
    
    env_content="DB_HOST=localhost
DB_USER=root
DB_PASS=password
DB_NAME=your_database_name"
    echo -e "$env_content" > "$project_name/.env"
    
    htaccess_content="# Deny access to .ini and .env files
<FilesMatch \"\.(ini|env)$\">
    Order allow,deny
    Deny from all
</FilesMatch>

# Enable URL rewriting
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^ index.php [QSA,L]
"
    echo -e "$htaccess_content" > "$project_name/.htaccess"
    
    index_php_content="
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Welcome to CasePHP</title>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <link href='https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css' rel='stylesheet'>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            background-color: #ffffff; /* Light background for light theme */
            color: #333; /* Dark text for light theme */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            flex-direction: column;
            overflow: hidden;
            transition: background-color 0.5s, color 0.5s;
        }
        h1 {
            font-size: 2rem;
            color: #00bcd4;
            margin-bottom: 10px;
            letter-spacing: 0.05rem;
        }
        p {
            font-size: 1rem;
            letter-spacing: 0.05rem;
            margin-bottom: 20px;
            color: #555;
        }
        .icon {
            font-size: 4rem;
            color: #00bcd4;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
        }
        .icon:hover {
            color: #0097a7;
        }
        @keyframes bounce {
            0% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0); }
        }
        .button-link {
            color: #00bcd4;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 600;
            transition: color 0.3s;
        }
        .button-link:hover {
            color: #0097a7;
        }
        .theme-switcher {
            background: none;
            border: none;
            font-size: 2rem;
            color: #00bcd4;
            cursor: pointer;
            transition: color 0.3s;
            margin-top: 20px;
        }
        .theme-switcher:hover {
            color: #0097a7;
        }
        footer {
            margin-top: 30px;
            font-size: 0.9rem;
            color: #555;
        }
        body.dark-mode {
            background-color: #121212; 
            color: white; 
        }

        body.dark-mode .icon {
            color: #bb86fc; 
        }

        body.dark-mode .button-link {
            color: #bb86fc; 
        }

        body.dark-mode footer {
            color: #f4f4f4;
        }

        #theme-icon {
            color: #00bcd4;
            font-size: 2rem;
            transition: color 0.3s;
        }
        body.dark-mode #theme-icon {
            color: #bb86fc; 
        }
    </style>
</head>
<body>
    <h1>Welcome to CasePHP!</h1>
    <div class='icon'>
        🚀
    </div>

    <p>Learning frameworks, one step at a time.</p>

    <a href='https://www.linkedin.com/in/amcodecase' target='_blank' class='button-link'>Connect with me on LinkedIn</a>

    <button class='theme-switcher' onclick='toggleTheme()'>
        <i id='theme-icon' class='bi bi-brightness-high'></i> <!-- Sun icon for light theme -->
    </button>

    <footer>
        <p>Building & Learning</p>
    </footer>

    <script>
        function toggleTheme() {
            document.body.classList.toggle('dark-mode');
            const themeSwitcherIcon = document.getElementById('theme-icon');
            if (document.body.classList.contains('dark-mode')) {
                themeSwitcherIcon.classList.remove('bi-brightness-high');
                themeSwitcherIcon.classList.add('bi-moon');
            } else {
                themeSwitcherIcon.classList.remove('bi-moon');
                themeSwitcherIcon.classList.add('bi-brightness-high');
            }
        }
    </script>

</body>
</html>"
    echo -e "$index_php_content" > "$project_name/index.php"
}

read -p "Enter the project name: " project_name
mkdir "$project_name"
cd "$project_name" || exit
echo "Setting up project '$project_name'..."
create_structure "$project_name"
echo "Project '$project_name' setup complete!"

echo -e "\nNext steps:
1. You can now start adding your project files to the respective directories.
2. Update the '.env' file with your actual database credentials.
3. Customize the 'php.ini' and '.htaccess' files as needed.
4. Begin development by adding content to 'index.php'.
"
