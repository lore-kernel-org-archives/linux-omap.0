From: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Subject: RE: [PATCH v2] OMAP3EVM: ehci: Fix EHCI support
Date: Wed, 24 Aug 2011 18:03:41 +0200
Message-ID: <1314201821.2320.50.camel@bryan-HUTIA>
References: <1314174902-12797-1-git-send-email-bdefaria@adeneo-embedded.com>
	 <19F8576C6E063C45BE387C64729E739404EC007BC0@dbde02.ent.ti.com>
	 <1314189727.2320.16.camel@bryan-HUTIA>
	 <19F8576C6E063C45BE387C64729E739404EC007C71@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.adetelgroup.com ([78.155.151.235]:21843 "HELO
	mail1.adetelgroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751264Ab1HXQDn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 12:03:43 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404EC007C71@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

=46or the comment what about:
Set the VAUX2 regulator supply to 1.8V for the HSUSB host interface.
Tps65950 GPIO2 has to be set to zero in order to enable the EHCI select
line.

I see this patch as a fix for the EHCI support, what would you suggest
for the patch name?

Bryan
> Hi,
> > TPS65950 GPIO2 is to choose through u131 if we drive the lines to t=
he
> > evm mother board or to the expansion connector p18. Should not it b=
e
> > default to the mother board?
> It's not enabled by default and that=E2=80=99s why we need to enable =
it through
> Tps65950 GPIO2.
>=20
> Your patch looks fine but the comment and name needs to be changed as
> There is no clock which gets enabled using gpio2. All the HSUSB clock=
s
> Are handled inside driver at drivers/usb/host/ehci-omap.c
>=20
> Ajay
>=20
> > The EHCI port on the mother board works with this patch.
> >=20
> > Bryan
> >=20
> > > Hi,
> > > > Set the VAUX2 regulator supply to 1.8V for the HSUSB host
> > interface.
> > > > Gpio 2 of the TPS65950 has to be set to zero in order to enable=
 the
> > > > HSUBS2 clock.
> > >
> > > TPS65950 GPIO2 is not to enable HSUSB2 clock but to enable chip u=
131
> > > On omap3evm (rev-G) which latches USB, camera and audio lines.
> > >
> > > >
> > > > Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> > > > ---
> > > >  arch/arm/mach-omap2/board-omap3evm.c |   25
> > +++++++++++++++++++++++++
> > > >  1 files changed, 25 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/ma=
ch-
> > > > omap2/board-omap3evm.c
> > > > index c452b3f..13a2b71 100644
> > > > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > > > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > > > @@ -377,6 +377,10 @@ static int omap3evm_twl_gpio_setup(struct
> > device
> > > > *dev,
> > > >  	if (r)
> > > >  		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
> > > >
> > > > +	/* gpio + 2 =3D=3D HSUSB2 Clock Enable */
> > > > +	if (get_omap3_evm_rev() >=3D OMAP3EVM_BOARD_GEN_2)
> > > > +		gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW,
> > > > "EN_HSUSB2_CLK");
> > > > +
> > >
> > > Did you test EHCI port with this change ?
> > >
> > > Ajay
> > > >  	/* gpio + 7 =3D=3D DVI Enable */
> > > >  	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
> > > [...]
> > > rm-kernel
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
