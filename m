From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: Cross compiling
Date: Tue, 30 May 2006 17:28:47 -0300
Message-ID: <ae36f8040605301328k383fc39cwabf787bf036e9c19@mail.gmail.com>
References: <ae36f8040605301328w5a0fd79era435ab0c9290e861@mail.gmail.com>
Reply-To: lvcargnini@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040605301328w5a0fd79era435ab0c9290e861@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

i forget to put the following (line error)
make[1]: Entering directory `/home/lvcargnini/puc/instramed/audio/speex-
1.0.5/src'
if arm-linux-gcc -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARNAME=3D\"\"
-DPACKAGE_VERSION=3D\"\" -DPACKAGE_STRING=3D\"\" -DPACKAGE_BUGREPORT=3D\"\"
-DSTDC_HEADERS=3D1 -DHAVE_SYS_TYPES_H=3D1 -DHAVE_SYS_STAT_H=3D1 -DHAVE_STDL=
IB_H=3D1
-DHAVE_STRING_H=3D1 -DHAVE_MEMORY_H=3D1 -DHAVE_STRINGS_H=3D1 -DHAVE_INTTYPE=
S_H=3D1
-DHAVE_STDINT_H=3D1 -DHAVE_UNISTD_H=3D1 -DHAVE_DLFCN_H=3D1
-DHAVE_SYS_SOUNDCARD_H=3D1 -DHAVE_LIBOGG=3D1 -DHAVE_LIBM=3D1 -DSPEEX_VERSIO=
N=3D\"
1.0.5\" -DSPEEX_MAJOR_VERSION=3D1 -DSPEEX_MINOR_VERSION=3D0
-DSPEEX_MICRO_VERSION=3D5 -DSPEEX_EXTRA_VERSION=3D\"\"  -I. -I. -I../includ=
e
-I../libspeex  -I/home/lvcargnini/puc/instramed/filesys/usr/include    -g
-O2 -MT speexenc.o -MD -MP -MF ".deps/speexenc.Tpo" -c -o speexenc.o
speexenc.c; \
        then mv -f ".deps/speexenc.Tpo" ".deps/speexenc.Po"; else rm -f
".deps/speexenc.Tpo"; exit 1; fi
if arm-linux-gcc -DPACKAGE_NAME=3D\"\" -DPACKAGE_TARNAME=3D\"\"
-DPACKAGE_VERSION=3D\"\" -DPACKAGE_STRING=3D\"\" -DPACKAGE_BUGREPORT=3D\"\"
-DSTDC_HEADERS=3D1 -DHAVE_SYS_TYPES_H=3D1 -DHAVE_SYS_STAT_H=3D1 -DHAVE_STDL=
IB_H=3D1
-DHAVE_STRING_H=3D1 -DHAVE_MEMORY_H=3D1 -DHAVE_STRINGS_H=3D1 -DHAVE_INTTYPE=
S_H=3D1
-DHAVE_STDINT_H=3D1 -DHAVE_UNISTD_H=3D1 -DHAVE_DLFCN_H=3D1
-DHAVE_SYS_SOUNDCARD_H=3D1 -DHAVE_LIBOGG=3D1 -DHAVE_LIBM=3D1 -DSPEEX_VERSIO=
N=3D\"
1.0.5\" -DSPEEX_MAJOR_VERSION=3D1 -DSPEEX_MINOR_VERSION=3D0
-DSPEEX_MICRO_VERSION=3D5 -DSPEEX_EXTRA_VERSION=3D\"\"  -I. -I. -I../includ=
e
-I../libspeex  -I/home/lvcargnini/puc/instramed/filesys/usr/include    -g
-O2 -MT wav_io.o -MD -MP -MF ".deps/wav_io.Tpo" -c -o wav_io.o wav_io.c; \
        then mv -f ".deps/wav_io.Tpo" ".deps/wav_io.Po"; else rm -f
".deps/wav_io.Tpo"; exit 1; fi
/bin/sh ../libtool --mode=3Dlink arm-linux-gcc  -g -O2   -o speexenc
speexenc.o wav_io.o ../libspeex/libspeex.la
-L/home/lvcargnini/puc/instramed/filesys/usr/lib -logg -lm
mkdir .libs
arm-linux-gcc -g -O2 -o .libs/speexenc speexenc.o wav_io.o
../libspeex/.libs/libspeex.so
-L/home/lvcargnini/puc/instramed/filesys/usr/lib /usr/lib/libogg.so -lm
/usr/lib/libogg.so: could not read symbols: File in wrong format
collect2: ld returned 1 exit status


On 5/30/06, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
>
> Hi I'm trying to cross compilate Ogg/Vorbis. Ogg was ok cross compilate i=
t
> without problems, but vorbis and speex isn't so easy.
> Thay always doing (make) the same error trying to catch /usr/lib/libogg.s=
o
> it never trying to catch my libogg cross compiled for arm, how could i so=
lve
> this ?
>
>
> --
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS Electrical Engineer Faculty
>



--=20
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Mastering Degree student @ PUC-RS Electrical Engineer Faculty
