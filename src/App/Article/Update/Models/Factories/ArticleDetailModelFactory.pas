(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit ArticleDetailModelFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for model TArticleDetailModel
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TArticleDetailModelFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    ArticleDetailModel;

    function TArticleDetailModelFactory.build(const container : IDependencyContainer) : IDependency;
    var config : IAppConfiguration;
    begin
        config := container['config'] as IAppConfiguration;
        result := TArticleDetailModel.create(
            config.getString('elasticsearch.url') + config.getString('elasticsearch.index'),
            container['httpGet'] as IHttpGetClient
        );
    end;
end.
