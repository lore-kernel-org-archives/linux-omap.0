From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: overo: Add support for 4.3'' LCD output
Date: Tue, 20 May 2014 15:41:15 +0300
Message-ID: <537B4D6B.5070106@ti.com>
References: <1400589069-21572-1-git-send-email-florian.vaussard@epfl.ch> <1400589069-21572-3-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="C2hPikkvkVhstBrWI98lg8fqKcw6TUxIu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52646 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbaETMlt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 08:41:49 -0400
In-Reply-To: <1400589069-21572-3-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--C2hPikkvkVhstBrWI98lg8fqKcw6TUxIu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/05/14 15:31, Florian Vaussard wrote:

> +	lcd0: display@0 {
> +		compatible =3D "samsung,lte430wq-f0c", "panel-dpi";
> +		label =3D "lcd";
> +
> +		gpios =3D <&gpio5 16 GPIO_ACTIVE_HIGH		/* gpio_144: enable */
> +			 &gpio5 17 GPIO_ACTIVE_HIGH>;		/* gpio_145: brightness */

The panel-dpi only takes one gpio, the enable. The backlight should be
handled with gpio-backlight driver.

The same applies for the Alto35 patch.

 Tomi



--C2hPikkvkVhstBrWI98lg8fqKcw6TUxIu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTe01rAAoJEPo9qoy8lh71xQAQAIu4PgJWlIVjqNPzXCxjMMXw
qN6goGZBIOLenk8m/YlFksyn6RqoqDsKR4OlELCG9UQ8JzJJD5tWftSaC+1FziD6
9a00LZWGwJC6yHZQqaT6YzmwkQk4OF3ajnKgLRYn8JYF+VpMjwse6PbT+Tfm/0/f
07ivZt88uu2Q2Gr64aIz+NbQcsxok7pcxTFQTh5CbTtKcSKLz3FGoPBHYP4waCSw
Kd4FwXgozHRNxJrxSZqp06kApzHE7m8RH/XPcQgUMeoABC5SIo94pT63R2tQMjZ/
tvW4k4KbJvB61bFfv4IRlYC8ZKekh5+tmVbcQ67us+M2FeeIuoJNGfEY2L+OGsBU
HNxm2BQeBpX9Zrg6lIRMuIjfE6nObuTLhAZC4QP8gdPS7So7L0G7BCd3Wh8IwtVF
hPjEAOC2NJQToCkzx4mlZgm1LxDu7FLatyZrKk5eBsIyiBeZcjJy3gukUjZ+KRBZ
VY9/9MiiFLlfcQGFxw9ZWkR+fj0HyyR88JbJdXqXyIff+ixKdIjaTL/6gA52t5WL
ukxVel8peq7gKb3xok1APoxL4Qwo+IWMkhEevx7fWnfAjNKo+ePas4CKjLDqeCGu
9KdJpvJ0y74F/jDZ+jdwt6P5CHNMB4DDOTXJ3nbGt3h4LjVBgOQq64dVghbbvdyJ
zO7RkVzLJ2QzoHs9EzLs
=m0H/
-----END PGP SIGNATURE-----

--C2hPikkvkVhstBrWI98lg8fqKcw6TUxIu--
