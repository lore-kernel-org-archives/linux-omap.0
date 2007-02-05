From: "Eyal Shani" <Eyal.Shani@SanDisk.Com>
Subject: SD support on omap 2430, kernel 2.6.10MV
Date: Mon, 5 Feb 2007 16:54:59 +0200
Message-ID: <13ECC251745F8F4BA0076A980813C7C2B81FA6@msl-ex02.corp.m-sys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi=20all,

=20

I=20am=20trying=20to=20execute=20MMC/SD=20cards=20on=20omap2430=20platform=
.

I=20am=20using=202.6.10=20MobiLinux=20Linux=20of=20MontaVista.

Platform=20is=20OMAP=202430-v2.8.

=20

MMC=20card=20starts=20just=20fine.

SD=20card=20initializes,=20but=20gets=20some=20errors,=20and=20fails.

I=20am=20using=20Sandisk=20Ultra-II,=20512MB=20SD=20card.

=20

Specifically,=20the=20init=20sequence=20seems=20ok,=20until=20it=20is=20do=
ing=20CMD2,=20which
fails=20-=20as=20can=20be=20seen=20below=20in=20log.

In=20MMC=20driver=20code,=20in=20KERNEL/drivers/mmc/=20I=20can=20see=20som=
e=20OCR
mentioning,=20and=20some=20notes=20claiming,mmc.c:=20

"Send=20the=20selected=20OCR=20multiple=20times...=20until=20the=20cards=20=
all=20get=20the
idea=20that=20they=20should=20be=20ready=20for=20CMD2.=20(My=20SanDisk=20c=
ard=20seems=20to=20need
this.)"

=20

Well=20-=20it=20doesn't=20get=20the=20idea...

=20

Any=20suggestions=20here?

=20

=20

LOG::=20SD

:

:

MMC:=20starting=20cmd=2029=20arg=2000300000=20flags=2000000001

mmc1:=20CMD41,=20argument=200x00300000,=2032-bit=20response

mmc1:=20Response=2000ff8000

mmc1:=20End=20request,=20err=200

MMC:=20req=20done=20(29):=200:=2000ff8000=2000000000=2000000000=2000000000=


MMC:=20starting=20cmd=2002=20arg=2000000000=20flags=200000000a

mmc1:=20CMD2,=20argument=200x00000000,=20128-bit=20response,=20CRC

mmc1:=20Response=20902e012a=200f5983cc=20f6da9fff=2000ff8000

mmc1:=20End=20request,=20err=201

MMC:=20req=20done=20(02):=201:=20902e012a=200f5983cc=20f6da9fff=2000ff8000=


mmc1:=20CMD2,=20argument=200x00000000,=20128-bit=20response,=20CRC

mmc1:=20Response=20902e012a=200f5983cc=20f6da9fff=2000ff8000

mmc1:=20End=20request,=20err=201

MMC:=20req=20done=20(02):=201:=20902e012a=200f5983cc=20f6da9fff=2000ff8000=


mmc1:=20CMD2,=20argument=200x00000000,=20128-bit=20response,=20CRC

mmc1:=20Response=20902e012a=200f5983cc=20f6da9fff=2000ff8000

mmc1:=20End=20request,=20err=201

MMC:=20req=20done=20(02):=201:=20902e012a=200f5983cc=20f6da9fff=2000ff8000=


mmc1:=20CMD2,=20argument=200x00000000,=20128-bit=20response,=20CRC

mmc1:=20Response=20902e012a=200f5983cc=20f6da9fff=2000ff8000

mmc1:=20End=20request,=20err=201

MMC:=20req=20done=20(02):=201:=20902e012a=200f5983cc=20f6da9fff=2000ff8000=


mmc1:=20set_ios:=20clock=20400000Hz=20busmode=202=20powermode=202=20Vdd=20=
14

mmc1:=20set_ios:=20clock=200Hz=20busmode=201=20powermode=200=20Vdd=200

=20

10x,=20eyal.


______________________________________________________________________
This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20
______________________________________________________________________
