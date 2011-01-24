From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller in
 board_init
Date: Mon, 24 Jan 2011 20:42:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD65F509@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1295880108-15584-1-git-send-email-hvaibhav@ti.com>
 <AANLkTikcTqXS3vSSnmiS94SAHbAm-NPbT-_BTExDwvr-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43750 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab1AXPMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 10:12:12 -0500
In-Reply-To: <AANLkTikcTqXS3vSSnmiS94SAHbAm-NPbT-_BTExDwvr-@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Varadarajan, Charulatha [mailto:charu@ti.com]
> Sent: Monday, January 24, 2011 8:32 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin; tony@atomide.com
> Subject: Re: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet contro=
ller
> in board_init
>=20
> On Mon, Jan 24, 2011 at 20:11,  <hvaibhav@ti.com> wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
>=20
> Thanks for the patch.  I guess this problem was initially reported by
> Kevin.
> So you may consider adding his Reported-by.
>=20
> > With addition of HWMOD support to GPIO, the Ethernet controller
>=20
> %s/HWMOD/hwmod
>=20
[Hiremath, Vaibhav] Ok.

> > goes undetected for OMAP35xEVM. So explicitely assert the reset sig=
nal
> to
>=20
> %s/explicitely/explicitly
>=20
[Hiremath, Vaibhav] Oops. Perhaps I will have to run spell check before=
 sending it.

> > Ethernet controller smsc911x -
> >
> > =A0 =A0 =A0 =A0- GPIO7 (>=3DRevG version of EVM's)
> > =A0 =A0 =A0 =A0- GPIO64 (<=3DRevD version of EVM's)
> >
> > I have tested this patch on RevG version of EVM with ES3.1 Si.
> > This patch is based on intial version from Charulatha V.
>=20
> Please add the link for reference. Also please add my SOB if you find
> it relevant.
>=20
[Hiremath, Vaibhav] Good point, will add it.

> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> > NOTE: I have not been able to test it on older version of EVM's.
> >
> > =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 27 ++++++++++++++++++=
++++++++-
> > =A01 files changed, 26 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index 212d88c..336c012 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -124,10 +124,15 @@ static struct platform_device
> omap3evm_smsc911x_device =3D {
> >
> > =A0static inline void __init omap3evm_init_smsc911x(void)
> > =A0{
> > - =A0 =A0 =A0 int eth_cs;
> > + =A0 =A0 =A0 int eth_cs, eth_rst;
> > =A0 =A0 =A0 =A0struct clk *l3ck;
> > =A0 =A0 =A0 =A0unsigned int rate;
> >
> > + =A0 =A0 =A0 if (get_omap3_evm_rev() =3D=3D OMAP3EVM_BOARD_GEN_1)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eth_rst =3D 64;
>=20
> Please define macros and use them.
>=20
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eth_rst =3D 7;
>=20
> Ditto
>=20
[Hiremath, Vaibhav] My original code is using macros but I changed it b=
efore submitting to get rid of 2 #defines. But I think it makes sense t=
o have macros, I will add it and submit it again.


> > +
> > =A0 =A0 =A0 =A0eth_cs =3D OMAP3EVM_SMSC911X_CS;
> >
> > =A0 =A0 =A0 =A0l3ck =3D clk_get(NULL, "l3_ck");
> > @@ -136,6 +141,22 @@ static inline void __init
> omap3evm_init_smsc911x(void)
> > =A0 =A0 =A0 =A0else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate =3D clk_get_rate(l3ck);
> >
> > + =A0 =A0 =A0 /* Configure ethernet controller reset gpio */
> > + =A0 =A0 =A0 if (cpu_is_omap3430()) {
>=20
> cpu_is_omap3430() is not required, as this board init would not be
> called otherwise.
[Hiremath, Vaibhav] That is not quite true, why do you say this?

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_request(eth_rst, "SMSC911x g=
pio") < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(KERN_ERR "Fail=
ed to request GPIO7 for
> smsc911x\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(eth_rst, 1);
>=20
> Check for the return value
[Hiremath, Vaibhav] Will do in following version.

Thanks,
Vaibhav
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* reset pulse to ethernet controller=
*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(150, 220);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(eth_rst, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(150, 220);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(eth_rst, 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(1, 2);
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x i=
rq") < 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Failed to request G=
PIO%d for smsc911x
> IRQ\n",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3EVM_ETHR_GPIO_I=
RQ);
> > @@ -703,6 +724,10 @@ static struct omap_board_mux omap35x_board_mux=
[]
> __initdata =3D {
> > =A0 =A0 =A0 =A0OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPU=
T_PULLUP |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP=
_PIN_OFF_INPUT_PULLUP |
> OMAP_PIN_OFF_OUTPUT_LOW |
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP=
_PIN_OFF_WAKEUPENABLE),
> > + =A0 =A0 =A0 OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_=
PULLUP |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_=
PIN_OFF_NONE),
> > + =A0 =A0 =A0 OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT=
_PULLUP |
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_=
PIN_OFF_NONE),
> > =A0 =A0 =A0 =A0{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> > =A0};
> >
> > --
> > 1.6.2.4
> >
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
