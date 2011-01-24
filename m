From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP3EVM: Add vio regulator supply required for ads7846
 TSC driver
Date: Mon, 24 Jan 2011 20:32:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD65F506@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1295879565-13144-1-git-send-email-hvaibhav@ti.com>
 <AANLkTi=pYjxQkw2a+7R_H6HBYpKyg74uEKS9oGqtN9cO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37213 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab1AXPCj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 10:02:39 -0500
In-Reply-To: <AANLkTi=pYjxQkw2a+7R_H6HBYpKyg74uEKS9oGqtN9cO@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Varadarajan, Charulatha [mailto:charu@ti.com]
> Sent: Monday, January 24, 2011 8:13 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH] OMAP3EVM: Add vio regulator supply required for
> ads7846 TSC driver
>=20
> On Mon, Jan 24, 2011 at 20:02,  <hvaibhav@ti.com> wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
>=20
> Please add a patch description.
>=20
[Hiremath, Vaibhav] I can copy/paste subject line again here, but I tho=
ught subject description is sufficient to explain purpose of patch so d=
id not mentioned anything here.

Thanks,
Vaibhav

> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 20 ++++++++++++++++++=
++
> > =A01 files changed, 20 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index a158d21..ed0311c 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -538,6 +538,25 @@ static struct regulator_init_data omap3_evm_vp=
ll2 =3D
> {
> > =A0 =A0 =A0 =A0.consumer_supplies =A0 =A0 =A0=3D &omap3_evm_vpll2_s=
upply,
> > =A0};
> >
> > +/* ads7846 on SPI */
> > +static struct regulator_consumer_supply omap3evm_vio_supply =3D
> > + =A0 =A0 =A0 REGULATOR_SUPPLY("vcc", "spi1.0");
> > +
> > +/* VIO for ads7846 */
> > +static struct regulator_init_data omap3evm_vio =3D {
> > + =A0 =A0 =A0 .constraints =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1800000,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1800000,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D true,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REG=
ULATOR_MODE_NORMAL
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D R=
EGULATOR_CHANGE_MODE
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
> > + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &omap3evm_vio_suppl=
y,
> > +};
> > +
> > =A0static struct twl4030_platform_data omap3evm_twldata =3D {
> > =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
> > =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
> > @@ -550,6 +569,7 @@ static struct twl4030_platform_data omap3evm_tw=
ldata
> =3D {
> > =A0 =A0 =A0 =A0.codec =A0 =A0 =A0 =A0 =A0=3D &omap3evm_codec_data,
> > =A0 =A0 =A0 =A0.vdac =A0 =A0 =A0 =A0 =A0 =3D &omap3_evm_vdac,
> > =A0 =A0 =A0 =A0.vpll2 =A0 =A0 =A0 =A0 =A0=3D &omap3_evm_vpll2,
> > + =A0 =A0 =A0 .vio =A0 =A0 =A0 =A0 =A0 =A0=3D &omap3evm_vio,
> > =A0};
> >
> > =A0static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[]=
 =3D {
> > --
> > 1.6.2.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
