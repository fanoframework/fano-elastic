(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit ArticleUpdateController;

interface

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /article/update
     *
     * See Routes/Article/Create/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TArticleUpdateController = class(TController)
    private
        fDetailModel : IModelReader;
        fParams : IModelParams;
    public
        constructor create(
            const view : IView;
            const params : IViewParameters;
            const detail : IModelReader;
            const modelParam : IModelParams
        );

        destructor destroy(); override;

        (*!-------------------------------------------
         * handle request
         *--------------------------------------------
         * @param request object represent current request
         * @param response object represent current response
         * @param args object represent current route arguments
         * @return new response
         *--------------------------------------------*)
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;

    end;

implementation

    constructor TArticleUpdateController.create(
        const view : IView;
        const params : IViewParameters;
        const detail : IModelReader;
        const modelParam : IModelParams
    );
    begin
        inherited create(view, params);
        fDetailModel := detail;
        fParams := modelParam;
    end;

    destructor TArticleUpdateController.destroy();
    begin
        fDetailModel := nil;
        fParams := nil;
        inherited destroy();
    end;

    (*!-------------------------------------------
     * handle request
     *--------------------------------------------
     * @param request object represent current request
     * @param response object represent current response
     * @param args object represent current route arguments
     * @return new response
     *--------------------------------------------*)
    function TArticleUpdateController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    var res : IModelResultSet;
    begin
        fParams.writeString('id', args['id']);
        res := fDetailModel.read(fParams);
        if res.count() > 0 then
        begin
            fViewParams['title'] := res.readString('name');
            fViewParams['author'] := res.readString('author');
            fViewParams['tags'] := res.readString('tags');
            fViewParams['content'] := res.readString('content');
            result := inherited handleRequest(request, response, args);
        end else
        begin
            raise ENotFound.createFmt('Article not found %s', [args['id']])
        end;

    end;

end.
