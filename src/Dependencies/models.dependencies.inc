(*!------------------------------------------------------------
 * Fano Framework Elasticsearch Sample Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-elasticsearch
 * @copyright Copyright (c) 2019 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-elasticsearch/blob/master/LICENSE (GPL-3.0)
 *------------------------------------------------------------- *)

{%dependencies.inc}

{---put your dependencies registration here---}
container.add('httpGet',TFpcHttpGetFactory.create());
container.add('httpPost',TFpcHttpPostFactory.create());

container.add('articleModel', TArticleModelFactory.create());
container.add('articleParams', TArticleParamsFactory.create());

container.add('articleCreateModel', TArticleCreateModelFactory.create());
container.factory('articleCreateParams', TArticleCreateParamsFactory.create(TModelParamsFactory.create()));
container.add('article.model.detail', TArticleDetailModelFactory.create());
