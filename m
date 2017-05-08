From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 1/2] Input: pwm-vibra: new driver
Date: Mon, 8 May 2017 20:51:28 +0200
Message-ID: <20170508185128.2vkgkxn6cfnmkqc7@earth>
References: <20170505092823.26009-1-sebastian.reichel@collabora.co.uk>
 <20170505092823.26009-2-sebastian.reichel@collabora.co.uk>
 <20170507213800.GA39686@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzqtex6bzmdrjcpo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170507213800.GA39686@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--vzqtex6bzmdrjcpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Sun, May 07, 2017 at 02:38:00PM -0700, Dmitry Torokhov wrote:
> > + *  This program is free software; you can redistribute it and/or modi=
fy it
> > + *  under  the terms of the GNU General  Public License as published b=
y the
> > + *  Free Software Foundation;  either version 2 of the License, or (at=
 your
> > + *  option) any later version.
> > + */
> > +
> > +#define DEBUG
>=20
> I do not think this is needed.

Leftover from writing the driver :) Will remove in v4.

> > +
> > +#include <linux/input.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +
> > +/**
>=20
> This is not kernel doc, so no "/**".

Ack.

> > + * Motorola Droid 4 (also known as mapphone), has a vibrator, which pu=
lses
> > + * 1x on rising edge. Increasing the pwm period results in more pulses=
 per
> > + * second, but reduces intensity. There is also a second channel to co=
ntrol
> > + * the vibrator's rotation direction to increase effect. The following
> > + * numbers were determined manually. Going below 12.5 Hz means, clearly
> > + * noticeable pauses and at 30 Hz the vibration is just barely noticab=
le
> > + * anymore.
> > + */
> > +#define MAPPHONE_MIN_FREQ 125 /* 12.5 Hz */
> > +#define MAPPHONE_MAX_FREQ 300 /* 30.0 Hz */
> > +
> > [...]
> > +
> > +	vibrator->pwm_dir =3D devm_pwm_get(&pdev->dev, "direction");
> > +	err =3D PTR_ERR_OR_ZERO(vibrator->pwm_dir);
> > +	if (err =3D=3D -ENODATA) {
> > +		vibrator->pwm_dir =3D NULL;
> > +	} else if (err =3D=3D -EPROBE_DEFER) {
> > +		return err;
> > +	} else if (err) {
> > +		dev_err(&pdev->dev, "Failed to request direction pwm: %d", err);
> > +		return err;
> > +	} else {
> > +		/* Sync up PWM state and ensure it is off. */
> > +		pwm_init_state(vibrator->pwm_dir, &state);
> > +		state.enabled =3D false;
> > +		err =3D pwm_apply_state(vibrator->pwm_dir, &state);
> > +		if (err) {
> > +			dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
> > +				err);
> > +			return err;
> > +		}
> > +	}
>=20
> I wonder if the above is not better with "switch":
>=20
> 	switch (err) {
> 	case 0:
> 		/* Sync up PWM state and ensure it is off. */
> 		pwm_init_state(vibrator->pwm_dir, &state);
> 		state.enabled =3D false;
> 		err =3D pwm_apply_state(vibrator->pwm_dir, &state);
> 		if (err) {
> 			dev_err(&pdev->dev,
> 				"failed to apply initial PWM state: %d", err);
> 			return err;
> 		}
> 		break;
>=20
> 	case -ENODATA:
> 		/* Direction PWM is optional */
> 		vibrator->pwm_dir =3D NULL;
> 		break;
>=20
> 	default:
> 		dev_err(&pdev->dev, "Failed to request direction pwm: %d", err);
> 		/* Fall through */
>=20
> 	case -EPROBE_DEFER:
> 		return err;
> 	}

Ack.

> > +
> > +	vibrator->hw =3D of_device_get_match_data(&pdev->dev);
> > +	if (!vibrator->hw)
> > +		vibrator->hw =3D &pwm_vib_hw_generic;
> > +
> > +	input->name =3D "pwm-vibrator";
> > +	input->id.bustype =3D BUS_HOST;
> > +	input->dev.parent =3D &pdev->dev;
> > +	input->close =3D pwm_vibrator_close;
> > +
> > +	input_set_drvdata(input, vibrator);
> > +	input_set_capability(input, EV_FF, FF_RUMBLE);
> > +
> > +	err =3D input_ff_create_memless(input, NULL, pwm_vibrator_play_effect=
);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> > +		return err;
> > +	}
> > +
> > +	err =3D input_register_device(input);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
> > +		return err;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, vibrator);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused pwm_vibrator_suspend(struct device *dev)
> > +{
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct pwm_vibrator *vibrator =3D platform_get_drvdata(pdev);
> > +	struct input_dev *input =3D vibrator->input;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&input->event_lock, flags);
>=20
> Hmm, no, this is not goting to work. The original patch had a chance if
> PWM was not sleeping, but with introduction of regulator and work this
> definitely sleeps.

Actually PWM is sleeping, that's why I added work (regulator was
added later) :)

> I think we should solve issue of events [not] being delivered during
> suspend transition in input core, and simply drop spin_lock_irqsave()
> here and in resume().

Sounds good. will you take care of the input-core change?

> > +	cancel_work_sync(&vibrator->play_work);
> > +	if (vibrator->level)
> > +		pwm_vibrator_stop(vibrator);
> > +	spin_unlock_irqrestore(&input->event_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused pwm_vibrator_resume(struct device *dev)
> > +{
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct pwm_vibrator *vibrator =3D platform_get_drvdata(pdev);
> > +	struct input_dev *input =3D vibrator->input;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&input->event_lock, flags);
> > +	if (vibrator->level)
> > +		pwm_vibrator_start(vibrator);
> > +	spin_unlock_irqrestore(&input->event_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(pwm_vibrator_pm_ops,
> > +			 pwm_vibrator_suspend, pwm_vibrator_resume);
> > +
> > +#ifdef CONFIG_OF
> > +
> > +#define PWM_VIB_COMPAT(of_compatible, cfg) {			\
> > +			.compatible =3D of_compatible,		\
> > +			.data =3D &cfg,	\
> > +}
> > +
> > +static const struct of_device_id pwm_vibra_dt_match_table[] =3D {
> > +	PWM_VIB_COMPAT("pwm-vibrator", pwm_vib_hw_generic),
> > +	PWM_VIB_COMPAT("motorola,mapphone-pwm-vibrator", pwm_vib_hw_mapphone),
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, pwm_vibra_dt_match_table);
> > +#endif
> > +
> > +static struct platform_driver pwm_vibrator_driver =3D {
> > +	.probe	=3D pwm_vibrator_probe,
> > +	.driver	=3D {
> > +		.name	=3D "pwm-vibrator",
> > +		.pm	=3D &pwm_vibrator_pm_ops,
> > +		.of_match_table =3D of_match_ptr(pwm_vibra_dt_match_table),
> > +	},
> > +};
> > +module_platform_driver(pwm_vibrator_driver);
> > +
> > +MODULE_AUTHOR("Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>");
> > +MODULE_DESCRIPTION("PWM vibrator driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:pwm-vibrator");
> > --=20
> > 2.11.0
> >=20
>=20
> Thanks.

Thanks for the review.

-- Sebastian

--vzqtex6bzmdrjcpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkQvi4ACgkQ2O7X88g7
+poIrRAAirItprueaOEsIYyZcUNWX7lJRZQRq4UOygZr+K8mgGlzKVFLhcZJZya1
bejw5ILUvecdsTIh4J1ZZq9kjfHhyUWGGEEQXyCnRji/B6ce7E7A7TX7a15stmIP
p1n95OzfRmkVwXnPdG+VFkwwWnEgNYnKzHcaNVB25VZ5aBktLn7Q+62RK2i6aMqJ
x+0YYcd0zLO3NZ4F6CDphX5sT9fMo2fT/UuReqXQXQLP1vqggd7WQ+WuAMM45fIi
5Wzibc1h6WZZZDj9mDy0/tfLGwthlYa6wT/1B6TIDdlSl6eysoo73FgiziXZhU1y
J3x9RDo/WbvsZf5e6dL6+bEcdnVSukIglGdbSqDuRFnMYpBLefoGDJ16IzPSt02C
6DOFUDSy3PC85ZMbyX5A/akpYxhxKmJ//P16i8NSiWbo03e1t9nknrtFWT9T0wmp
wprhgYRDJCjaoW93oHlHTi3ppUVjdP+G1xVDSR4YN2hLODaevudr0ilbRI0q+dy/
TTxZu3PO65K3mODJlFd74tto5qv6GXz5pVCFK6+KNw4ByAaT30JNEivf9XoocVXX
xkiV1tycUloMEgfPBaTe4K2eC25vp5F/3ThXBgpMHnoN8xgVC2C5qzErBWBi+ccz
lGXdM4GXrlejo/jV5rJ4oJ0LhEmuGyexV1iF0BwuqcwHKfApPHk=
=iEMh
-----END PGP SIGNATURE-----

--vzqtex6bzmdrjcpo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
