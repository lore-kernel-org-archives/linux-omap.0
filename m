From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Mon, 28 Dec 2015 23:49:23 +0100
Message-ID: <1451342963.14631.13.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ymqSXsFJFD9yQXOqJbge"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <568088B4.6090207-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-ymqSXsFJFD9yQXOqJbge
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Milo, thanks for the review,

Le lundi 28 d=C3=A9cembre 2015 =C3=A0 09:56 +0900, Milo Kim a =C3=A9crit :
> Hi Paul,
>=20
> On 23/12/15 20:56, Mark Brown wrote:
> > On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> >
> >> +	gpio =3D lp->pdata->enable_gpio;
> >> +	if (!gpio_is_valid(gpio))
> >> +		return 0;
> >> +
> >> +	/* Always set enable GPIO high. */
> >> +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "L=
P872X EN");
> >> +	if (ret) {
> >> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> >> +		return ret;
> >> +	}
> >
> > This isn't really adding support for the enable GPIO as the changelog
> > suggests, it's requesting but not managing the GPIO.  Since there is
> > core support for manging enable GPIOs this seems especially silly,
> > please tell the core about the GPIO and then it will work at runtime
> > too.
> >
>=20
> With reference to my previous mail, external GPIOs for LDO3 and BUCK2 in=
=20
> LP8725 can be specified through regulator_config.ena_gpio. BUCK2 only=20
> can be controlled by external pin when CONFIG pin is grounded.
>=20
> Please see the description at page 5 of the datasheet.
>=20
> 	http://www.ti.com/lit/ds/symlink/lp8725.pdf

After reading the datasheets thoroughly, it seems to me that for the
lp8720, the EN pin is used to enable the regulators output, which is a
good fit for the core regulator GPIO framework, as there is no reason to
keep it on when no regulator is in use. The serial interface is already
available when EN=3D0 and regulators can be configured in that state. The
lp8725 seems seems to behave the same when CONFIG=3D0 (the datasheet
clearly states: "CONFIG=3D0: EN=3D1 turns on outputs or standby mode if
EN=3D0"). On the other hand, it is indeed used as a power-on pin when
CONFIG=3D1.

Since my intent here is to cover the lp8720 use case, I suggest that we
implement this using the core regulator GPIO framework (I have patches
ready for that) and leave out the case where CONFIG=3D1, which could be
dealt with later by providing that piece of information via platform
data (and devicetree) and then either use the regulator GPIO framework
(when CONFIG=3D0 and default) or register the GPIO within the driver and
keep it on at all times (when CONFIG=3D1).

I could most certainly implement that behaviour, but I'd rather leave it
to someone else (or at least the testing) since I don't have any lp8725
to play with.

What do you think?

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-ymqSXsFJFD9yQXOqJbge
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWgbxzAAoJEIT9weqP7pUMW4YP/jCZmqRO+WONkjiP1EobL7eO
E73h0LSxtG+LEUgKF84J/ywDEzkl4IWF1L3G3CbDLeVVvhrQNZ4Dmwk3Hnv8Uvbp
z3Zwy/F8IIsj8m7+zalZ4L/X2jxCTzC2cTskgk1xF7anKL0IeTwQUAgPT2/rFsOK
+9BOT2ATV6hmesKSkKqksPZUa4yZybPxzpwpz/jKQFR8TpjiwPb1eK7itMjUoyiz
VJ3YOg3tdLEIX2ncr++0t5/49hhHKdn2Kc2HPvh8z3+PeUqQ0HKCt0qc1arqT7VA
J88XZZwy8canKUZVoLPouP8wSfWaZObfQatHtEm5en+8ij2e1TUOHXUs1qjDoKIN
aD2hpYsW6VvcExujO0TFMgspGmVqtyGdWWjG6XKjKOjj/vTu3uJOlqngYmKETsT3
dpJYbPbaghRFVdjiQd5o6sk4fZ7ZdfDSzpwEThDHu4W4J4fSEO6lfMzfTuiIeLIG
ocMOaDuUxlFfikAoeG5BA/vQp9rkTfm2s9rEJgli1C5SdmnKaP9Qb0Zy606tApRu
L3WR6S8O4LV3ses+66I/j1Kqo6c+BxGhE1JPIKH980CfheBoX3AYesADpGeGBbYz
1V4vUnESToKZqsrjqaAQozF7ezsansRrwUDesHBCG2TlZNDQz4p9k48Q09tkrX5e
fBXxbybRWTB/hGfCvdSL
=tJGs
-----END PGP SIGNATURE-----

--=-ymqSXsFJFD9yQXOqJbge--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
