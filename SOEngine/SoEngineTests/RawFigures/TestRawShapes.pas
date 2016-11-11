unit TestRawShapes;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, System.Math, uRawShapes, uGeometryClasses, uSoTypes,
  System.Generics.Collections, uTestRawShapesHelpers;

type
  // Test methods for class TRawShape

  TestTRawShape = class(TTestCase)
  strict private
    FRawShape: TRawShape;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCorrectClone;
    procedure TestIncorrectClone;
    procedure TestIsEqualPolyToPoly;
    procedure TestIsNotEqualPolyToPoly;
    procedure TestIsEqualCircleToCircle;
    procedure TestIsNotEqualCircleToCircle;
    procedure TestIsNotEqualPolyToCircle;
    procedure TestGetData;
  end;

  // Test methods for class TRawCircle

  TestTRawCircle = class(TTestCase)
  strict private
    FRawCircle: TRawCircle;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFigureType;
  end;

  // Test methods for class TRawPoly

  TestTRawPoly = class(TTestCase)
  strict private
    FRawPoly: TRawPoly;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCount;
    procedure TestFigureType;
  end;

implementation

procedure TestTRawShape.SetUp;
begin
  FRawShape := TRawCircle.Create(50, 50, 100);
end;

procedure TestTRawShape.TearDown;
begin
  FRawShape.Free;
  FRawShape := nil;
end;

procedure TestTRawShape.TestCorrectClone;
var
  vIsRawFiguresIdentical: Boolean;
  vArr: TArray<TPointF>;
  vSample: TRawShape;

  i: Integer;
begin
  vSample := FRawShape.Clone; //.TRawCircle.Create(50, 50, 100);

  vIsRawFiguresIdentical := TTestShapesHelpers.IsPointArrayEquals(vSample.GetData, FRawShape.GetData);

  vIsRawFiguresIdentical :=
    vIsRawFiguresIdentical and
    (vSample.FigureType = FRawShape.FigureType) and
    (vSample.ClassName = FRawShape.ClassName);

  Check(
    vIsRawFiguresIdentical,
    'Clone in TRawShape works incorrect'
  );
end;

procedure TestTRawShape.TestGetData;
var
  ReturnValue: TArray<TPointF>;
  vData: TArray<TPointF>;
  vRes: Boolean;
  i: Integer;
begin
  ReturnValue := FRawShape.GetData;

  SetLength(vData, 2);
  vData[0] := TPointF.Create(50, 50);
  vData[1] := TPointF.Create(100, 0);
  vRes := True;

  for i := 0 to High(ReturnValue) do
    vRes := vRes and (vData[i] = ReturnValue[i]);

  Check(vRes, 'Data after Creation differs');
end;

procedure TestTRawShape.TestIncorrectClone;
var
  vIsRawFiguresIdentical: Boolean;
  vArr, vSampleArr: TArray<TPointF>;
  vSample: TRawShape;
  i: Integer;
begin
  SetLength(vSampleArr, 2);
  vSampleArr[0] := TPointF.Create(50, 50);
  vSampleArr[1] := TPointF.Create(100, 0);
  vSample := TRawPoly.Create(vSampleArr);

  vIsRawFiguresIdentical := True;
  vArr := FRawShape.GetData;
  for i := 0 to High(vArr) do
    vIsRawFiguresIdentical := vIsRawFiguresIdentical and (vArr[i] = vSample.GetData[i]);

  vIsRawFiguresIdentical := vIsRawFiguresIdentical and (vSample.FigureType = FRawShape.FigureType);

  Check(not vIsRawFiguresIdentical, 'Clone in TRawShape works incorrect. Error in FigureType');
end;

procedure TestTRawShape.TestIsEqualCircleToCircle;
var
  vCircle1, vCircle2: TRawCircle;
begin
  vCircle1 := TTestShapesHelpers.CreateRawCircle(50, -25, 100);
  vCircle2 := TTestShapesHelpers.CreateRawCircle(50, -25, 100);

  Check(
    vCircle1.IsEqualTo(vCircle2),
    'IsEqualTo Method in in TRawShape working incorrect with Circles'
  )
end;

procedure TestTRawShape.TestIsNotEqualCircleToCircle;
var
  vCircle1, vCircle2: TRawCircle;
begin
  vCircle1 := TTestShapesHelpers.CreateRawCircle(50, -25, 100);
  vCircle2 := TTestShapesHelpers.CreateRawCircle(50, -25, 101);

  Check(
     not vCircle1.IsEqualTo(vCircle2),
    'IsEqualTo Method in in TRawShape working incorrect with Circles'
  )
end;

procedure TestTRawShape.TestIsNotEqualPolyToCircle;
var
  vCircle: TRawCircle;
  vPoly: TRawPoly;
begin
  vCircle := TTestShapesHelpers.CreateRawCircle(50, -25, 100);
  vPoly := TTestShapesHelpers.CreateRawPoly([50, -25, 100, 0]);

  Check(
    not vCircle.IsEqualTo(vPoly),
    'IsEqualTo Method in in TRawShape working incorrect with Circles and Poly'
  )
end;

procedure TestTRawShape.TestIsNotEqualPolyToPoly;
var
  vPoly1, vPoly2: TRawPoly;
begin
  vPoly1 := TTestShapesHelpers.CreateRawPoly([-20, -30, 20, -30, 30, 20, -30, 20]);
  vPoly2 := TTestShapesHelpers.CreateRawPoly([-30, -30, 20, -30, 30, 20, -30, 20]);

  Check(
    not vPoly1.IsEqualTo(vPoly2),
    'IsEqualTo Method in in TRawShape working incorrect with Polygons'
  )
end;

procedure TestTRawShape.TestIsEqualPolyToPoly;
var
  vPoly1, vPoly2: TRawPoly;
begin
  vPoly1 := TTestShapesHelpers.CreateRawPoly([-20, -30, 20, -30, 30, 20, -30, 20]);
  vPoly2 := TTestShapesHelpers.CreateRawPoly([-20, -30, 20, -30, 30, 20, -30, 20]);

  Check(
    vPoly1.IsEqualTo(vPoly2),
    'IsEqualTo Method in in TRawShape working incorrect with Polygons'
  )
end;

procedure TestTRawCircle.SetUp;
begin
end;

procedure TestTRawCircle.TearDown;
begin
end;

procedure TestTRawCircle.TestFigureType;
var
  ReturnValue: TFigureType;
  vRawCircle: TRawShape;
begin
  vRawCircle := TRawCircle.Create(-100, 100, 50);
  ReturnValue := vRawCircle.FigureType;
  Check(ReturnValue = ftCircle, 'Error in FigureType in TRawCircle');
end;

procedure TestTRawPoly.SetUp;
begin
  FRawPoly := TTestShapesHelpers.CreateRawPoly([-40, -40, 60, -40, 40, 60, -60, 40]);
end;

procedure TestTRawPoly.TearDown;
begin
  FRawPoly.Free;
  FRawPoly := nil;
end;

procedure TestTRawPoly.TestCount;
var
  ReturnValue: Integer;
begin
  ReturnValue := FRawPoly.Count;
  Check(ReturnValue = 4, 'Error in GetPointCount in TRawPoly');
end;

procedure TestTRawPoly.TestFigureType;
var
  ReturnValue: TFigureType;
begin
  ReturnValue := FRawPoly.FigureType;
  Check(ReturnValue = ftPoly, 'Error in FigureType in TRawPoly');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTRawShape.Suite);
  RegisterTest(TestTRawCircle.Suite);
  RegisterTest(TestTRawPoly.Suite);
end.
