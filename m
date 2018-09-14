From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Fri, 14 Sep 2018 10:23:58 +0200
Message-ID: <20180914082358.GB21830@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> All be it the analog side of these devices may be the same but the digita=
l side for each chip is different.
> The register maps are not the same, the number of supported LED strings a=
re not
> the same, there are features not supported by this driver and will
> be a pain to add.

Digital side looks similar enough that Milo was able to share code
between them.

Yes, obviously register map will be different.

> Adding features will be a complete night mare especially for the LM3632 w=
hich also support Torch and Flash.
>=20
>=20
> Here are where a single driver will start getting messy and support diffi=
cult
> LM3533 has ALS and an ADC for an ALS analog sensor
> LM3631 has no ALS functionality
> LM3632 has strobe/torch functionality and no ramp support
> LM3633 has lvled support coupled with the hvled support
> LM3695 does not even appear to be available publicly
> LM3697 is the only device that that this driver could be used for as is.

We already been through this once. More than one of these has ramp
support, and more than one has overvoltage protection. (Plus, all of
them are LED drivers).

Surely non-ugly design can be done where the code is shared?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlubcB4ACgkQMOfwapXb+vIx/ACdGLXPOdVkAMSp7NmhmCy2KVeL
cRUAoIQy7E5m6AYFpZEe0fo4ejivKwqL
=XvZc
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
