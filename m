From: "Eyal Shani" <Eyal.Shani@SanDisk.Com>
Subject: request_mem_region fails - built module with mv
	2.6.10_mobilinux410-omap2430_sdp
Date: Tue, 5 Dec 2006 15:43:50 +0200
Message-ID: <13ECC251745F8F4BA0076A980813C7C29F1175@msl-ex02.corp.m-sys.com>
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

The=20driver=20is=20built,=20but=20while=20insmod=20I=20get=20the=20follow=
ing=20output=20on=20the
target:

=20

root@172.17.54.81:~#=20insmod=20my_module.ko

my_module:=20request_mem_region(0x14000000,0x20000)=20failed

=20=20=20=20=20=20=20=20=20=20=20=20:

=20=20=20=20=20=20=20=20=20=20=20=20:

=20=20=20=20=20=20=20=20=20=20=20=20Unable=20to=20handle=20kernel=20paging=
=20request=20at=20virtual=20address
00001422

=20

BTW=20-=20My=20device=20is=20mapped=20to=200x14000000,=20CS7.

=20

Can=20anyone=20suggest=20a=20reason=20why=20this=20request_mem_region=20is=
=20failing?!

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
