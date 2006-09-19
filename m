From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Fwd: Problems loading ffs image
Date: Tue, 19 Sep 2006 15:42:23 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507B53B7B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: =?iso-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?= <lvcargnini@ieee.org>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

You boot command doesn't look right...
	bootcmd=3D0x00100000 0x10000000 142b34;bootm

What type of device is your root file system on NAND or NOR?  NAND and =
NOR JFFS2 images are created differently.  It used to be the clean =
markers were in-lined in a NOR image (you must specify this in image =
build).  NAND ones are kept in the NAND's OOB area and are not part of =
the basic image.

Can you even read reasonable data in your flash device when the kernel =
is on the way up?  It could be as simple as your memory timings are =
wrong given your boot speed and they simply are read up incorrectly.

Regards,
Richard W.


=20
> Hi I've downloaded an fresh git
>   tree, free of mtd patches and I still receiving the same error. The
> console is related tot the image blocks errors ?
> my u-boot env:
>=20
> bootdelay=3D3
> baudrate=3D115200
> bootfile=3D"uImage"
> etheraddr=3D00:0e:99:02:0a:4d
> ethaddr=3D00:0E:99:02:0A:4D
> bootargs=3Dmem=3D32M console=3DttyS0,115200n8 noinitrd rw ip=3Doff
> root=3D/dev/mtdblock3 rootfstype=3Djffs2
> filesize=3D142b34
> fileaddr=3D10000000
> netmask=3D255.255.254.0
> ipaddr=3D192.168.1.1
> serverip=3D192.168.1.3
> bootcmd=3D0x00100000 0x10000000 142b34;bootm
> stdin=3Dserial
> stdout=3Dserial
> stderr=3Dserial
>=20
>=20
> On 9/19/06, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> > Lu=EDs Vit=F3rio Cargnini stated on 9/18/2006 11:46 PM:
> > > yes I'm using the latest kernel and i have patched it with =
mtd-utils
> > > oficial
> > > patches from site, so i must rollback my patch of mtd ?
> > >
> > I had suspected something like 2.4/2.6.10+latest mtd. Try using the
> > plain kernel with the mtd. I think mtd-utils 1.0 was released by =
david
> > on mtd. further, MTD
> > list(http://lists.infradead.org/mailman/listinfo/linux-mtd/) might =
be
> > able to help you better on this. it may even be your mkfs.jffs2 =
options
> > that goofed it up..
> >
> > Regards,
> > Nishanth Menon
> >
>=20
>=20
> --
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Mastering Degree student @ PUC-RS Electrical Engineer Faculty
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
