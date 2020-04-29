/* Revisions */
DELETE FROM xwp_posts WHERE post_type = 'revision';
/* Auto drafts */
DELETE FROM xwp_posts WHERE post_status = 'auto-draft';
/*  Trashed posts */
DELETE FROM xwp_posts WHERE post_status = 'trash';
/* Pending comments */
DELETE FROM xwp_comments WHERE comment_approved = '0';
/* Spam comments */
DELETE FROM xwp_comments WHERE comment_approved = 'trash';
/* Trashed comments */
DELETE FROM xwp_comments WHERE comment_approved = 'spam';
/* Pingbacks */
DELETE FROM xwp_comments WHERE comment_type = 'pingback';
/* Trackbacks */
DELETE FROM xwp_comments WHERE comment_type = 'trackback';
/* Orphaned post meta */
DELETE pm FROM xwp_postmeta pm LEFT JOIN xwp_posts wp ON wp.ID = pm.post_id WHERE wp.ID IS NULL;
/* Orphaned comment meta */
DELETE FROM xwp_commentmeta WHERE comment_id NOT IN (SELECT comment_id FROM xwp_comments);
/* Orphaned user meta */
DELETE FROM xwp_usermeta WHERE user_id NOT IN (SELECT ID FROM xwp_users);
/* Orphaned term meta */
DELETE FROM xwp_termmeta WHERE term_id NOT IN (SELECT term_id FROM xwp_terms);
/* Orphaned relationships */
DELETE FROM xwp_term_relationships WHERE term_taxonomy_id=1 AND object_id NOT IN (SELECT id FROM xwp_posts);
/* Expired transients */
DELETE FROM xwp_options WHERE option_name = '_site_transient_theme_roots';
DELETE FROM xwp_options WHERE option_name = '_site_transient_timeout_theme_roots';
/* Clean cerber logs */
TRUNCATE TABLE cerber_log;
TRUNCATE TABLE cerber_traffic;