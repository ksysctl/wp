<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '' );

/** MySQL database username */
define( 'DB_USER', '' );

/** MySQL database password */
define( 'DB_PASSWORD', '' );

/** MySQL hostname */
define( 'DB_HOST', '' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '');
define( 'SECURE_AUTH_KEY',  '');
define( 'LOGGED_IN_KEY',    '');
define( 'NONCE_KEY',        '');
define( 'AUTH_SALT',        '');
define( 'SECURE_AUTH_SALT', '');
define( 'LOGGED_IN_SALT',   '');
define( 'NONCE_SALT',       '');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'xwp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if (getenv( 'WORDPRESS_DEV_MODE') === 'DEV') {
	define( 'WP_DEBUG', true );
	define( 'WP_DEBUG_LOG', '/tmp/wp.debug.log' );
	define( 'WP_DEBUG_DISPLAY', true );
	define( 'SCRIPT_DEBUG', true );
	define( 'SAVEQUERIES', true );
	define( 'QM_DISABLED', false );
	define( 'WP_LOCAL_DEV', true );

	@ini_set('display_errors', 1);
} else {
	define( 'WP_DEBUG', false );
	define( 'WP_DEBUG_LOG', false );
	define( 'WP_DEBUG_DISPLAY', false );
	define( 'SCRIPT_DEBUG', false );
	define( 'SAVEQUERIES', false );
	define( 'QM_DISABLED', true );
	define( 'WP_LOCAL_DEV', false );

	@ini_set('display_errors', 0);
}

// Disable editing from dashboard, it removes the edit_themes, edit_plugins and edit_files capabilities
define( 'DISALLOW_FILE_EDIT', true );
define ( 'GENERATE_HOOKS_DISALLOW_PHP', true );

// Force all logins and all admin sessions to happen over SSL
define( 'FORCE_SSL_ADMIN', true );

// If we're behind a proxy server and using HTTPS, we need to alert WordPress of that fact
// see also http://codex.wordpress.org/Administration_Over_SSL#Using_a_Reverse_Proxy
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
	$_SERVER['HTTPS'] = 'on';
}

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';