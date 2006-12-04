From: "Eyal Shani" <Eyal.Shani@SanDisk.Com>
Subject: mcount unresolved symbol - build module with mv
	2.6.10_mobilinux410-omap2430_sdp
Date: Mon, 4 Dec 2006 17:29:08 +0200
Message-ID: <13ECC251745F8F4BA0076A980813C7C29F1035@msl-ex02.corp.m-sys.com>
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
Cc: Eyal Shani <Eyal.Shani@SanDisk.Com>
List-Id: linux-omap@vger.kernel.org

All,

=20

I=20am=20trying=20to=20build=20my=20hw=20driver=20as=20a=20module,=20with=20=
the=20mv
2.6.10_mobilinux410-omap2430_sdp=20kernel.

The=20driver=20is=20build,=20but=20while=20insmod=20I=20get=20the=20follow=
ing=20output=20on=20the
target:

=20

root@172.17.54.81:~#=20insmod=20my_module.ko

my_module:=20no=20version=20for=20"struct_module"=20found:=20kernel=20tain=
ted.

=20my_module:=20module=20license=20'Proprietary'=20taints=20kernel.

my_module:=20Unknown=20symbol=20mcount

insmod:=20error=20inserting=20'=20my_module.ko':=20-1=20Unknown=20symbol=20=
in=20module

=20

=20

I=20am=20used=20to=20building=20modules=20on=20the=20MV=20CEE3.1=20set=20o=
f=20kernels,=20for
kernel=202.4,=20but=20I=20have=20not=20seen=20this=20mcount=20before.

=20

Any=20idea=20anyone?!

=20

Thanks=20in=20advance,

Eyal=20Shani

=20


______________________________________________________________________
This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20
______________________________________________________________________
