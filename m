From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Wed, 14 Oct 2015 13:19:39 +0200
Message-ID: <20151014111939.GB14340@earth>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444819456-26728-3-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, wsa@the-dreams.de, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 14, 2015 at 01:44:16PM +0300, Roger Quadros wrote:
> Let's keep the SSI ports disabled in the omap3.dtsi to avoid
> getting the following noise on the console for boards that don't
> use the SSI ports.
>=20
> "omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (err=3D-=
2)"
>=20
> As omap3-n900 uses one SSI port, mark it enabled there.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWHjpLAAoJENju1/PIO/qaGV0QAJIETK/C4mFskQUN7+ub2ZQf
2LWnDMny4w209P0uzG8+9s7ssNUGvr9lrOlPYFvMZs4tsYHqmZNa/3cAFRyrt2Ca
HkSfqtehYuFTTRgaoO+6OSdPdvlwl1ty4VldCS0lSP7T+riTUgUBBvk2ZxakqWya
molh2HoTVwa+ek7z68UdWuC9V+hAsVjRRdQDIx5WacD8hrpBkssnggDMa6LwjLRJ
7v4wRA125IdlwNKOcagKu5L3IpwKD9M+pmLMYjD3bv9S/5U3NmAVFUgl2O2kVRNF
7euI9X125xNtpc1V/QSNRRdeIJzDK3UMzC2SFKergGwFQwsEz2eNqIsZMT8f7YBt
rnJTpsCpc7pI63mxINyD+I4uXGoljRIDe3jbcQczi9YbC+JuvAHiDmGtgW5moiZf
nFez5MMlStJjwuhTXhGxdmg9hd/5eBi3wt3Il8lVmzHDomPQimzxMe6+QliHxjXu
V43k2fZQHAywsGgN1L7u44gn9Iz82GcB8bzN1TTTAamJqMh338eZflzN5PNVMBB2
YUCX2txWj2xSIGQsUZnAmPoiRJFKzSF5Tc0udlEQPkk/29iAW8wFPOx6pgyXClZM
40zaPgM1+dzgFfFIayofND31eSv27+Re0Aw9PGgiJrq7STXTu486vzrVds20+Fod
4k10fFUaxVOfsLnik+Of
=AOR8
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
