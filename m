From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v3 2/3] omap3 nand: cleanup virtual address usages
Date: Wed, 19 May 2010 22:54:19 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D991D43@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1274181389-7488-1-git-send-email-s-ghorai@ti.com>
 	<1274181389-7488-2-git-send-email-s-ghorai@ti.com>
 <1274181389-7488-3-git-send-email-s-ghorai@ti.com>
 <AANLkTinEaP9cN5A24K9Zwd4L9Fq4pzxQqqY44r7NSl4-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48477 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab0ESRYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 13:24:44 -0400
In-Reply-To: <AANLkTinEaP9cN5A24K9Zwd4L9Fq4pzxQqqY44r7NSl4-@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>

Vimal,

> -----Original Message-----
> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
> Sent: 2010-05-19 21:00
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> tony@atomide.com; sakoman@gmail.com; mike@compulab.co.il;
> Artem.Bityutskiy@nokia.com
> Subject: Re: [PATCH v3 2/3] omap3 nand: cleanup virtual address usage=
s
>=20
> On Tue, May 18, 2010 at 4:46 PM, Sukumar Ghorai <s-ghorai@ti.com> wro=
te:
> > This patch removes direct reference of gpmc address from generic na=
nd
> platform code.
> > Nand platform code now uses wrapper functions which are implemented=
 in
> gpmc module.
> >
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> [...]
>=20
> >
> > @@ -287,16 +246,15 @@ static void omap_read_buf_pref(struct mtd_inf=
o
> *mtd, u_char *buf, int len)
> > =A0{
> > =A0 =A0 =A0 =A0struct omap_nand_info *info =3D container_of(mtd,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_nand_info,
> mtd);
> > - =A0 =A0 =A0 uint32_t pfpw_status =3D 0, r_count =3D 0;
> > + =A0 =A0 =A0 u32 r_count =3D 0;
> > =A0 =A0 =A0 =A0int ret =3D 0;
> > - =A0 =A0 =A0 u32 *p =3D (u32 *)buf;
> > + =A0 =A0 =A0 u32 *p;
> >
> > =A0 =A0 =A0 =A0/* take care of subpage reads */
> > =A0 =A0 =A0 =A0for (; len % 4 !=3D 0; ) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*buf++ =3D __raw_readb(info->nand.IO=
_ADDR_R);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len--;
> > =A0 =A0 =A0 =A0}
> > - =A0 =A0 =A0 p =3D (u32 *) buf;
>=20
> Above code had an issue, which was fixed by this commit:
> http://git.infradead.org/mtd-
> 2.6.git/commitdiff/c3341d0ceb4de1680572024f50233403c6a8b10d
>=20
> I would suggest you to prepare your patch on MTD tree.
[Ghorai] Patches started posting on lo. And lets continue the same.
>=20
> >
> > =A0 =A0 =A0 =A0/* configure and start prefetch transfer */
> > =A0 =A0 =A0 =A0ret =3D gpmc_prefetch_enable(info->gpmc_cs, 0x0, len=
, 0x0);
> > @@ -307,17 +265,18 @@ static void omap_read_buf_pref(struct mtd_inf=
o
> *mtd, u_char *buf, int len)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_read_buf8(mtd, =
buf, len);
> > =A0 =A0 =A0 =A0} else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u32 *) buf;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfpw_status =3D gpmc_=
prefetch_status();
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r_count =3D ((pfpw_st=
atus >> 24) & 0x7F) >> 2;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32_rep(info->na=
nd_pref_fifo_add, p,
> r_count);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(info->=
gpmc_cs,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_=
PREFETCH_FIFO_CNT, 0, 0, &r_count);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r_count =3D r_count >=
> 2;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32_rep(info->na=
nd.IO_ADDR_R, p, r_count);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p +=3D r_count;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D r_count << 2=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D (r_count << =
2);
>=20
> Braces are not required here.
[Ghorai] thanks
>=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while (len);
> > -
>=20
> After call to 'gpmc_prefetch_enable', next line are:
>            if (ret) {
>                        /* PFPW engine is busy, use cpu copy method */
>                        if (info->nand.options & NAND_BUSWIDTH_16)
>                        ...
>                        ...
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable and stop the PFPW engine *=
/
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset(info->gpmc_cs);
> > =A0 =A0 =A0 =A0}
>=20
> So, if above 'if' fails, driver will not get prefetch engine (it was
> already busy). Then it doesn't makes sense to call for __reset__.
[Ghorai] I will take this clean up as 4th patch. As its not matching wi=
th patch description.
>=20
> > + =A0 =A0 =A0 /* disable and stop the PFPW engine */
> > + =A0 =A0 =A0 gpmc_prefetch_reset(info->gpmc_cs);
>=20
> (Also see my comments on your other patch.)
[Ghorai] Agree and I will take this kind of cleanup as 4th patch
>=20
> > =A0}
> >
> > =A0/**
> > @@ -331,13 +290,13 @@ static void omap_write_buf_pref(struct mtd_in=
fo
> *mtd,
> > =A0{
> > =A0 =A0 =A0 =A0struct omap_nand_info *info =3D container_of(mtd,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_nand_info,
> mtd);
> > - =A0 =A0 =A0 uint32_t pfpw_status =3D 0, w_count =3D 0;
> > + =A0 =A0 =A0 uint32_t pref_count =3D 0, w_count =3D 0;
> > =A0 =A0 =A0 =A0int i =3D 0, ret =3D 0;
> > - =A0 =A0 =A0 u16 *p =3D (u16 *) buf;
> > + =A0 =A0 =A0 u16 *p;
> >
> > =A0 =A0 =A0 =A0/* take care of subpage writes */
> > =A0 =A0 =A0 =A0if (len % 2 !=3D 0) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(*buf, info->nand.IO_ADDR_R);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(*buf, info->nand.IO_ADDR_W);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p =3D (u16 *)(buf + 1);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len--;
> > =A0 =A0 =A0 =A0}
> > @@ -351,17 +310,22 @@ static void omap_write_buf_pref(struct mtd_in=
fo
> *mtd,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_write_buf8(mtd,=
 buf, len);
> > =A0 =A0 =A0 =A0} else {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfpw_status =3D gpmc_prefetch_status(=
);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (pfpw_status & 0x3FFF) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w_count =3D ((pfpw_st=
atus >> 24) & 0x7F) >> 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u16 *) buf;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (len) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(info->=
gpmc_cs,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 GPMC_PREFETCH_FIFO_CNT, 0, 0,
> &w_count);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w_count =3D w_count >=
> 1;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; (i < w=
_count) && len; i++, len -=3D 2)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowri=
te16(*p++, info-
> >nand_pref_fifo_add);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pfpw_status =3D gpmc_=
prefetch_status();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowri=
te16(*p++, info->nand.IO_ADDR_W);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable and stop the PFPW engine *=
/
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_prefetch_reset(info->gpmc_cs);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait for data to flushed-out befor=
e reset the
> prefetch */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(info->=
gpmc_cs,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_=
PREFETCH_COUNT, 0, 0, &pref_count);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (pref_count);
> > =A0 =A0 =A0 =A0}
> > + =A0 =A0 =A0 /* disable and stop the PFPW engine */
> > + =A0 =A0 =A0 gpmc_prefetch_reset(info->gpmc_cs);
>=20
> Same as above.
[Ghorai] Agree and I will take this kind of cleanup as 4th patch, as it=
s not matching with patch description.
>=20
>=20
> > =A0}
> >
> > =A0#ifdef CONFIG_MTD_NAND_OMAP_PREFETCH_DMA
> > @@ -448,8 +412,10 @@ static inline int omap_nand_dma_transfer(struc=
t
> mtd_info *mtd, void *addr,
> > =A0 =A0 =A0 =A0/* setup and start DMA using dma_addr */
> > =A0 =A0 =A0 =A0wait_for_completion(&info->comp);
> >
> > - =A0 =A0 =A0 while (0x3fff & (prefetch_status =3D gpmc_prefetch_st=
atus()))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> > + =A0 =A0 =A0 do {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(info->gpmc_cs,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_=
PREFETCH_COUNT, 0, 0,
> &prefetch_status);
> > + =A0 =A0 =A0 } while (prefetch_status);
> > =A0 =A0 =A0 =A0/* disable and stop the PFPW engine */
> > =A0 =A0 =A0 =A0gpmc_prefetch_reset();
> >
> > @@ -502,7 +468,7 @@ static void omap_write_buf_dma_pref(struct mtd_=
info
> *mtd,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_write_buf_pref(mtd, buf, len);
> > =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* start transfer in DMA mode */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_nand_dma_transfer(mtd, buf, len,=
 0x1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_nand_dma_transfer(mtd, (u_char *=
) buf, len, 0x1);
>=20
> This is already fixed. See commit:
> http://git.infradead.org/mtd-
> 2.6.git/commitdiff/bdaefc41627b6f2815ef7aa476dfa4ebb3ad499f
[Ghorai] thanks I will omit this from this patch
>=20
>=20
> Rest, patches looks good. It is a good clean-up all together.
[Ghorai] Is it possible for you to check once again if you have any add=
itional comments! This is to identify the issue if any at early stage.
>=20
> --
> Regards,
> Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
