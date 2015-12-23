From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS
 GPIO
Date: Wed, 23 Dec 2015 11:41:26 +0000
Message-ID: <20151223114126.GR16023@sirena.org.uk>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-4-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450868319-20513-4-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Milo Kim <milo.kim@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 11:58:36AM +0100, Paul Kocialkowski wrote:
> Some devices don't hook the DVS pin to a GPIO but to ground or VCC.
> In those cases, it is not a problem to have no DVS GPIO.

I would expect the driver at least needs to know how the pins or
strapped, or otherwise have configuration for ignoring the input on the
pins.  This just deletes the warnings, it doesn't have any handling for
this case that I can see.

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeohlAAoJECTWi3JdVIfQhxcH/16aoKYCBQFn6uJa44boXVg+
QE2MUruEO+MIIvUVQDX3DmAbpyNUqpEMR2Ueg+rwQXs446eQy5SEh7OzLfcBTPS4
eZ0kuOlGYqomwQKZNWjw9MQYap44r36sijJSIOUijgQoJD3C9gqHAwlZxli+hRlP
EpvwWrqx0US1VJbcJCwr+eIeOyQd+LSORhQG0uYUuF38KH2zANyFoQmHSEGXi/SR
9Y/qDdbMFJK1ppUuppsKz6B1uMSctz9HEKUKVzHHEc7LgBqS24e5gX4NpPgX/B5r
UzM7Vznc6JR18MRbU9H1hqjpTGDs9a1lqohGCVHqOwa+Dm7ORZBtpxePrYtA67o=
=nY0D
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
