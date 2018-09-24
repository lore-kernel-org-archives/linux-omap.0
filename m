From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 3/6] dt-bindings: leds: Add bindings for lm3697 driver
Date: Mon, 24 Sep 2018 20:02:19 +0200
Message-ID: <20180924180219.GA24418@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-4-dmurphy@ti.com>
 <20180924161844.GA29028@bogus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924161844.GA29028@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Add the device tree bindings for the lm3697
> > LED driver for backlighting and display.
> >=20
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>

> >  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.=
txt
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

We already have binding for lm3697 in
Documentation/devicetree/bindings/mfd/ti-lmu.txt . Is it good idea to
have second one?
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlupJqsACgkQMOfwapXb+vJEYgCgqQleExRR9ieXCshxOqTbbojL
kxMAn3DjSk8hyZkZwItIvNre9+VJRM+s
=FKQ+
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
