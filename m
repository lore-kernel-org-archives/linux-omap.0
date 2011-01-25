From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] OMAP3EVM: Made backlight GPIO default state to off
Date: Tue, 25 Jan 2011 10:50:28 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD7BE1DD@dbde02.ent.ti.com>
References: <1295896947-30475-1-git-send-email-hvaibhav@ti.com>
 <AANLkTi=d-MDTv3_u7O2WKvD597od6pefqpW5O+kdXgPv@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E739404BD7BE1AA@dbde02.ent.ti.com>
 <AANLkTimpiptObg2qnZoW9hJOK+hVDAYOYaZ+tG8-QBua@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56565 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab1AYFUp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 00:20:45 -0500
In-Reply-To: <AANLkTimpiptObg2qnZoW9hJOK+hVDAYOYaZ+tG8-QBua@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>


> -----Original Message-----
> From: Varadarajan, Charulatha [mailto:charu@ti.com]
> Sent: Tuesday, January 25, 2011 10:24 AM
> To: Hiremath, Vaibhav
> Cc: Semwal, Sumit; linux-omap@vger.kernel.org; tony@atomide.com;
> tomi.valkeinen@nokia.com
> Subject: Re: [PATCH-V2] OMAP3EVM: Made backlight GPIO default state t=
o off
>=20
> On Tue, Jan 25, 2011 at 10:18, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
> >
> >> -----Original Message-----
> >> From: Semwal, Sumit
> >> Sent: Tuesday, January 25, 2011 8:05 AM
> >> To: Hiremath, Vaibhav
> >> Cc: linux-omap@vger.kernel.org; tony@atomide.com;
> tomi.valkeinen@nokia.com
> >> Subject: Re: [PATCH-V2] OMAP3EVM: Made backlight GPIO default stat=
e to
> off
> >>
> >> Vaibhav,
> >>
> >> On Tue, Jan 25, 2011 at 12:52 AM, Vaibhav Hiremath <hvaibhav@ti.co=
m>
> >> wrote:
> >> > If you choose default output to DVI, the LCD backlight used to
> >> > stay on, since panel->disable function never gets called.
> >> >
> >> > So, during init put backlight GPIO to off state and the driver
> >> > code will decide which output to enable.
> >> >
> >> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >> > ---
> >> > Changes from V1 -
> >> > =A0 =A0 =A0 =A0- Added check for return value
> >> >
> >> > =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 15 +++++++++++++--
> >> > =A01 files changed, 13 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mac=
h-
> >> omap2/board-omap3evm.c
> >> > index 7119380..a888a7d 100644
> >> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> >> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> >> > @@ -411,6 +411,8 @@ static struct platform_device leds_gpio =3D =
{
> >> > =A0static int omap3evm_twl_gpio_setup(struct device *dev,
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned gpio, unsigned ngpio)
> >> > =A0{
> >> > + =A0 =A0 =A0 int r;
> >> > +
> >> > =A0 =A0 =A0 =A0/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> >> > =A0 =A0 =A0 =A0omap_mux_init_gpio(63, OMAP_PIN_INPUT);
> >> > =A0 =A0 =A0 =A0mmc[0].gpio_cd =3D gpio + 0;
> >> > @@ -426,8 +428,17 @@ static int omap3evm_twl_gpio_setup(struct d=
evice
> >> *dev,
> >> > =A0 =A0 =A0 =A0 */
> >> >
> >> > =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 0 =3D=3D ledA, LCD Backligh=
t control */
> >> > - =A0 =A0 =A0 gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL"=
);
> >> > - =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> >> > + =A0 =A0 =A0 r =3D gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LC=
D_BKL");
> >> > + =A0 =A0 =A0 if (r)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to get lcd=
_bkl gpio\n");
> >> So even if the gpio_request fails, this code prints an error and
> >> continues?
> > [Hiremath, Vaibhav] yes, that's correct and intended.
>=20
> As pointed out by Sumit, you should not continue modifying the
> direction of a gpio whose request failed (may be some other module
> is using this gpio)? Please mention why this is intentionally done so=
=2E
>=20
[Hiremath, Vaibhav] First of all, if you look at implementation of gpio=
_xxx, it does handle all these scenarios gracefully.=20

And second point is, the request is happening for backlight gpio (which=
 is not something MUST required), so even if we fail to get handle here=
 I think we should not return an error, just flag the warning and conti=
nue.

Let me understand, why do you want to return from middle of function, f=
or backlight gpio request, which means we will not call "platform_devic=
e_register" for leds_gpio and many other things. And also if you look a=
t the twl4030-gpio.c, we do same thing -


        } else if (pdata->setup) {
                int status;

                status =3D pdata->setup(&pdev->dev,
                                pdata->gpio_base, TWL4030_GPIO_MAX);
                if (status)
                        dev_dbg(&pdev->dev, "setup --> %d\n", status);
        }
	 return ret;

I hope this clarifies your doubts.

Thanks,
Vaibhav
> >
> > Thanks,
> > Vaibhav
> >> > +
> >> > + =A0 =A0 =A0 if (get_omap3_evm_rev() >=3D OMAP3EVM_BOARD_GEN_2)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D gpio_direction_output(gpio +=
 TWL4030_GPIO_MAX,
> 1);
> >> > + =A0 =A0 =A0 else
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D gpio_direction_output(gpio +=
 TWL4030_GPIO_MAX,
> 0);
> >> > +
> >> > + =A0 =A0 =A0 if (r)
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to set dir=
ection of lcd_bkl
> >> gpio\n");
> >> >
> >> > =A0 =A0 =A0 =A0/* gpio + 7 =3D=3D DVI Enable */
> >> > =A0 =A0 =A0 =A0gpio_request(gpio + 7, "EN_DVI");
> >> > --
> >> > 1.6.2.4
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-=
omap"
> in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
