From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC virtual
 	address
Date: Mon, 17 May 2010 20:04:14 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D8FBB71@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
 	<1273850591-19040-2-git-send-email-s-ghorai@ti.com>
 <AANLkTinGirx4-PPkpPhYEutbnN_uIPoYbA7BlUPCPnaK@mail.gmail.com>
 	<2A3DCF3DA181AD40BDE86A3150B27B6B030D8FB75B@dbde02.ent.ti.com>
 <AANLkTimHof-ZYHHWifCoyixbpJJD4h3FlIyfcZntFSXy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab0EQOe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 10:34:29 -0400
In-Reply-To: <AANLkTimHof-ZYHHWifCoyixbpJJD4h3FlIyfcZntFSXy@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>



> -----Original Message-----
> From: Vimal Singh [mailto:vimal.newwork@gmail.com]
> Sent: 2010-05-17 19:57
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; Artem.Bityutskiy@nokia.com;
> tony@atomide.com; sakoman@gmail.com; linux-mtd@lists.infradead.org
> Subject: Re: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC
> virtual address
>=20
> On Mon, May 17, 2010 at 9:52 AM, Ghorai, Sukumar <s-ghorai@ti.com> wr=
ote:
> [...]
> >> > @@ -108,11 +108,27 @@ static u32 gpmc_read_reg(int idx)
> >> > =A0 =A0 =A0 =A0return __raw_readl(gpmc_base + idx);
> >> > =A0}
> >> >
> >> > +static void gpmc_cs_write_byte(int cs, int idx, u8 val)
> >> > +{
> >> > + =A0 =A0 =A0 void __iomem *reg_addr;
> >> > +
> >> > + =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0_BASE + (cs * GPM=
C_CS_SIZE) +
> >> idx;
> >> > + =A0 =A0 =A0 __raw_writeb(val, reg_addr);
> >> > +}
> >> > +
> >> > +static u8 gpmc_cs_read_byte(int cs, int idx)
> >> > +{
> >> > + =A0 =A0 =A0 void __iomem *reg_addr;
> >> > +
> >> > + =A0 =A0 =A0 reg_addr =3D gpmc_base + GPMC_CS0_BASE + (cs * GPM=
C_CS_SIZE) +
> >> idx;
> >> > + =A0 =A0 =A0 return __raw_readb(reg_addr);
> >> > +}
> >> > +
> >>
> >> I do not think we need these functions.
> > [Ghorai] This is used in gpmc_hwcontrol() and to get the nand statu=
s
> from omap2.c.
>=20
> Yes, I can see that. But I think you should read complete register
> (32-bits) and the manipulate them accordingly.
>=20
> >
> [...]
> >> > @@ -229,14 +191,15 @@ static void omap_read_buf8(struct mtd_info
> *mtd,
> >> u_char *buf, int len)
> >> > =A0*/
> >> > =A0static void omap_write_buf8(struct mtd_info *mtd, const u_cha=
r *buf,
> >> int len)
> >> > =A0{
> >> > - =A0 =A0 =A0 struct omap_nand_info *info =3D container_of(mtd,
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct
> omap_nand_info,
> >> mtd);
> >> > + =A0 =A0 =A0 u32 =A0 =A0 status;
> >> > + =A0 =A0 =A0 struct nand_chip *nand =3D mtd->priv;
> >> > =A0 =A0 =A0 =A0u_char *p =3D (u_char *)buf;
> >> >
> >> > =A0 =A0 =A0 =A0while (len--) {
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(*p++, info->nand.IO_ADDR_=
W);
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (read=
l(info->gpmc_baseaddr +
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPMC_STATUS) &
> >> GPMC_BUF_FULL));
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite8(*p++, nand->IO_ADDR_W);
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpmc_hwcontrol(0, 0, GPMC_GET_SET_=
STATUS, 0,
> &status);
> >> If I am not mistaking, 2nd argument is 'cs', correct? And then, wh=
y
> >> are you hard coding this?
> >> Different boards will have NAND chip present at different 'cs'.
> >> Please have a look at uses of 'gpmc_hwcontrol' elsewhere as well f=
or
> this.
> > [Ghorai] I agree.
> >>
> >> Again, say, you got '(status & GPMC_BUF_FULL) !=3D GPMC_BUF_EMPTY'=
, then:
> >>
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (GPMC_BUF_EMPTY =3D=3D (stat=
us & GPMC_BUF_FULL))
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> >>
> >> You got in an infinite loop here?
> > [Ghorai] if you see carefully this is same as existing code. Let me
> check if any better solution.
>=20
> No. Look carefully. In previous code 'gpmc status' was being read in
> each loop, while in your code you read it once and then you never loo=
k
> for updated value.
> That's why your code is going into infinite loop
[Ghorai] ok. thanks
>=20
>=20
> --
> Regards,
> Vimal Singh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
