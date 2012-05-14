# Vagrant for heroku-wordpress using librarian

This is vagrant definition for creating stack that helps during development of wordpress.
It is meant to be used together with [wordpress-heroku](https://github.com/mhoofman/wordpress-heroku).


Usage
=========
Create directory "project" and clone there 2 repos

    $ git clone https://github.com/mhoofman/wordpress-heroku
    $ git clone https://github.com/lukasz-kaniowski/vagrant-wordpress-heroku
    $ cd vagrant-wordpress-heroku/
    $ bundle
    $ librarian-chef install
    $ vagrant up

Edit file `wordpress-heroku/wp-config.php`

    if (!$_ENV["DATABASE_URL"]){
        $db = parse_url("postgres://wordpress:wordpress@localhost:5432/wordpress");
    }else {
        $db = parse_url($_ENV["DATABASE_URL"]);
    }

Open your browser to `http://localhost:8080/`

Components
==========
* librarian
* vagrant