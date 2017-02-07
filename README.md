# 3D-nonLTE
Circinus galaxyのRadiation driven fountain modelをもとに、molecular lineを3D nonLTEコードで計算する 

- astrophys-kagoshima/3D-nonLTEを福重がいじったもの(2/7)



## パラメータ

- cppで必要なパラメータを与えるようになっている。

  `#define NG 128`   計算グリッド数：x, y方向。入力データ（後述）に合わせる

  `#define NG 128`   計算グリッド数：z方向

  `#define INFILENAME 'pma0129_nonlte128.data'`  入力データ（これは、Circinusモデル pma0129を128^3に落としたもの）

  `#define OUTDIR '/work2/nonlte/result/'`　	出力データ用directry

  `#define CCOEFF 'CO-H2para.dat'`    分子データ。これはCO用

  `#define NRAY 100`  Rayの数。その下の`NRAY0`と同じ値に。

  `#define LEVMAX 5`  計算するlevel数

  `#define LOOPMAX 5`  iterationの数

  `#define TABLEMAX 40`  CCOEFFの中に書いてある表の温度binの数。CCOEFFを変えたら、ここの値も変わる

  `#define NLEVMAX 29`  CCOEFFの中に書いてある表level数。CCOEFFを変えたら、ここの値も変わる


# 実行(とりあえずPC用）

`% make -f mpi_makefile.7.8 clean`  余計なファイル消去

`% make -f mpi_makefile.7.8`  コンパイル

`PC:% mpirun -n 8  ./yamada.out`  PC上で８コア並列で実行

- ログを取る場合は、

`PC:% (mpirun -n 8  ./yamada.out ) >& test.log & `  PC上で８コア並列で実行

# 結果確認

- 001nlev.d, 002nlev.d, .... とiterationの数だけlevel populationが出力される

# 結果の可視化
* ここはオリジナルコードでは最後はIDLを使うので、matplotlibを使うようにしなければならない。

*
 `getspectrum/getspectrum14*.F`  を使う。オリジナルのgetspectrum1423.Fにはバグがあったので修正。common文をやめてmoduleに
書き換えた（KW)

 `#define LEVD '006nlev.d`  ここで、上で出力された　*nlev.d を指定。

 `#define VIEWANGLE 45 `  観測するviewing angleを指定

 `#define NRAY 100`
 ` #define LEVMAX 5`  Rayの数と計算するlevel数を指定。

 `#define NCHANNEL 50`  速度方向のbinの数（チャンネル数）

 - `PC:% make -f makefile_spect`

 - `PC:% ./getspectrum14*`   



# 注意

- 計算時間は、NRAY, LOOPMAX, LEVMAX によって変わる。テスト計算ではNRAY, LOOPMAXを小さめにとること。

- getspectrumは、計算時間は数分。

- コア数を多くすると、最初に各コアから同じ標準出力がでてきて、ログがうっとおしいが、` if(Myrank == 0)then ... endif ` で囲むと１つだけ出る。


# 追記(2/7)

- main7.8.Fを実行するとgetspectrum/に00*nlev.dが出力される

-getspectrum/getspectrum14*.Fを実行するとspnlev.b(積分強度)、sp*.cube(チャンネルマップ)等が出力される

-出力データと流体データ(pma0129_nonlte128.data)は容量が100MBを越えることがあるのでgitでaddしてはいけない
