From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/6] hwrng: omap3-rom - Call clk_prepare() on init and
 exit only
Date: Sat, 14 Sep 2019 14:54:27 +0200
Message-ID: <20190914125427.nvbrxoubvll43b3j@earth.universe>
References: <20190913220922.29501-1-tony@atomide.com>
 <20190913220922.29501-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g7gc3vmijk7ssgbr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190913220922.29501-4-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-crypto@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Adam Ford <aford173@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--g7gc3vmijk7ssgbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 13, 2019 at 03:09:19PM -0700, Tony Lindgren wrote:
> Also, we should not call prepare and unprepare except during init, and
> only call enable and disable during use.

Why? Usually clk_(un)prepare() is the part saving most power, so I
would expect the runtime resume handlers to call clk_prepare_enable
and vice versa in the suspend handler.

-- Sebastian

--g7gc3vmijk7ssgbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl184v8ACgkQ2O7X88g7
+przwRAApx3Dbs6XroHfe+gpVT73gb6Yc5/uExIITkplTaKX/ZIp+4hT0rAj8hzE
ctOOflg1pVF4LsEoF3O8wFbJMeSN9kwxQlP64ckgabIOWHhFRUSR9RHeqBWqUxvY
/KBDidv/6s8qFj26OdczLqUZYbwrE6XXk5aS/rxn+llaftWPLocxUg6PlcQqbhW2
jC9MKKyGN3/3a0AF6fU3nIlTpP5RQr+cxtbrNJ6qbRoKP6n6yMe5xCCERR2CG7d1
ROUdgSTIhDFtCWcfAREKmPJyXUA5XvjUthEzABnC43T6QsSqXARIzJoIt0xT9h/5
kRyxoGElflW65vvzy3JHP3uEkxsTqVZIMS4DKHRuZy6Xa9tN2u0O1c6TdqqAutq+
LglWMiaiUWSsKlN3nLkTO0YdEgnTB3Ygt5hrDDOFn8cgENCpjGEnLd1CbpsE3jIV
o7F1WQxBKoryScoOyaELPwBIUQ2HKxF35nZcpgWJrMFm57Ha5i5Num3cqitH9m1n
WCZM2/bMnJSvJ47tsezdfb0XYM0+01kyJhdytQbFtJzRBQw0bOJT72+AlYp4jIJO
j4JKXOVWPhtxoMpT3RpbNhS6hZ/AK1sxljNaX4O+IqMYhX8l5oY1ct+XDj3/V/fP
UO2+cjB34jZThu+9JByuf4suzcGJXooIFqm8PhTQCwp8w5ONFqc=
=/fji
-----END PGP SIGNATURE-----

--g7gc3vmijk7ssgbr--
