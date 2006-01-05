From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: 2420 H4 and kernel startup RAM error
Date: Thu, 5 Jan 2006 05:00:59 -0600
Message-ID: <520AB2AD990DC04082102F77CA172638022A1EDD@dlee03.ent.ti.com>
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
To: Ola Helm <ola.hel@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> I have tried both to erase 0x4000000 0x417FFFF and load with file size
> 0x1222e0, source address 0x80000000 and destination address 0x4040000
i.e
>=20
> cp.b 0x80000000 0x4040000 1222e0
>=20
> Kernel command line: root=3D/dev/ram0 rw mem=3D32M =
console=3DttyS0,115200n8
> initrd=3D0x80600000,8M ramdisk_size=3D8192
I guess u told the kernel to load a ramdisk from =
0x80600000(initrd=3Dxyz)
and the ramdisk image remained in flash...
If U'd like the file system in flash(and use it from flash) 0x04040000
then it should be a jffs2 filesystem.=20
Regards,
Nishanth Menon
