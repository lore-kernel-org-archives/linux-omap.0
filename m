From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Wed, 22 Apr 2015 09:20:02 -0500
Message-ID: <20150422142002.GA22596@saruman.tx.rr.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429632533-23285-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Grygorii Strashko <grygorii.strashko@linaro.org>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 09:08:53AM -0700, Tony Lindgren wrote:
> Looks like omap_gpio_irq_type can return early at several places
> leaving a GPIO bank enabled without doing pm_runtime_put if wrong
> GPIO arguments are passed.
>=20
> Instead of adding more complicated BANK_USED macros, let's fix the
> issue properly. We can pass is_irq flag to omap_enable_gpio_module
> and omap_disble_gpio_module. And with that we can remove all the
> similar code elsewhere to get rid of most BANK_USED macros.
>=20
> Note that the reason for the BANK_USED macro is that we need to manage
> PM runtime on per GPIO bank basis. In the long run we want to move to
> using PM runtime counts for each GPIO line to determine if a GPIO
> bank is used. Once we have a solution for omap_enable_gpio_module
> and omap_disable_gpio_module, we can remove the remaining BANK_USED
> macros.
>=20
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Javier Martinez Canillas <jmartinez@softcrates.net>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

looks ok to my eyes.

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN64SAAoJEIaOsuA1yqRE3f8P/1SK95u0gCkfieFT5CG9wnuh
mzXaBs0zLJO9IGuu2vv89CPgGwdtm5q8kv/0WYmwBN9NTkIApMfxyzIZ1Ao8H5aI
ZX6uM46yRwrpbaeVsWUn7sB99XJEIz1CDYq4awRl51J2EQlfF2oUfOAzqD4EMOPq
XEj2cdBx2yE/gQWFClUY2mxCgqSGQhvHcT5Q8KABE+hMVu21cS6gitZ4ge7X+9EO
e0cceLGSVyhOiPUR0Yt6uCcmwLz9Q7+4koCyTvnSPuH8rzcaNV2Mm40gFr0ItFEd
RDWoigsGjMSjYsOOkaWN2jKKW8V7VSchodefgD8HoLjej5LfsxdCs1yJFbSVr6sX
LWqf1fZMJyMrtHtl4pN5yHrKU4usFQIQYpbdLksON9U3LmYWE2WPZMJ3U0cZZ0fn
yw3t0u+UXbqRLDNofVgcbQs17Zvb0qlWfWGtFyjV/cmpc8bsnf1Ov/ERBdhEpA8w
yJ7g3Oy22tyPynGDno82Bdp4bxvtxMsuTJTTgkREkdH3Btsl0Yf0qqm1rBzaND0S
Stuy4R1qA7YFBrXNRryI3ymNPZvqFvD+YYBQsQU67c11Lp0gTpgmNq5qxmnb9vGh
aldWn2u8tIY4691OglEnLG6rMBa/7LkmcwS26oVOryOMwoy7C651kEm9Hjw5Qk2+
B0Lgv8qDJpZ00knko7k6
=4tDk
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
