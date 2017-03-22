From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] Regmap IRQ fix and related changes CPCAP
Date: Wed, 22 Mar 2017 03:22:10 +0100
Message-ID: <20170322022210.7u4taeepbraf6jaq@earth>
References: <20170317003633.7361-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ukzhm2b2ajvy6rpy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317003633.7361-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ukzhm2b2ajvy6rpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 05:36:29PM -0700, Tony Lindgren wrote:
> Here are few fixes to make CPCAP PMIC interrupts work reliably when
> used with multiple drivers. While working on the ADC, charger and
> USB PHY drivers I noticed that the PMIC interrupt to the SoC would
> eventually stop working.
>=20
> All these can wait for v4.12 merge window as these issues don't show
> up currently. Two of the patches are also harmless currently, so I've
> kept them in this series to avoid pointless merge conflicts.

The series is

Tested-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--ukzhm2b2ajvy6rpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljR39IACgkQ2O7X88g7
+ppmIw/+IOSmK5y7jeoMZrlccL4l8d1n1e39M4Q5Xp+WxYg6N3IpRvc9S2iSV9dL
J+XkyDyfUU3gfVmvT9iu1gcwaqZXxBjvMQSeJidIqjOGmjSD/rpbLQgeUhW0ox4V
VSg3B1zOqfSZ2PFOc9+yVdY3P4aH6TmS2GvvmtxkDKbj+ZwI4iR+IBE8WG9mWYGY
ATcNURP/3wEdPPbNXUcHJhsNvBrUgkQTQkqVHTJeBR9f5rrubUImeMi1Oq29eN3l
aa/CM4zfXk0zfxiBOP3a9WVvN6LDFeMIxP8lHUZRKaP6kw7Vwnl3Az7bnx6k3vim
r451kmSFpdQDyu+1cg18OWrCUL5KaX2F9PNqMEky3E88Dsf9yTbmKRISIKFUhMvZ
H68I5OMwqkTtOPh1Bhw+qdto5d+NSfT5aIHCJMMK1Zx474DgmRuT+5YBo6OB+2Vv
gSX0sC+nLdJp61bmtFzbEQsNNQmUJDNJ2/TcXqjkOesmSn0n0P/lAqTgFtSaJ0KN
rHajqoEN8TwmfNChQLRcRZSv0gUCpIsRgkNt80dX8uaaYXr5B8Vcgl2Qm04L/gIQ
6Bo3ZXjHP9HKrTG/14+9W8Yn34Ya7nJ1dSNGZtDevwDh8+HssgrO5VWamWFNGeWl
W5TXIHoXSxwdpvoD8GUz/7SEpCMXrKH7xKI6yi4hwG8UdisFdyI=
=R8Dh
-----END PGP SIGNATURE-----

--ukzhm2b2ajvy6rpy--
