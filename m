From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Thu, 24 Dec 2015 19:12:53 +0100
Message-ID: <1450980773.11913.3.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-cOvcqAHKDsfGng59WIn/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151223115632.GS16023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-cOvcqAHKDsfGng59WIn/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 23 d=C3=A9cembre 2015 =C3=A0 11:56 +0000, Mark Brown a =C3=A9cr=
it :
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
>=20
> > +	gpio =3D lp->pdata->enable_gpio;
> > +	if (!gpio_is_valid(gpio))
> > +		return 0;
> > +
> > +	/* Always set enable GPIO high. */
> > +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP=
872X EN");
> > +	if (ret) {
> > +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> > +		return ret;
> > +	}
>=20
> This isn't really adding support for the enable GPIO as the changelog
> suggests, it's requesting but not managing the GPIO.  Since there is
> core support for manging enable GPIOs this seems especially silly,
> please tell the core about the GPIO and then it will work at runtime
> too.

It looks like the core bindings for GPIO can only be used instead of the
rdev->desc->ops->enable callback, not jointly, which doesn't fit my use
case, where both the GPIO and register write have to be used to enable
regulators.

I think it would be worth making it possible to use both in core, since
that situation is probably shared with other regulators. I suggest the
following diff (that would be split into a separate patch in v2 of this
series):

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e92f344..dd0674f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1963,7 +1963,6 @@ static int regulator_ena_gpio_ctrl(struct
regulator_dev *rdev, bool enable)
 		if (pin->enable_count =3D=3D 0)
 			gpiod_set_value_cansleep(pin->gpiod,
 						 !pin->ena_gpio_invert);
-
 		pin->enable_count++;
 	} else {
 		if (pin->enable_count > 1) {
@@ -2063,6 +2062,14 @@ static int _regulator_do_enable(struct
regulator_dev *rdev)
 		}
 	}
=20
+	if (rdev->desc->ops->enable) {
+		ret =3D rdev->desc->ops->enable(rdev);
+		if (ret < 0)
+			return ret;
+	} else if (!rdev->ena_pin) {
+		return -EINVAL;
+	}
+
 	if (rdev->ena_pin) {
 		if (!rdev->ena_gpio_state) {
 			ret =3D regulator_ena_gpio_ctrl(rdev, true);
@@ -2070,10 +2077,6 @@ static int _regulator_do_enable(struct
regulator_dev *rdev)
 				return ret;
 			rdev->ena_gpio_state =3D 1;
 		}
-	} else if (rdev->desc->ops->enable) {
-		ret =3D rdev->desc->ops->enable(rdev);
-		if (ret < 0)
-			return ret;
 	} else {
 		return -EINVAL;
 	}

--=-cOvcqAHKDsfGng59WIn/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWfDWlAAoJEIT9weqP7pUMUuQP/1nRU7sWhsY+cdtmhrLFaNol
bbUc2AjUdyhU/2jVB6v5n0w22QjenIO4YtYeb2kpaA5jeX6P1NZVoKZ79rwKd4HV
rYeemWOtsRAnaxOFMzD9oP/KOworouFkKaf77ewqMbL7TfFiJ09/SuB7+jLIB109
JVHN0gdoIQxLSh/k/ZEZt9YBdu9UgWTGWU2TwUy1yNvjT/j4D3KjBJSa3JRwPqyq
Z/e4qclhBSWZJYuv+6Vw09fBGR5f61q/Y9uhdE6VRKNhfSA7MCCr4niu+MJgY/Wt
q/k77t1mHWqvqBMObwhtAyN15tgBYWWHjJU3KabHNjwBfnC9WaqbnnirUfxZ94o6
l8BW9pyQZOBuU64sZjrvXjuaUN7v7O/MLo8BvwTM5wZsjNIousRwuanBe4yRyXhs
iRdUGYo+ilmM2BumPzex+OmiozN7UbHYYnSnPRZkwXbzH60RMG+0X48FLXulRyfk
BJkfeI3qz3TDdLxNAZz7qgE/6rCj3wYzB7fcckG82nH7e6hT2VULMzbdIp3PbvtZ
lBxjLjZ01c7CV1X5Pi8CG7fSctTfANHpGrF5J7aO5MNojW0IilBGyouaXELk854B
lcCGasTxbo8xvBm8ToFpPzd5EXj0uDoIiYbhIsTjYW5jVs8Jr+owbNDIqbgJpORU
kfwYGfyQlq2htZqUBqkf
=vheG
-----END PGP SIGNATURE-----

--=-cOvcqAHKDsfGng59WIn/--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
