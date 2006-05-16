From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: File system in flash
Date: Tue, 16 May 2006 10:35:33 -0500
Message-ID: <520AB2AD990DC04082102F77CA172638036D9CE2@dlee03.ent.ti.com>
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
To: Gururaj N <gururaj@sasken.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Using the below mentioned bootargs. I get following error message.
Lools
> like the memory address does not contain any filesyste,
>=20
> setenv bootargs mem=3D32M console=3DttyS0,115200n8 noinitrd
> root=3D/dev/mtdblock3 rootfstype=3Djffs2 devfs=3Dmount ip=3Dnoip
>=20
>=20
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000040:
> 0xfeff instead
> Empty flash at 0x00000044 ends at 0x000000bc
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x000000bc:
> 0xffbf instead
> Empty flash at 0x000000c0 ends at 0x00000104
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000104:
> 0xffff instead
> Empty flash at 0x00000108 ends at 0x0000014c
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000014c:
> 0xffff instead
> Empty flash at 0x00000150 ends at 0x0000016c
Magic number not found!! Ur flash partition does not have a jffs2
filesystem. Please refer to the http://www.linux-mtd.infradead.org/ site
for more info or u can ask the mtd list.. read the help docs, check
other discussions, use google.. :)

And finally, if you require mailing the opensource list, please use
yahoo id/gmail id if your organization does not allow you to mail
without disclaimers.

Regards,
Nishanth Menon
