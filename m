From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] regulator: tps65917/palmas: Cleanups and bugfixes
Date: Fri, 6 May 2016 18:14:53 +0100
Message-ID: <20160506171453.GX6292@sirena.org.uk>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
 <572C444F.9070304@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+2xxXFcoH1/fp7Az"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <572C444F.9070304@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-omap@vger.kernel.org


--+2xxXFcoH1/fp7Az
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 06, 2016 at 12:44:23PM +0530, Laxman Dewangan wrote:

> When you are here, can you implement the dt parsing with the new method from
> regulator framework.
> Regulator FW calls callback to parse customized DT property, just need to
> pass the node and pointer when registering.

> This will helps lots in cleanups and readability.

Yes, please.

--+2xxXFcoH1/fp7Az
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLNEMAAoJECTWi3JdVIfQGYsH/Rzv3ZaqVVdfrWRAruW/wNZi
Xnt9DqlTpyJMItoYAEzl7YsuzQlU2ZwtapYAnLVaCQaIE1KbYid5cIRSNMAiP6gi
h2GFtgp8m6E7dbwiQ8SibbZNDFVpGOLuPgK9ecCW920trdwsc19nTMrACd4IGjSr
qgjbVkkVjNEffDez/0PaPxJG3kilUusJyJZp7ZS8QYBtzN8prRldXXe1hsYjI318
vLQKW/+pi76A+Y3A+tcQfy0oIhcaJxisTkN5jrh4+/EYx0/H3fDXu+XDXHzbpD6/
38wW643yYVHZktNIMwQpt/rZZQmnYPUeo3y2G91IUw/wF2kIfkZhgNN0MGdYUTg=
=gOvU
-----END PGP SIGNATURE-----

--+2xxXFcoH1/fp7Az--
