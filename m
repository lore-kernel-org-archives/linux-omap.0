From: "Sriram, Kannan" <ksriram@ti.com>
Subject: RE: flashing of x-loader and u-boot
Date: Thu, 28 Jun 2007 11:50:16 +0530
Message-ID: <0A50DBE80DD6674E94F7269DC964A7B61812EE@dbde01.ent.ti.com>
References: <c656a4d20706272312m64c948bey285a082a951d0ba3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20706272312m64c948bey285a082a951d0ba3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


NAND devices can develop bad blocks. We always give enough room to keep
4 copies of the Xloader, in 4 different blocks each (blocks 0 - 3) for
redundancy.

On a 512 byte page sized NAND device (a.k.a small page NAND) this works
out to 0x10000 bytes of space, because each block is 16Kbytes.

The boot ROM on the OMAP understands this, and always scans the blocks
in sequence (only blocks 0 - 3) to find a valid Xloader.

Ideally, you should be flashing the X-loader four times (to each of the
blocks 0,1,2,3 on the NAND device) to be fail-safe. But most (if not
all) NAND devices are guaranteed to always have the first block as good,
so this redundancy may not always be necessary though.


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of arun c
> Sent: Thursday, June 28, 2007 3:12 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: flashing of x-loader and u-boot
>=20
> Hi all,
>=20
> I am using omap2430SDP board.I have a doubt with that board
>=20
> For booting from nand flash i am doing these steps
>=20
> 1) I am flashing the u-boot.bin to nand at address 0x10000 using
u-boot
>=20
> 2) Then i am flashing xload.bin.ift to address 0x0c000000 using CSST
>=20
> >From manuals i found that nand is mapped to address 0x0c000000.
>=20
> so why can,t we flash xload.bin at 0x0c000000 and uboot.bin at
> 0x0c000000+<size of xload.bin> ?.. Instead of this why we are writing
u-
> boot at
> 0x10000?
>=20
>=20
> Thanks&Regards
>=20
> Arun
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
