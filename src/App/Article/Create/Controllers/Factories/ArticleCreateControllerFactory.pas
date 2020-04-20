(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit ArticleCreateControllerFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for controller TArticleCreateController
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TArticleCreateControllerFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils,

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    ArticleCreateController;

    function TArticleCreateControllerFactory.build(const container : IDependencyContainer) : IDependency;
    var viewParams : IViewParameters;
        config : IAppConfiguration;
        aview : IView;
    begin
        viewParams := container['viewParams'] as IViewParameters;
        config := container['config'] as IAppConfiguration;
        viewParams['baseUrl'] := config.getString('baseUrl');
        viewParams['appName'] := config.getString('appName');

        aview := container['articlecreateView'] as IView;
        result := TArticleCreateController.create(aview, viewParams);
    end;
end.
