From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/5] fbdev: omap2: panel-dpi: allow specification of a
 reset gpio
Date: Sun, 20 Dec 2015 11:33:33 +0100
Message-ID: <20151220103333.GF28361@pengutronix.de>
References: <1449753107-11410-1-git-send-email-uwe@kleine-koenig.org>
 <1449753107-11410-4-git-send-email-uwe@kleine-koenig.org>
 <5671A0E2.7000909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5671A0E2.7000909-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

[Cc +=3D devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org]

Hello Tomi,

On Wed, Dec 16, 2015 at 07:35:30PM +0200, Tomi Valkeinen wrote:
>=20
> On 10/12/15 15:11, Uwe Kleine-K=F6nig wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >=20
> > Some displays have a reset input. To assert that the display is
> > functional the reset gpio must be deasserted.
> >=20
> > Teach the driver to get and drive such a gpio accordingly.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/video/panel-dpi.txt | 1 +
> >  drivers/video/fbdev/omap2/displays-new/panel-dpi.c    | 7 +++++++
> >  2 files changed, 8 insertions(+)
>=20
> DT changes should be posted to devicetree-u79uwXL29TaiAVqoAR/hOA@public.gmane.org And, I thi=
nk,
> the binding document changes are usually as a separate patch.

Right for devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, but separate patches for bindings
is news to me. Anyhow, I can split this off if you prefer.

> > diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt =
b/Documentation/devicetree/bindings/video/panel-dpi.txt
> > index a40180b05bab..1a1d8f6f884f 100644
> > --- a/Documentation/devicetree/bindings/video/panel-dpi.txt
> > +++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
> > @@ -7,6 +7,7 @@ Required properties:
> >  Optional properties:
> >  - label: a symbolic name for the panel
> >  - enable-gpios: panel enable gpio
> > +- reset-gpios: GPIO to control the RESET pin
> > =20
> >  Required nodes:
> >  - "panel-timing" containing video timings
> > diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/d=
rivers/video/fbdev/omap2/displays-new/panel-dpi.c
> > index 1216341a0d19..7e2f9e0813dc 100644
> > --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> > +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> > @@ -32,6 +32,7 @@ struct panel_drv_data {
> >  	int backlight_gpio;
> > =20
> >  	struct gpio_desc *enable_gpio;
> > +	struct gpio_desc *reset_gpio;
> >  };
> > =20
> >  #define to_panel_data(p) container_of(p, struct panel_drv_data, ds=
sdev)
> > @@ -83,6 +84,7 @@ static int panel_dpi_enable(struct omap_dss_devic=
e *dssdev)
> >  	if (r)
> >  		return r;
> > =20
> > +	gpiod_set_value_cansleep(ddata->reset_gpio, 0);
> >  	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
> > =20
> >  	if (gpio_is_valid(ddata->backlight_gpio))
> > @@ -211,6 +213,11 @@ static int panel_dpi_probe_of(struct platform_=
device *pdev)
> >  	if (IS_ERR(ddata->enable_gpio))
> >  		return PTR_ERR(ddata->enable_gpio);
> > =20
> > +	ddata->reset_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> > +						    "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(ddata->reset_gpio))
> > +		return PTR_ERR(ddata->reset_gpio);
> > +
> >  	ddata->backlight_gpio =3D -ENOENT;
> > =20
> >  	r =3D of_get_display_timing(node, "panel-timing", &timing);
> >=20
>=20
> This looks a bit odd to me. This only ever sets the reset gpio to 0, =
on
> panel enable. If we never toggle the reset, it could be set to 0 at
> probe time, right?
>=20
> Reset is a bit tricky. I've seen panels where you have to have only a
> short reset pulse (reset high, wait a short time, reset low). If you
> leave the reset high, the panel draws extra power.
>=20
> So I think the best we can do in a generic way is just to ensure the
> reset is not asserted.

Good idea, will implement this in v2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
