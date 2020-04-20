(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)

router.get('/article/update/{id}', container['article.update.controller'] as IRequestHandler);
//router.post('/article/update/{id}', container['article.update.submit.controller'] as IRequestHandler);
