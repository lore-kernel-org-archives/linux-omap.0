From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: SD device support in u-boot for TI 2430
Date: Mon, 8 Jan 2007 08:15:05 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5093F239A@dlee02.ent.ti.com>
References: <13ECC251745F8F4BA0076A980813C7C2AE3F05@msl-ex02.corp.m-sys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <13ECC251745F8F4BA0076A980813C7C2AE3F05@msl-ex02.corp.m-sys.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eyal Shani <Eyal.Shani@SanDisk.Com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You need to define what boot from MMC/SD means to you.

1 You should be able to have a Kernel in Flash and your root file system
in MMC/SD and be able to boot.  Kernel only support really needed aside
from u-boot atag (parameter passing).

2 The next level is to have the kernel itself in MMC/SD.  This has been
done in the past on 1510 with u-boot.  U-boot already knows fat, so it's
a bit about porting.  I can probably send you some old code for this if
you like, but its not directly useable as 2430's MMC is a bit different
from previous versions.

3 The next level again is for your u-boot to be in MMC/SD.  So far only
OMAP3 supports this.  Here the ROM code knows FAT and MMC.

Its likely you can do -1- already and it may be sufficient.

Regards,
Richard W.


> Hi All,
>=20
>=20
>=20
> I am required to do a Linux boot scenario from SD device.
>=20
>=20
>=20
> I know the TI ROM code support boot from SD, so I thought the u-boot
> will, as well...
>=20
> However,I could not find any SD reference in the u-boot code.
>=20
> In the kernel code (2.6.10), I could find MMC/SD references only.
>=20
>=20
>=20
> Can anybody tell me how I can boot from SD device?
>=20
> What in u-boot & kernel should be used for that scenario?
>=20
> Thanks in advance,Eyal
>=20
>=20
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
