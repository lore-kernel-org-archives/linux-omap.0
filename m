From: =?iso-8859-2?Q?Micha=B3_Szabat?= <michal611@interia.pl>
Subject: encoder audio or speech for omap5912
Date: Thu, 27 Apr 2006 15:44:40 +0200
Message-ID: <001201c66a00$bf2cb400$0301a8c0@hydra>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello.=20

I want encode wav to mp3 on omap5912. I try to compiled lame3.96.1 with =
toolchain3.4.1 with options=20
CC=3Darm-linux-gcc ./configure --target=3Darm-linux --host=3Darm-linux =
--prefix=3D/root/lame.=20
This compiled properly, but not works. =20

/ # lame
LAME version 3.96.1 (http://lame.sourceforge.net/)

usage: lame [options] <infile> [outfile]

    <infile> and/or <outfile> can be "-", which means stdin/stdout.

Try:
     "lame --help"           for general usage information
 or:
     "lame --preset help"    for information on suggested predefined =
settings
 or:
     "lame --longhelp"
  or "lame -?"              for a complete options list
/home # lame xp.wav xp.mp3
Segmentation fault.

I think that the problem maybe with this(configure warning)

checking for IEEE854 compliant 80 bit floats... configure: WARNING: =
can't check for IEEE854 compliant 80 bit floats

checking for ieee754_float64_t... no
checking for ieee754_float32_t... no
configure: WARNING:
  =
*************************************************************************=
*
  *                                                                      =
  *
  * You are cross compiling:                                             =
  *
  *   - I did not have a change to determine                             =
  *
  *     + the size of:                                                   =
  *
  *       - short                                                        =
  *
  *       - unsigned short                                               =
  *
  *       - int                                                          =
  *
  *       - unsigned int                                                 =
  *
  *       - long                                                         =
  *
  *       - unsigned long                                                =
  *
  *       - float                                                        =
  *
  *       - double                                                       =
  *
  *       - long double                                                  =
  *
  *     + the endianess of the system                                    =
  *
  *   - You have to provide appropriate defines for them in config.h, =
e.g. *
  *     + define SIZEOF_SHORT to 2 if the size of a short is 2           =
  *
  *     + define WORDS_BIGENDIAN if your system is a big endian system   =
  *
  *                                                                      =
  *
  =
*************************************************************************=
*

Anyone could help me with this. It not must be lame encoder. I tried =
with bladeenc and speex.
