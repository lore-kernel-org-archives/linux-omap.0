From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Wed, 21 May 2014 15:44:54 +0300
Message-ID: <537C9FC6.8020104@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-5-git-send-email-tony@atomide.com> <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com> <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com> <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com> <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xpK7v2KfhktUI3jTN0Oj8XrBLrXP9G2hB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbaEUMpa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:45:30 -0400
In-Reply-To: <20140513213205.GB18001@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>

--xpK7v2KfhktUI3jTN0Oj8XrBLrXP9G2hB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/05/14 00:32, Tony Lindgren wrote:

> +&dss {
> +	status =3D "ok";
> +	vdds_dsi-supply =3D <&vpll2>;
> +	port {
> +		dpi_out: endpoint {
> +			remote-endpoint =3D <&lcd_in>;
> +			data-lines =3D <18>;
> +		};
> +	};
> +};

I just noticed the vdds_dsi-supply there. While the driver currently
uses that if available, I think it should be removed, and done the same
way Florian did with his overo patches:

/* Needed to power the DPI pins */
&vpll2 {
	regulator-always-on;
};

That supply is not DSS's supply, but it's used to power up the pins. If
the pins were used as GPIOs, that power should be enabled.

 Tomi



--xpK7v2KfhktUI3jTN0Oj8XrBLrXP9G2hB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfJ/GAAoJEPo9qoy8lh716JsP/1ZfdXg29Y4pgxRAe29m9sex
wNKAIbnYzl8MMQviJ9BMHKSIqryYT8375JOL69P1JzDtZ6ZZCXinYxpS44RU5FDi
+klfT5IOMeC75au+uHKdeGOOky+zoNpzaVhs4HvJw77gFpRMvzvkZIjP2GqwapZe
/o7//zcnpzhsyBzAY8od9NYR0FWMYDca2b6oYqohJmnN1SJpTanivxmBYQ8swYEr
X+S9B7DuGDJaJajFeZR1uo5RBig5gVEmMF5O/y7zgfeLMSyUkWtOGW51GJWPifbi
RNxci+lia0ZHelIRxxMBfYDft3diiO8ZKA25HcTqerxQBn0SMI5KwRgdkFfGjGVY
Ht7vmZO4J8U6iVYAAPh3jwE8qss9dR4qLrH9sQzVkMHZuACKhniHf2tf8+eG9/u/
9/O6OCf+RIbjR6+ITkmdknroBM4onUboNT41bU5Fcpn6UxglJ0a9/9xkYZGxpPOX
u49/YYOY3dGekYsY5Pa0ba9eZ+eI52AbPwOFc0d9ei3uupZt9SXg2vSI2oaG8eHR
iouihZ4ZyXY6Le91DirttrwU3+pmnu0OW4oPRylyWFXQYXGNso8+1w83oaevThk+
MPoauEjatreqhpq5GdqnEJWz8VQuSmaLjhjIwM7JWzZprqRO5jG8LsJCv2auxoeH
28Wjn78xXc44wOrvY2Dj
=GcNQ
-----END PGP SIGNATURE-----

--xpK7v2KfhktUI3jTN0Oj8XrBLrXP9G2hB--
