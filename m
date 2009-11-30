From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-v5 2/4] OMAP3: Add support for NAND on ZOOM2/LDP boards
Date: Mon, 30 Nov 2009 09:31:15 -0800
Message-ID: <20091130173115.GR4348@atomide.com>
References: <ce9ab5790911100208g42c886b3g13261ea8a1d79a04@mail.gmail.com>
 <20091112204428.GC24837@atomide.com>
 <ce9ab5790911180638x70da2e61n964f94d61d403adc@mail.gmail.com>
 <20091118170745.GL29266@atomide.com>
 <ce9ab5790911190052m4a03c135xda330fe026366084@mail.gmail.com>
 <20091123174543.GC22923@atomide.com>
 <ce9ab5790911292212u12872f8esb296c813622c0003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61480 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZK3RbL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 12:31:11 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5790911292212u12872f8esb296c813622c0003@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

* Vimal Singh <vimal.newwork@gmail.com> [091129 22:11]:
> On Mon, Nov 23, 2009 at 11:15 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
> > * Vimal Singh <vimal.newwork@gmail.com> [091119 00:52]:
> >> On Wed, Nov 18, 2009 at 10:37 PM, Tony Lindgren <tony@atomide.com>=
 wrote:
> >> > * Vimal Singh <vimal.newwork@gmail.com> [091118 06:38]:
> >> >> Tony,
> >> >>
> >> >> On Fri, Nov 13, 2009 at 2:14 AM, Tony Lindgren <tony@atomide.co=
m> wrote:
> >> >> > * Vimal Singh <vimal.newwork@gmail.com> [091110 02:08]:
> >> >> >> From 6f535d7128ca392458dd0cb31d138cda84747c06 Mon Sep 17 00:=
00:00 2001
> >> >> >> From: Vimal Singh <vimalsingh@ti.com>
> >> >> >> Date: Tue, 10 Nov 2009 11:42:45 +0530
> >> >> >> Subject: [PATCH] OMAP3: Add support for NAND on ZOOM2/LDP bo=
ards
> >> >>
> >> >> [...]
> >> >>
> >> >> >> +static int omap_ldp_nand_unlock(struct mtd_info *mtd, loff_=
t ofs, uint64_t len)
> >> >> >> +{
> >> >> >> + =A0 =A0 int ret =3D 0;
> >> >> >> + =A0 =A0 int chipnr;
> >> >> >> + =A0 =A0 int status;
> >> >> >> + =A0 =A0 unsigned long page;
> >> >> >> + =A0 =A0 struct nand_chip *this =3D mtd->priv;
> >> >> >> + =A0 =A0 printk(KERN_INFO "nand_unlock: start: %08x, length=
: %d!\n",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (int)ofs, (int)len=
);
> >> >> >> +
> >> >> >> + =A0 =A0 /* select the NAND device */
> >> >> >> + =A0 =A0 chipnr =3D (int)(ofs >> this->chip_shift);
> >> >> >> + =A0 =A0 this->select_chip(mtd, chipnr);
> >> >> >> + =A0 =A0 /* check the WP bit */
> >> >> >> + =A0 =A0 this->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
> >> >> >> + =A0 =A0 if ((this->read_byte(mtd) & 0x80) =3D=3D 0) {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Devi=
ce is write protected!\n");
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> >> >> + =A0 =A0 }
> >> >> >> +
> >> >> >> + =A0 =A0 if ((ofs & (mtd->writesize - 1)) !=3D 0) {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Star=
t address must be"
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "b=
eginning of nand page!\n");
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> >> >> + =A0 =A0 }
> >> >> >> +
> >> >> >> + =A0 =A0 if (len =3D=3D 0 || (len & (mtd->writesize - 1)) !=
=3D 0) {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: Leng=
th must be a multiple of "
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "n=
and page size!\n");
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> >> >> + =A0 =A0 }
> >> >> >> +
> >> >> >> + =A0 =A0 /* submit address of first page to unlock */
> >> >> >> + =A0 =A0 page =3D (unsigned long)(ofs >> this->page_shift);
> >> >> >> + =A0 =A0 this->cmdfunc(mtd, NAND_CMD_UNLOCK1, -1, page & th=
is->pagemask);
> >> >> >> +
> >> >> >> + =A0 =A0 /* submit ADDRESS of LAST page to unlock */
> >> >> >> + =A0 =A0 page +=3D (unsigned long)((ofs + len) >> this->pag=
e_shift) ;
> >> >> >> + =A0 =A0 this->cmdfunc(mtd, NAND_CMD_UNLOCK2, -1, page & th=
is->pagemask);
> >> >> >> +
> >> >> >> + =A0 =A0 /* call wait ready function */
> >> >> >> + =A0 =A0 status =3D this->waitfunc(mtd, this);
> >> >> >> + =A0 =A0 udelay(1000);
> >> >> >> + =A0 =A0 /* see if device thinks it succeeded */
> >> >> >> + =A0 =A0 if (status & 0x01) {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* there was an error */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "nand_unlock: erro=
r status =3D0x%08x ", status);
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> >> >> + =A0 =A0 }
> >> >> >> +
> >> >> >> + out:
> >> >> >> + =A0 =A0 /* de-select the NAND device */
> >> >> >> + =A0 =A0 this->select_chip(mtd, -1);
> >> >> >> + =A0 =A0 return ret;
> >> >> >> +}
> >> >> >
> >> >> > Isn't the unlocking generic to the NAND device driver? Or is =
it somehow board
> >> >> > specific?
> >> >>
> >> >> Yes, zoom2 boards come up with whole NAND locked, whereas it is=
 not
> >> >> case for SDP boards.
> >> >
> >> > But the procedure should be done under drivers/mtd I believe usi=
ng some
> >> > standard tools.
> >>
> >> OK, I'll take this discussion to mtd mailing list. For now I'll re=
move
> >> this from here.
> >
> > OK, I'd assume there's some standard way to handle this for all NOR
> > drivers.
> >
> >> >
> >> >> >
> >> >> >
> >> >> >> +static struct mtd_partition ldp_nand_partitions[] =3D {
> >> >> >> + =A0 =A0 /* All the partition sizes are listed in terms of =
NAND block size */
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-L=
oader-NAND",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * =
(64 * 2048), =A0 =A0 =A0/* 512KB, 0x80000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEA=
BLE, =A0 =A0 =A0 =A0/* force read-only */
> >> >> >> + =A0 =A0 },
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-B=
oot-NAND",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPAR=
T_OFS_APPEND, =A0 /* Offset =3D 0x80000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 10 *=
 (64 * 2048), =A0 =A0 /* 1.25MB, 0x140000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEA=
BLE, =A0 =A0 =A0 =A0/* force read-only */
> >> >> >> + =A0 =A0 },
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Boo=
t Env-NAND",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPAR=
T_OFS_APPEND, =A0 /* Offset =3D 0x1c0000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 2 * =
(64 * 2048), =A0 =A0 =A0/* 256KB, 0x40000 */
> >> >> >> + =A0 =A0 },
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Ker=
nel-NAND",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPAR=
T_OFS_APPEND, =A0 /* Offset =3D 0x0200000*/
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 240 =
* (64 * 2048), =A0 =A0/* 30M, 0x1E00000 */
> >> >> >> + =A0 =A0 },
> >> >> >> +#ifdef CONFIG_MACH_OMAP_ZOOM2
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sys=
tem",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPAR=
T_OFS_APPEND, =A0 /* Offset =3D 0x2000000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 1280=
 * (64 * 2048), =A0 /* 160M, 0xA000000 */
> >> >> >> + =A0 =A0 },
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "use=
rdata",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPAR=
T_OFS_APPEND, =A0 /* Offset =3D 0xC000000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 256 =
* (64 * 2048), =A0 =A0/* 32M, 0x2000000 */
> >> >> >> + =A0 =A0 },
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "cac=
he",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPAR=
T_OFS_APPEND, =A0 /* Offset =3D 0xE000000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 256 =
* (64 * 2048), =A0 =A0/* 32M, 0x2000000 */
> >> >> >> + =A0 =A0 },
> >> >> >> +#else
> >> >> >> + =A0 =A0 {
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Fil=
e System - NAND",
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPAR=
T_OFS_APPEND, =A0 /* Offset =3D 0x2000000 */
> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDP=
ART_SIZ_FULL, =A0 =A0 /* 96MB, 0x6000000 */
> >> >> >> + =A0 =A0 },
> >> >> >> +#endif
> >> >> >
> >> >> > Please remove the ifdefs, you should be able to compile in al=
l mach-omap2
> >> >> > boards into the same kernel binary. You should set the size d=
ynamically as
> >> >> > needed.
> >> >>
> >> >> We can always provide partitioning information from cmdline
> >> >> (mtdparts:). Which will anyway have higher precedence than this=
=2E Here
> >> >> are trying provide default static partitions. Which IMHO is fin=
e.
> >> >>
> >> >> see this too:
> >> >> http://marc.info/?l=3Dlinux-omap&m=3D125178914327011&w=3D2
> >> >
> >> > No way we're adding any more of these ifdef else hacks.
> >> >
> >> > The whole idea of the platform_data is to pass the board specifi=
c
> >> > configuration to the driver. The driver should be generic.
> >> >
> >>
> >> Hmmm... In that case I'll remove extra partition informations (for
> >> zoom2 and sdp) and will have very only few common partitions here.
> >> Something like this:
> >>
> >> +static struct mtd_partition ldp_nand_partitions[] =3D {
> >> + =A0 =A0 =A0 /* All the partition sizes are listed in terms of NA=
ND block size */
> >> + =A0 =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "X-Loa=
der-NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D 0,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 4 * (6=
4 * 2048), =A0 =A0 =A0/* 512KB, 0x80000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABL=
E, =A0 =A0 =A0 =A0/* force read-only */
> >> + =A0 =A0 =A0 },
> >> + =A0 =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "U-Boo=
t-NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_=
OFS_APPEND, =A0 /* Offset =3D 0x80000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 10 * (=
64 * 2048), =A0 =A0 /* 1.25MB, 0x140000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mask_flags =A0 =A0 =3D MTD_WRITEABL=
E, =A0 =A0 =A0 =A0/* force read-only */
> >> + =A0 =A0 =A0 },
> >> + =A0 =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Boot =
Env-NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_=
OFS_APPEND, =A0 /* Offset =3D 0x1c0000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 2 * (6=
4 * 2048), =A0 =A0 =A0/* 256KB, 0x40000 */
> >> + =A0 =A0 =A0 },
> >> + =A0 =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "Kerne=
l-NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_=
OFS_APPEND, =A0 /* Offset =3D 0x0200000*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D 240 * =
(64 * 2048), =A0 =A0/* 30M, 0x1E00000 */
> >> + =A0 =A0 =A0 },
> >> + =A0 =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "File =
System - NAND",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .offset =A0 =A0 =A0 =A0 =3D MTDPART_=
OFS_APPEND, =A0 /* Offset =3D 0x2000000 */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =A0 =A0 =A0 =A0 =3D MTDPAR=
T_SIZ_FULL,
> >> + =A0 =A0 =A0 },
> >> +};
> >>
> >>
> >> And then, as I said earlier, if someone want different partitions,=
 he
> >> can always pass his partition information from cmdline (bootargs).
> >
> > Why don't you just set ldp_nand_paritions[X].size =3D something dur=
ing init
> > based on the machine_is_XXX()?
>=20
> Rather I am thinking of moving partition definitions to core board
> file, and pass a pointer to 'board-*-flash.c'. How about this?
> This way any board can have its own partition information specified.

Yeah that would be the most flexible way of doing it. You should also
pass the CS number and size.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
