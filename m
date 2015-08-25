From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Tue, 25 Aug 2015 14:50:44 +0100
Message-ID: <20150825135044.GJ27431@sirena.org.uk>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
 <1437996250-2913-2-git-send-email-kishon@ti.com>
 <20150814180006.GB10748@sirena.org.uk>
 <55D2C872.9000400@ti.com>
 <20150819181149.GZ10748@sirena.org.uk>
 <55DC3D58.4030409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55DC3D58.4030409@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2015 at 01:03:04PM +0300, Grygorii Strashko wrote:
> On 08/19/2015 09:11 PM, Mark Brown wrote:

> > So substract this address from the start of the resource to get the
> > offset?  Or provide a wrapper function in the resource code which does
> > that. =20

> I'd be very appreciated if you have and can share any thought on
> How can we get this absolute base address to substract?

Ask the syscon device for its resource?  Or have it provide an absolute
address based interface for that matter?

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3HKzAAoJECTWi3JdVIfQNPQH/iwE5u8dw8DI56x0gBtqou9D
1nFzcRvJDsNV5k0ANg1KRyPGYUxWTb66x0rUV59IEQstvvDpmfI8Vm7eZzV1OQeo
AJJ4HgmSSTaNSWPzbaRpKPdNq6523l38JKvoipqgwStYhsUeYo8dtPEUMrf4Gkhg
/JXKufoC2VxpEPua082RdiXeICA5vXIx2MXpO40/y0CQkJP44Ig5qlNu3IO71jNz
ywUElfDFQqHHffl7WRXGaqI+dH/22fm1GnWB/soXV3z8EjAj+t13qzMuaL/dtkx9
jIwce7tZ0D027uFiJMvc5BPni7RlOLtZajsq+8RkgmLbezF0qgTIZQIqQax9OOs=
=wEXm
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
