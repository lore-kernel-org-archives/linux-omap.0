From: =?iso-8859-2?q?Micha=B3_Szabat?= <michal611@interia.pl>
Subject: Problem with DSP/BIOS Link and Linux Dsp Tools
Date: 25 May 2006 18:26:56 +0200
Message-ID: <20060525162656.51C602334F9@poczta.interia.pl>
Mime-Version: 1.0
Content-Type: TEXT/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

=0AHello.=0AI succesfuly build DSP/BIOS Link with Linux Dsp Tools and toolc=
hain 3.4.1.=0AI'm using kernel 2.6.11. Rootfs is mounted by nfs. I copied f=
ile dsplinkk.o and pmr_drv.o in the shared area for nfs, by the modules can=
not insert: =0A=0A# ls=0Adsplinkk.o  load4rta    pmr_drv.o=0A# ./load4rta=
=0Amknod: /dev/dsp: File exists=0AUsing dsplinkk.o=0ANo module found in obj=
ect=0Ainsmod: cannot insert `dsplinkk.o': Invalid module format (-1): Exec =
format error=0Amknod: /dev/dsplink: File exists=0AUsing pmr_drv.o=0ANo modu=
le found in object=0Ainsmod: cannot insert `pmr_drv.o': Invalid module form=
at (-1): Exec format error=0Amknod: /dev/bios_pmr: File exists=0A# insmod d=
splinkk.o=0AUsing dsplinkk.o=0ANo module found in object=0Ainsmod: cannot i=
nsert `dsplinkk.o': Invalid module format (-1): Exec format error=0A# insmo=
d pmr_drv.o=0AUsing pmr_drv.o=0ANo module found in object=0Ainsmod: cannot =
insert `pmr_drv.o': Invalid module format (-1): Exec format error=0A=0AAnyb=
ody cen help me with this? =0ARegards. Michal=0A

----------------------------------------------------------------------
INTERIA.PL dla kobiet... >>> http://link.interia.pl/f193b
