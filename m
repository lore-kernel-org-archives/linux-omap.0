From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
Date: Tue, 27 Feb 2018 00:30:33 +0100
Message-ID: <20180226233033.GA14094@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180226231336.GA18565@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@gmail.com>, linus.walleij@linaro.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, peter.ujfalusi@ti.com, Linux-ALSA <alsa-devel@alsa-project.org>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Mark Brown <broonie@kernel.org>, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> JFYI: This issues is tracked in the regression reports for Linux 4.16
> > >> (http://bit.ly/lnxregrep416 ) with this id:
> > >>
> > >> Linux-Regression-ID: lr#4b650f
> > >
> > > Ok, so it seems that issue is bigger: whole sound subsystem does not
> > > work. /proc/asound/cards is empty.
> > >
> > > 7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.
> > >
> > > I tried to revert sound/soc changes, and sound is broken, too. Nasty
> >=20
> >=20
> > dmesg log?
>=20
> Partial dmesg is at:
> https://github.com/pavelmachek/missy/blob/master/db/phone/nokia/n900/pave=
l/2018.1291171648263/dmesg.out
>=20
> I should be able to get full one...
>=20
> I did git bisect, and the winner seems to be:
>=20
> pavel@duo:/data/l/linux-n900$ git bisect bad
> c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
> commit c85823390215e52d68d3826df92a447ed31e5c80
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Wed Dec 27 16:37:44 2017 +0100

I reverted it on top of v4.16-rc2, and sound now works. Ideas?

(Aha, and I see I made small mistake reverting... but...)

								Pavel

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 564bb7a..50cc590 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -157,36 +157,6 @@ int of_get_named_gpio_flags(struct device_node *np, co=
nst char *list_name,
 EXPORT_SYMBOL(of_get_named_gpio_flags);
=20
 /*
- * The SPI GPIO bindings happened before we managed to establish that GPIO
- * properties should be named "foo-gpios" so we have this special kludge f=
or
- * them.
- */
-static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *=
con_id,
-					  enum of_gpio_flags *of_flags)
-{
-	char prop_name[32]; /* 32 is max size of property name */
-	struct device_node *np =3D dev->of_node;
-	struct gpio_desc *desc;
-
-	/*
-	 * Hopefully the compiler stubs the rest of the function if this
-	 * is false.
-	 */
-	if (!IS_ENABLED(CONFIG_SPI_MASTER))
-		return ERR_PTR(-ENOENT);
-
-	/* Allow this specifically for "spi-gpio" devices */
-	if (!of_device_is_compatible(np, "spi-gpio") || !con_id)
-		return ERR_PTR(-ENOENT);
-
-	/* Will be "gpio-sck", "gpio-mosi" or "gpio-miso" */
-	snprintf(prop_name, sizeof(prop_name), "%s-%s", "gpio", con_id);
-
-	desc =3D of_get_named_gpiod_flags(np, prop_name, 0, of_flags);
-	return desc;
-}
-
-/*
  * Some regulator bindings happened before we managed to establish that GP=
IO
  * properties should be named "foo-gpios" so we have this special kludge f=
or
  * them.
@@ -230,7 +200,6 @@ struct gpio_desc *of_find_gpio(struct device *dev, cons=
t char *con_id,
 	struct gpio_desc *desc;
 	unsigned int i;
=20
-	/* Try GPIO property "foo-gpios" and "foo-gpio" */
 	for (i =3D 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id)
 			snprintf(prop_name, sizeof(prop_name), "%s-%s", con_id,
@@ -245,14 +214,6 @@ struct gpio_desc *of_find_gpio(struct device *dev, con=
st char *con_id,
 			break;
 	}
=20
-	/* Special handling for SPI GPIOs if used */
-	if (IS_ERR(desc))
-		desc =3D of_find_spi_gpio(dev, con_id, &of_flags);
-
-	/* Special handling for regulator GPIOs if used */
-	if (IS_ERR(desc))
-		desc =3D of_find_regulator_gpio(dev, con_id, &of_flags);
-
 	if (IS_ERR(desc))
 		return desc;


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqUmJkACgkQMOfwapXb+vIZagCfQFlDUl2ERptijp9TZH6xUCsb
xtMAn3iHq1MnaNloSnqeMpQyxd5xLyF9
=KExY
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
