unit uIView;

interface

uses
  FMX.Objects, System.Types, FMX.Graphics, FMX.Types,
  uSSBTypes, uIItemView;

type
  ISSBView = interface
    function AddElement: ISSBViewElement;
    procedure RemoveElement(const AElement: ISSBViewElement);
    procedure SelectElement(const AElement: ISSBViewElement);
    function GetMousePos: TPoint;
    function ElementUnderMouse: ISSBViewElement;
    procedure ClearAndFreeImg;
    procedure SetBackground(const AImg: TImage);
    property MousePos: TPoint read GetMousePos;
    function FilenameFromDlg: string;
    procedure ChangeImageMouseDownHandler(const AHandler: TMouseEvent);
    procedure ChangeImageMouseUpHandler(const AHandler: TMouseEvent);
    procedure ChangeImageMouseMoveHandler(const AHandler: TMouseMoveEvent);
  end;

implementation

end.