From: Josh Cartwright <joshc@ni.com>
Subject: Re: Bunch of machines are not booting in next again, GPIO regression?
Date: Wed, 17 Feb 2016 13:55:43 -0600
Message-ID: <20160217195543.GA871@jcartwri.amer.corp.natinst.com>
References: <20160217192755.GC21202@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160217192755.GC21202@atomide.com>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Michael Welling <mwelling@ieee.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 11:27:55AM -0800, Tony Lindgren wrote:
> Hi Linus,
>=20
> Looks like ff2b13592299 ("gpio: make the gpiochip a real device")
> broke booting on all omaps, and probably other machines too according
> to this:
>=20
> https://kernelci.org/boot/all/job/next/kernel/next-20160217/
>=20
> So far we've gone from 1 failed machine with next-20160216 to
> 18 failed machines with next-20160217.
>=20
> The error I'm getting on omaps is below with debug_ll enable,
> any ideas?

Hey Tony-

Looks like the newly allocated gpio_device object isn't zeroed,
confusing dev_set_name.  Can you give this a try?

  Josh

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d8511cd..59f0045 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -435,7 +435,7 @@ int gpiochip_add_data(struct gpio_chip *chip, void *dat=
a)
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
 	 */
-	gdev =3D kmalloc(sizeof(*gdev), GFP_KERNEL);
+	gdev =3D kzalloc(sizeof(*gdev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 	gdev->dev.bus =3D &gpio_bus_type;

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWxNA7AAoJEKp7ZBKwQFArFuYH/2omKDUL4Zld0ij6V078IS6N
7ZIgGu9tyKnfVVGmD11ZKOpfiZkmYwJ2WMhKemaE5eePTA/Xji48gLHPutj0VjrN
eKjvIg5RxtSZ3d08AscX5UODfSQ85yDuN2oYw1NpBL0xEnxWJ8MP26lL/z5fiZh1
0jE/slZl1ikZgS/sAG/mVkEX7AxHeWNCTI/hThXdI0/QG9mF9YhTwjvP4XAl4uwe
YwkkMSMHChy5bdcdDNawWwvmafWAikMp8S3ZhHfgMOwj4T2QGVIybpOoMsD2jRPV
xVUSXE6aCZzpIDr6JStp6plqaHGtF3bAuNYvGPt/qTVlTmCKFIIAEwmQ0OFRulk=
=4EWe
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
