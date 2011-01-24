From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP3EVM: Made backlight GPIO default state to off
Date: Mon, 24 Jan 2011 20:33:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD65F507@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1295879772-14086-1-git-send-email-hvaibhav@ti.com>
 <AANLkTinbJjrcP0EjjGTSL-9C4n5XTtON7byGq=8Ye0TG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37443 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab1AXPED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 10:04:03 -0500
In-Reply-To: <AANLkTinbJjrcP0EjjGTSL-9C4n5XTtON7byGq=8Ye0TG@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Varadarajan, Charulatha [mailto:charu@ti.com]
> Sent: Monday, January 24, 2011 8:12 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; tony@atomid=
e.com
> Subject: Re: [PATCH] OMAP3EVM: Made backlight GPIO default state to o=
ff
>=20
> On Mon, Jan 24, 2011 at 20:06,  <hvaibhav@ti.com> wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > If you choose default output to DVI, the LCD backlight stays on,
> > since panel->disable function never gets called.
> >
> > So, during init put backlight GPIO to off state and the driver
> > code will decide which output to enable.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 =A05 ++++-
> > =A01 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index 1b8a806..3f5117a 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -448,7 +448,10 @@ static int omap3evm_twl_gpio_setup(struct devi=
ce
> *dev,
> >
> > =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 0 =3D=3D ledA, LCD Backlight c=
ontrol */
> > =A0 =A0 =A0 =A0gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
>=20
> Check for the return value and then only proceed
>=20
[Hiremath, Vaibhav] I do agree with you, we should check the return val=
ue. But just to clarify on this, the line above is not being added be m=
e. Its original code.

I will change the patch and submit it again shortly.

Thanks,
Vaibhav
> > - =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> > + =A0 =A0 =A0 if (get_omap3_evm_rev() >=3D OMAP3EVM_BOARD_GEN_2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_=
GPIO_MAX, 1);
>=20
> Check for the return value
>=20
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_=
GPIO_MAX, 0);
>=20
> Ditto
>=20
> >
> > =A0 =A0 =A0 =A0/* gpio + 7 =3D=3D DVI Enable */
> > =A0 =A0 =A0 =A0gpio_request(gpio + 7, "EN_DVI");
> > --
> > 1.6.2.4
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
