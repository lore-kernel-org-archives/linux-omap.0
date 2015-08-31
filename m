From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Mon, 31 Aug 2015 15:52:49 +0100
Message-ID: <20150831145249.GO12027@sirena.org.uk>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
 <1437996250-2913-2-git-send-email-kishon@ti.com>
 <20150814180006.GB10748@sirena.org.uk>
 <55D2C872.9000400@ti.com>
 <20150819181149.GZ10748@sirena.org.uk>
 <55DC3D58.4030409@ti.com>
 <20150825135044.GJ27431@sirena.org.uk>
 <55E42FF7.9010706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XLpnloaskCRyB6mV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E42FF7.9010706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--XLpnloaskCRyB6mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2015 at 04:14:07PM +0530, Kishon Vijay Abraham I wrote:
> On Tuesday 25 August 2015 07:20 PM, Mark Brown wrote:
> > On Tue, Aug 25, 2015 at 01:03:04PM +0300, Grygorii Strashko wrote:
> >> On 08/19/2015 09:11 PM, Mark Brown wrote:

> >>> So substract this address from the start of the resource to get the
> >>> offset?  Or provide a wrapper function in the resource code which does
> >>> that. =20
> >=20
> >> I'd be very appreciated if you have and can share any thought on
> >> How can we get this absolute base address to substract?
> >=20
> > Ask the syscon device for its resource?  Or have it provide an absolute
>=20
> Even if we get the absolute address of syscon, we have to do the
> subtraction only for the newer dtbs (previous dtbs already have only the
> offset). Do you recommend adding a new property to differentiate between
> older dtbs and newer dtbs? Any other suggestions here?

Hang on.  This is the first I've heard of any DTs not just having
absolute addresses.  How does any of this work - has it ever worked, and
is the situation completely understood?  My original concern with this
was that I coudn't understand the commit log and your original response
seemed to indicate that we always have the absolute address :(  Perhaps
this is something to do with the brief mention of having moved the DT
node for some reason?

We at least need some sort of coherent explanation of the problem and a
comprehensible fix to go with it.  Right now it seems like things are
just being moved about to hide problems without either of these things
which seems like it makes the code less clear and more fragile.

> > address based interface for that matter?

> Syscon doesn't directly expose any API's to write to it's register.
> Rather it uses regmap APIs to read/write to it's register. I'm not sure
> if it's possible to add regmap APIs to write to a register with absolute
> address. Any hints?

Yes, I'm aware that it is regmap based!  What I am suggesting is that if
people are making DTs like yours with devices that are children of the
syscon then presumably it might be useful for it to allow client drivers
to pass absolute addresses in so that it can translate for them.

--XLpnloaskCRyB6mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5GpAAAoJECTWi3JdVIfQTZkH/joidheooGIGCzTHjnT44Vsz
roSo0Q/Md0Md5k5rGHkjNA2u2Fud+SP2Gj30i6Yg8d8ZWE/sAIpL66gVCTl5PrKE
TTCz2BGB4xTGF/dAd7RtTHKKfELVHEuVa/I5lAEUxZx5KR06kQJ9poh2bpa/4F21
xvbxxBZmxaGxVXbCP/XcYSpdOtw0GdqoeXZNAb2sNx2D1kBmVqoyFASbnq7QKSJT
iIwyT3hzlu71TbGReOIAjlmXjda3VkBf24QUNRhwNkmy49dYfvnzKi5jKRlq4I/I
3TtMe+ZP+8DP3bWc3JWrqT8/Slko8L1ctuzFWVf3hoR8wqjY4med74k1KkaLeTY=
=7ZBh
-----END PGP SIGNATURE-----

--XLpnloaskCRyB6mV--
