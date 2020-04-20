(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit ArticleDetailModel;

interface

{$MODE OBJFPC}
{$H+}

uses

    fpjson,
    fano;

type

    (*!-----------------------------------------------
     * model instance
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TArticleDetailModel = class(TInjectableObject, IModelReader, IModelResultSet)
    private
        apiBaseUrl : string;
        fHttpClient : IHttpGetClient;
        jsonData : TJSONData;
        currentData : TJSONData;
        cursorptr : integer;
    public
        constructor create(
            const baseUrl : string;
            const httpGet : IHttpGetClient
        );
        destructor destroy(); override;

        function read(const data : IModelParams) : IModelResultSet;
        (*!----------------------------------------------
         * return data instance after read() is execute
         *-----------------------------------------------
         * @return model data
         *-----------------------------------------------*)
        function data() : IModelResultSet;

        (*!------------------------------------------------
         * get total data
         *-----------------------------------------------
         * @return total data
         *-----------------------------------------------*)
        function count() : int64;

        (*!------------------------------------------------
         * test if in end of result set
         *-----------------------------------------------
         * @return true if no more record
         *-----------------------------------------------*)
        function eof() : boolean;

        (*!------------------------------------------------
         * move data pointer to next record
         *-----------------------------------------------
         * @return true if successful, false if no more record
         *-----------------------------------------------*)
        function next() : boolean;

        (*!------------------------------------------------
         * read data from current active record by its name
         *-----------------------------------------------
         * @return value in record
         *-----------------------------------------------*)
        function readString(const key : string) : string;
    end;

implementation

uses

    Classes,
    SysUtils,
    jsonparser;

    constructor TArticleDetailModel.create(
        const baseUrl : string;
        const httpGet : IHttpGetClient
    );
    begin
        apiBaseUrl := baseUrl;
        fHttpClient := httpGet;
        jsonData := nil;
        currentData := nil;
    end;

    destructor TArticleDetailModel.destroy();
    begin
        fHttpClient := nil;
        currentData := nil;
        freeAndNil(jsonData);
        inherited destroy();
    end;

    function TArticleDetailModel.read(const data : IModelParams) : IModelResultSet;
    var response : IResponseStream;
    begin
        if (assigned(jsonData)) then
        begin
            freeAndNil(jsonData);
        end;

        response := fHttpClient.get(apiBaseUrl + '/_doc/' + data.readString('id'));
        jsonData := getJSON(response.read());
        cursorptr := -1;
        currentData := nil;
        if assigned(jsonData) and jsonData.findPath('found').AsBoolean then
        begin
            cursorptr := 0;
            currentData := jsonData.FindPath('_source');
        end;
        result := self;
    end;

    (*!----------------------------------------------
     * return data instance after read() is execute
     *-----------------------------------------------
     * @return model data
     *-----------------------------------------------*)
    function TArticleDetailModel.data() : IModelResultSet;
    begin
        result := self;
    end;

    (*!------------------------------------------------
     * get total data
     *-----------------------------------------------
     * @return total data
     *-----------------------------------------------*)
    function TArticleDetailModel.count() : int64;
    begin
        if (cursorptr = 0) then
            result := 1
        else
            result := 0;
    end;

    (*!------------------------------------------------
     * test if in end of result set
     *-----------------------------------------------
     * @return true if no more record
     *-----------------------------------------------*)
    function TArticleDetailModel.eof() : boolean;
    begin
        result := true;
    end;

    (*!------------------------------------------------
     * move data pointer to next record
     *-----------------------------------------------
     * @return true if successful, false if no more record
     *-----------------------------------------------*)
    function TArticleDetailModel.next() : boolean;
    begin
        result := false;
    end;

    (*!------------------------------------------------
     * read data from current active record by its name
     *-----------------------------------------------
     * @return value in record
     *-----------------------------------------------*)
    function TArticleDetailModel.readString(const key : string) : string;
    var tags : TJSONData;
        i : integer;
    begin
        if not assigned(currentData) then
        begin
            result := '';
            exit;
        end;

        if (key = 'tags') then
        begin
            result := '';
            tags := currentData.findPath(key);

            if assigned(tags) and (tags.count > 0) then
            begin
                for i := 0 to tags.Count-2 do
                begin
                    result := result + tags.items[i].asString + ',';
                end;
                result := result + tags.items[tags.count-1].asString;
            end;
        end else
        begin
            result := currentData.findPath(key).AsString;
        end;
    end;
end.
