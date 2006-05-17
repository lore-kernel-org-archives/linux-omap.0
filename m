From: "Kanagesh R" <kanagesh@india.com>
Subject: RE: File system in flash
Date: Wed, 17 May 2006 11:50:27 +0800
Message-ID: <20060517035027.ACA8D24358@ws5-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: Gururaj N <gururaj@sasken.com>, "Menon, Nishanth" <x0nishan@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>=20
> Hi,
>=20
> Using the below mentioned bootargs. I get following error message. Lools
> like the memory address does not contain any filesyste,
>=20
> setenv bootargs mem=3D32M console=3DttyS0,115200n8 noinitrd=20
> root=3D/dev/mtdblock3 rootfstype=3Djffs2 devfs=3Dmount ip=3Dnoip
>=20
>=20
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at=20
> 0x00000040: 0xfeff instead
> Empty flash at 0x00000044 ends at 0x000000bc
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at=20
> 0x000000bc: 0xffbf instead
> Empty flash at 0x000000c0 ends at 0x00000104
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at=20
> 0x00000104: 0xffff instead
> Empty flash at 0x00000108 ends at 0x0000014c
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at=20
> 0x0000014c: 0xffff instead
> Empty flash at 0x00000150 ends at 0x0000016c
>=20
>=20
> With Regards
> Gururaj N

Hello,

This is also related to the erase block size you specify at the time of bui=
lding the JFFS2 binary image for your board's flash.  The erase size for yo=
ur binary image and the erase block size of the flash on your  board must m=
atch.

For example, if you are running on a OMAP5912 Starter Kit, the datasheet fo=
r the flash on the board (Micron StrataFlash MT28F128J3) specifies that the=
 flash chip has erase blocks of size 128KB and this should be the erase siz=
e you specify when you build your JFFS2 binary image

In the case of the OSK, the syntax for the mkfs.jffs2 would look like:

   # mkfs.jffs2 -d root_folder -o rootfs_image.jffs2 -e 0x20000


Hope this helps!

Warm regards,
Kanagesh

--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
