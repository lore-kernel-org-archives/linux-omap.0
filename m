From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Date: Mon, 17 Jun 2019 12:40:48 +0100
Message-ID: <20190617114048.GN5316@sirena.org.uk>
References: <20190615163314.28173-1-andreas@kemnade.info>
 <20190617103111.GM5316@sirena.org.uk>
 <20190617130357.41204ff7@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ukZ3tWq1IjZw6zEx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617130357.41204ff7@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com, vireshk@kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


--ukZ3tWq1IjZw6zEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:03:57PM +0200, Andreas Kemnade wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:

> > Why is this a good fix and not defining the supported voltages?  These
> > look like fairly standard linear range regulators.

> I am fixing the definition of the two regulators in the patch.
> I am defining them as continuous.=20
> Voltage ranges are defined in
> arch/arm/boot/dts/twl4030.dtsi
> Only the continuous flag is missing.

> Is there anything else do you want to be defined?

These regulators are not continuous regulators as far as I can see, they
are normal linear range regulators and so should have their voltages
enumerable like any other linear range regulator.

--ukZ3tWq1IjZw6zEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HfEAACgkQJNaLcl1U
h9C9fgf/demCydc2jv+vdSyZVH8mb+/coXKQUhsJXvaspY3plQYlF5HnzQrABgHC
nFoahPYWwqbuRl4WzotNHAnblTLZz54cPzr+W89TPLVlfRLxKuF44I3807SJYW4f
+eh/7+cyOcyiA+eJba+PAG72l5oIkJszxNywvIDZENBjIc7exIxo5I8ee4zfTSoI
2uv7ZzaeVVrI/1j7SIuC2KlBhQ6j3qOPew1r0kpl66Q7zPNFf4AWzl2LbhjIuUVk
3BxJcetz+zA7NbCR2QIEr5o7vCnOuOLQQN8Dk1LNI4QxItF7MD0PXkSA33GCu8rD
uYW9FLSQK0YzKaeddERgm1nLLKkKYg==
=U7Iy
-----END PGP SIGNATURE-----

--ukZ3tWq1IjZw6zEx--
