From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC] ARM: omap3: Enable HWMODS for HW Random Number Generator
Date: Tue, 10 Sep 2019 15:37:32 +0100
Message-ID: <20190910143732.3g3q4acvnx2pqvjx@earth.universe>
References: <20190828150037.2640-1-aford173@gmail.com>
 <20190905230443.GA52127@atomide.com>
 <CAHCN7xKxffJUV2V2CCuw0iPqUm4LJT28GMrcF2=8rDJQM2dOOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qrixv7njwauekhyc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xKxffJUV2V2CCuw0iPqUm4LJT28GMrcF2=8rDJQM2dOOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--qrixv7njwauekhyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2019 at 08:56:49AM -0500, Adam Ford wrote:
> On Thu, Sep 5, 2019 at 6:04 PM Tony Lindgren <tony@atomide.com> wrote:
> > Oh and this needs to default to status =3D "disabled" for
> > HS devices like n900 as it needs to use the omap3-rom-rng.
>=20
> I don't know enough about the HS version of the OMAP3, but what's the
> main difference between omap3-rom-rng and this one?

The OMAP HS chips have the bus firewall configured to block direct
access to some cryptography related devices. The kernel will crash
with a bus error, if you try to read/write the registers for
protected devices. The omap3-rom-rng avoids this by communicating
with the security middleware component instead of directly accessing
the RNG hardware.

-- Sebastian

--qrixv7njwauekhyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl13tSkACgkQ2O7X88g7
+prv8g//byjix58ZdQFHZMVKdcFO70kTP9egx8f9Bsi2ZGMy3ybyYweRBD1xerSj
9ytb9qNeNKC1Tn9R4HXWF2s0uG8YiCCwYv8XO2RGD1gBYc+ohxHMgu2LUHkqrYkd
4ch8aa6vWOfoYz5p6RZ4TSMifa6pEL/Dntv73BZ2iWyIPNFiU3G0JYERDwh1k2mE
zJQ/eEq/1G+ztEYBSa5HoRSLQUfgbpRWdnjw/WMQZMYIGb67iKJhEnFRl9bKdiS+
Bj0od1d1EuQWiYclgBn2qGrfxKbweSmX9rDGTsQKzzb32zUSYLd5eh4m6dpO3Cea
eWNc4w0cBN5XXDjmVf400xtdbhl4GNS0gwfHUb6QCHp4aSPKGIvv3rU2vt5Rf+HI
K/u+3sywozcr9D6NbgmTyGNRRUxpZZe7QZdAtIaZChEcwi8FgtCxmeAtnUyXHNxr
+0vPFHKA3IFKHfR2pNKu2UlS7HbKxUg+ZEgCq6dUAVGQ8BdNK5/a26MbJCASEGor
OLfajRDyxnyFSlV2rKMh2Ich5oD39lI+rwA2jIJf+EbcHAudd25/4mGxc6Gb2oBb
PgogxAzpXE95iStDWlUeoS/8Jh0hQtD/zb9amYgvwYSookOL9Wt39x5iMovt8IBm
pHpoVJGzv5+DB874xaKn0jUe988yQdhym1joC+xayv+LGfBQvkE=
=hSyU
-----END PGP SIGNATURE-----

--qrixv7njwauekhyc--
