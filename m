From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH/RFC] pwm: omap: Add PWM support using dual-mode timers
Date: Thu, 12 Dec 2013 14:43:07 +0100
Message-ID: <20131212134305.GM11524@ulmo.nvidia.com>
References: <20131024173620.0cbbefcf@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPrm2PuLP7ysUh6c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:49944 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3LLNoY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 08:44:24 -0500
Content-Disposition: inline
In-Reply-To: <20131024173620.0cbbefcf@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org


--bPrm2PuLP7ysUh6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 05:36:20PM +1100, NeilBrown wrote:
>=20
> I submitted this in December last year.  I got lots of good feedback
> and fixed some things, but it never got accepted.  Not entirely sure
> why, maybe I dropped the ball.
>=20
> Anyway, here is again with device-tree support added.
>=20
> This is only an RFC and not a real submission for two reasons, both of wh=
ich
> are really directed as Jon.
>=20
> 1/ I have to=20
>=20
> #include <../arch/arm/plat-omap/include/plat/dmtimer.h>
>=20
> which is incredibly ugly.
> Is there any reason this cannot be moved to include/linux/omap-dmtimer.h?
>=20
> 2/ I found that I need to call
>=20
> 	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);
>=20
>  when using device-tree.  This is because with devicetree
>  omap_timer_restore_context() is called much more often and it sets the c=
ounter
>  register to 0 .. it takes a long time to count up to DM_TIMER_LOAD_MIN f=
rom there.
>=20
>  Now I don't object to calling omap_dm_timer_write_counter (though it mig=
ht be nice if
>  omap_dm_timer_set_load wrote the one value to both LOAD_REG and COUNTER_=
REG).
>  However it seems wrong that I have to call it *after* starting the count=
er.
>  Currently _write_counter refuses to run if the timer hasn't been started.
>=20
>  So Jon:=20
>    a/ can we change omap_dm_timer_write_counter to work when the timer is=
n't
>       running?
>    b/ can we have omap_dm_timer_set_load also set the counter?
>=20
>=20
> For anyone else generous enough to read my code: is this otherwise accept=
able?
>=20
> Thanks,
> NeilBrown
>=20
> -------------------------------------------------
> This patch is based on an earlier patch by Grant Erickson
> which provided PWM devices using the 'legacy' interface.
>=20
> This driver instead uses the new framework interface.
>=20
> The choice of dmtimer to be used can be made through platform_data
> by requesting a specific timer, or though devicetree by giving
> the appropriate device-tree node.
>=20
> Lots of clean-ups and improvements thanks to Thierry Reding
> and Jon Hunter.
>=20
> Cc: Grant Erickson <marathon96@gmail.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap.txt b/Documen=
tation/devicetree/bindings/pwm/pwm-omap.txt
> new file mode 100644
> index 0000000..5f03048
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-omap.txt
> @@ -0,0 +1,32 @@
> +* PWM for OMAP using dmtimers
> +
> +TI's OMAP SoCs contains dual mode timers (dmtimers), some of
> +which can driver output pins and so provide services as

s/driver/drive/

> +a PWM.  When using this driver it will normally be necessary
> +to programmer an appropriate pin to server as a timer output.

s/programmer/program/ and s/server/serve/

> +
> +Required properties:
> +- compatible: must be
> +   "ti,omap-pwm"
> +
> +- timers: a device-tree node for the dmtimer to use
> +
> +- #pwm-cells: must be <2>.

The canonical form to write this these days is:

- #pwm-cells: Should be 2. See pwm.txt in this directory for a description =
of
  the cells format.

> +
> +Example:
> +
> + pwm: omap-pwm {
> +   compatible =3D "ti,omap-pwm";
> +   timers =3D <&timer11>;
> +   #pwm-cells =3D <2>;
> +
> +   pinctrl-names =3D "default";
> +   pinctrl-0 =3D <&pwm-pins>;
> + };
> +
> +...
> + pwm-pins: pinmux_pwm_pins {

I don't think dashes work in labels or phandles. They do work in node
names, though, so this could be:

	pwm_pins: pinmux-pwm-pins {
		...
	};

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 75840b5..0e3cf83 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -110,6 +110,15 @@ config PWM_PCA9685
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-pca9685.
> =20
> +config PWM_OMAP

This doesn't seem to be properly ordered now. I suspect that back when
you posted that last time PCA9685 support hadn't been merged yet and the
rebase messed this up.

I wonder: does the OMAP not have dedicated PWM hardware?

> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 77a8c18..322ddf0 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
> +obj-$(CONFIG_PWM_OMAP)		+=3D pwm-omap.o
>  obj-$(CONFIG_PWM_PUV3)		+=3D pwm-puv3.o

Same ordering issue here.

> diff --git a/drivers/pwm/pwm-omap.c b/drivers/pwm/pwm-omap.c
[...]
> +/*
> + *    Copyright (c) 2012 NeilBrown <neilb@suse.de>

I guess that'd include 2013 now?

> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/pwm.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/omap-pwm.h>

I'd prefer these to be sorted alphabetically.

> +#include <../arch/arm/plat-omap/include/plat/dmtimer.h>
> +
> +#define DM_TIMER_LOAD_MIN		0xFFFFFFFE
> +
> +struct omap_chip {
> +	struct omap_dm_timer	*dm_timer;
> +	enum pwm_polarity	polarity;
> +	unsigned int		duty_ns, period_ns;

These should no longer be necessary. polarity, duty_ns and period_ns are
available in struct pwm_device nowadays.

> +	struct pwm_chip		chip;

Nit: If you sort the chip field first, then the to_omap_chip() below
essentially becomes a no-op.

> +};
> +
> +#define to_omap_chip(chip)	container_of(chip, struct omap_chip, chip)

This should be a static inline function for type checking.

> +/**
> + * pwm_calc_value - Determine the counter value for a clock rate and per=
iod.
> + * @clk_rate: The clock rate, in Hz, of the PWM's clock source to comput=
e the
> + *            counter value for.
> + * @ns: The period, in nanoseconds, to compute the counter value for.
> + *
> + * Returns the PWM counter value for the specified clock rate and period.
> + */
> +static inline int pwm_calc_value(unsigned long clk_rate, int ns)

Nit: perhaps rename ns to period to make the purpose clearer?

> +static int omap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns)
> +{
> +	struct omap_chip *omap =3D to_omap_chip(chip);
> +	int load_value, match_value;
> +	unsigned long clk_rate;
> +
> +	dev_dbg(chip->dev, "duty cycle: %d, period %d\n", duty_ns, period_ns);
> +
> +	if (omap->duty_ns =3D=3D duty_ns &&
> +	    omap->period_ns =3D=3D period_ns)

This condition easily fits on a single line.

> +		/* No change - don't cause any transients. */
> +		return 0;
> +
> +	clk_rate =3D clk_get_rate(omap_dm_timer_get_fclk(omap->dm_timer));

I'd prefer this to be split up into getting a struct clk * and then
querying that.

> +static struct pwm_ops omap_pwm_ops =3D {

static const, please.

> +	.enable		=3D omap_pwm_enable,
> +	.disable	=3D omap_pwm_disable,
> +	.config		=3D omap_pwm_config,
> +	.set_polarity	=3D omap_pwm_set_polarity,
> +	.owner		=3D THIS_MODULE,
> +};

I prefer these not to be aligned at all. It doesn't add to the
readability and makes a mess when a new function is added with a name
longer than "set_polarity".

> +static int omap_pwm_from_pdata(struct omap_chip *omap,
> +			       struct omap_pwm_pdata *pdata)
> +{
> +

There's a spurious blank line here.

> +	/*
> +	 * Request the OMAP dual-mode timer that will be bound to and
> +	 * associated with this generic PWM.
> +	 */
> +
> +	omap->dm_timer =3D omap_dm_timer_request_specific(pdata->timer_id);
> +	if (omap->dm_timer =3D=3D NULL)

For consistency with the remainder of this driver I'd prefer this to be:

	if (!omap->dm_timer)

> +		return -EPROBE_DEFER;

Can there ever be another failure? Perhaps an invalid timer_id? I
suppose that if the omap_dm_timer API can't provide more details this is
as good as it gets. Ideally omap_dm_timer_request_specific() would
return an ERR_PTR()-encoded error code which you could then simply
propagate.

> +	/*
> +	 * Configure the source for the dual-mode timer backing this
> +	 * generic PWM device. The clock source will ultimately determine
> +	 * how small or large the PWM frequency can be.
> +	 *
> +	 * At some point, it's probably worth revisiting moving this to
> +	 * the configure method and choosing either the slow- or
> +	 * system-clock source as appropriate for the desired PWM period.
> +	 */

Move what "to the configure method"? There's nothing here that could be
moved.

> +#ifdef CONFIG_OF
> +static inline int omap_pwm_from_dt(struct omap_chip *omap,
> +				  struct device *dev)
> +{
> +	struct device_node *np =3D dev->of_node;

I don't think you necessarily need this temporary variable. You only use
it twice. If you make the change I propose a little further down, you'll
only reference it once so keeping it around isn't useful.

> +	struct device_node *timer;
> +	if (!np)
> +		return -ENODEV;
> +	timer =3D of_parse_phandle(np, "timers", 0);

Could use a blank line to separate the above two. Although with the
change proposed below the if (!np) check can actually go away.

> +	if (!timer)
> +		return -ENODEV;
> +
> +	omap->dm_timer =3D omap_dm_timer_request_by_node(timer);
> +	if (!omap->dm_timer)
> +		return -EPROBE_DEFER;
> +	return 0;

Could use another blank line to separate the above two lines. Again it
would be nicer if omap_dm_timer_request_by_node() returned some kind of
precise error. Unless there really are no errors other than the device
not being there yet (therefore assuming deferred probe will eventually
succeed).

> +}
> +#else
> +static inline in omap_pwm_from_dt(struct omap_chip *omap,
> +				  struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +static int omap_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct omap_chip *omap;
> +	int status =3D 0;

There should be no need to initialize this.

> +	struct omap_pwm_pdata *pdata =3D dev->platform_data;
> +
> +	omap =3D devm_kzalloc(dev, sizeof(*omap), GFP_KERNEL);
> +	if (omap =3D=3D NULL) {

"if (!omap)", please.

> +		dev_err(dev, "Could not allocate memory.\n");

We don't need an error message here.

> +		return -ENOMEM;
> +	}
> +	if (pdata)
> +		status =3D omap_pwm_from_pdata(omap, pdata);
> +	else
> +		status =3D omap_pwm_from_dt(omap, dev);

I'd like to propose that this be rewritten as:

	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
		status =3D omap_pwm_from_dt(omap, dev);

The reason is that you can now simply drop the #ifdeffery around the
function's implementation, remove the dummy and have the compiler
automatically discard the function for !OF. That gives you compile
coverage for free.

> +	if (status)
> +		return status;
> +
> +	omap_dm_timer_set_source(omap->dm_timer, OMAP_TIMER_SRC_SYS_CLK);
> +	/*

Could use another blank line.

> +static int omap_pwm_remove(struct platform_device *pdev)
> +{
> +	struct omap_chip *omap =3D platform_get_drvdata(pdev);
> +	int status;
> +
> +	omap_dm_timer_stop(omap->dm_timer);
> +	status =3D pwmchip_remove(&omap->chip);
> +	if (status < 0)
> +		return status;
> +
> +	omap_dm_timer_free(omap->dm_timer);
> +
> +	return 0;
> +}

Perhaps call pwmchip_remove() last so that omap_dm_timer_free() is
always called, even if pwmchip_remove() fails?

That way you can also make it somewhat shorter using:

	return pwmchip_remove(&omap->chip);

> +
> +static const struct of_device_id omap_pwm_of_match[] =3D {
> +	{.compatible =3D "ti,omap-pwm"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, omap_pwm_of_match);

I think this will need #ifdef protection, otherwise the usage of
of_match_ptr() below will make this static and unused.

> +static struct platform_driver omap_pwm_driver =3D {
> +	.driver =3D {
> +		.name	=3D "omap-pwm",
> +		.owner	=3D THIS_MODULE,

=2Eowner no longer needs to be assigned, since the core takes care of that
nowadays.

> +		.of_match_table =3D of_match_ptr(omap_pwm_of_match),
> +	},
> +	.probe		=3D omap_pwm_probe,
> +	.remove		=3D omap_pwm_remove,

The alignment here is also not necessary. Note how .name and .owner have
been aligned with tabs, but then .of_match_table messes it all up by
being so long. Better not artificially align at all.

> +};
> +module_platform_driver(omap_pwm_driver);
> +
> +MODULE_AUTHOR("Grant Erickson <marathon96@gmail.com>");
> +MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION("2012-12-01");

Hehe, haven't seen one of these in a while. Do we really need it?

> diff --git a/include/linux/platform_data/omap-pwm.h b/include/linux/platf=
orm_data/omap-pwm.h
[...]
> @@ -0,0 +1,20 @@
> +/*
> + * omap-pwm.h

I don't think we really need the filename here.

> + *
> + *    Copyright (c) 2012 NeilBrown <neilb@suse.de>
> + *
> + *    This program is free software; you can redistribute it and/or
> + *    modify it under the terms of the GNU General Public License
> + *    version 2 as published by the Free Software Foundation.
> + *
> + * Set the timer id to use for a PWM

Nit: s/id/ID/

> + */
> +
> +#ifndef _OMAP_PWM_H_
> +#define _OMAP_PWM_H_
> +
> +struct omap_pwm_pdata {
> +	int	timer_id;

More needless alignment.

Thierry

--bPrm2PuLP7ysUh6c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqb1pAAoJEN0jrNd/PrOhgI8P/1QcCNfUjyd5eTXYEzsIRIN+
KA4QpmK3IOoTjDHSb+4vFH/FSpEQwNrS+2G/yjyJgZBd5nT5LGTVAM38hpEbB3l8
4JJCjYONxyq2Ej5Gqb+yvTx5AEuzmXDUl2Tvm/Tg5EbnzRSxjctrAjSAErOjzii2
GFQHG0zB49ioZckbEfA2EbuTOXDg1/R0lkgbLnb4mBj1ivOtY/E7AbqR7FZCZu3y
Er+2Lp5BR5gUL9gzoA9yz14Hxup6TjH9wdjJkhKt3XUegvgDG1TIHgXWb1WJNYiW
IrgEgGxzqTcRzP/dOvMpiy5fZtfydY74sxrql2PZKOWK4rUvIGKmVSGuQ509bLqN
vlkD6uQKPTFwAhb8GcGCcqMJ4YemMbgJgbOey95xJJM23CNQGUXLoEoQjV+kVy61
P+Fb2S38lbgICODC+xVBIzzjR5pHihQKcXFr9CDpq1WYxNFuPnVQVJOKL2uSXttY
mAOfGVtK9cY6HmVRfBvfCqYlTVL/RywJGpa0D6mApCNoX/ud/LFg0kGjwErmYHMU
Duq0cQuUFF7tgviKb1kJCB48bA+m6aeBJxG+3d3uZXbdGzdjZX0siPLnSpUqqt4O
+3osZrrkP0rK7ah9fZfHc3lTzY9yBiXGGISUuuOJ/v1GyrlAnTNAlp59dFM4a5pH
OKAUA2UeRVjJMjAEcF29
=IYWU
-----END PGP SIGNATURE-----

--bPrm2PuLP7ysUh6c--
