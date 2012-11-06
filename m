From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Reorder the wait_for_completion for tx
Date: Tue, 6 Nov 2012 10:22:24 +0100
Message-ID: <20121106092224.GL5044@opensource.wolfsonmicro.com>
References: <1352193447-23335-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352193447-23335-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2012 at 02:47:27PM +0530, Shubhrajyoti D wrote:
> The commit  d7b4394e[Cleanup the omap2_mcspi_txrx_dma function]
> changed the wait_for_completion order. Move the wait so that the
> rx doesnot wait for the tx to complete.

Is this a resend of the patch I just applied, or is it something
different?

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmNbCAAoJELSic+t+oim9T3YP/34q9mZYCIO5uKpruiARCz+V
0Ylr/1t2X79Qrx5JjGp4rmaN2V3w1PBoq/VXTmRj57YOamWa3cazQmW5iMZgprfu
8JCDs4GynVPzpo1X4p6LJJKMT91V26omRiREuhjUO6ZWTmG/gqxMHajUS7AYDe89
dU4UbtVAhi+teAOOsWHLjt4SlObXo61LWk/qo2mWmsyowvhhHtAhfZRrl4E2zbR+
+a0DizyexDG9n3D1tPn95TibmDnA05jIwxzw3mRoGlhaErqIu4uswXU2ZvCV7HsN
GG+Mh6olVaEiFlOv0BQ5VFrZBPSGRSF+Io++5Q9YB6USUbNazea8UBHreLqLRkFo
onUwR6BsFIWk8BZgmPfdcaLdB8NNeF3YqQZmuQJgQYQQx7kuAKd029twnywXEGx+
MdzEf+1Nbfti0Gxus4/ubE9pZrrwqZsYrpkhSIQCe0n1ECsRsXiCenJw3YQ5bmOi
XdUwcnqU0cdNUrm5pQqt4zBFQYIh44ep6cOhV0oFrmFh7KCuT5tMNPBFOUA4SdJb
J6tGjsNVDBuNyGkvoI00yfiIars2uiYKrM6GvR3dPDn4WovxlZ6CzE3j+UMKXtf1
4mG2y6VQWFjZPEaTCi/RDATk3X0r+mlErHR9CZU48emnl0qGpZWN917shBejTAY7
aua2QZsU4ptcxxt77wDh
=LGPp
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
