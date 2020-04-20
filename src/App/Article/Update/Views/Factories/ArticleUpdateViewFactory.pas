(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit ArticleUpdateViewFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TArticleCreateView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TArticleUpdateViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils;

    function TArticleUpdateViewFactory.build(const container : IDependencyContainer) : IDependency;
    var fileReader : IFileReader;
        headerAndContentView, contentView : IView;
    begin
        fileReader := container.get('fileReader') as IFileReader;
        contentView := TView.create(
            container.get('templateParser') as ITemplateParser,
            fileReader.readFile(
                getCurrentDir() + '/resources/Templates/update-article.html'
            )
        );
        //TCompositeView can only compose from two views
        //We need to display three views: header part, main content, and footer
        //so we need to daisy-chained two composite view
        headerAndContentView := TCompositeView.create(
            container.get('headerView') as IView,
            contentView
        );
        result := TCompositeView.create(
            headerAndContentView,
            container.get('footerView') as IView
        );
    end;
end.
