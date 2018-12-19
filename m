From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] regulator: palmas: fix a missing check of return value
Date: Wed, 19 Dec 2018 17:51:53 +0000
Message-ID: <20181219175153.GK8130@sirena.org.uk>
References: <20181219050413.16374-1-kjlu@umn.edu>
 <20181219171139.39388-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iSeZnk6FyAS3EJ1y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181219171139.39388-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--iSeZnk6FyAS3EJ1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 11:11:39AM -0600, Kangjie Lu wrote:
> If palmas_smps_read() fails, we should not use the read data in "reg"
> which may contain random value. The fix inserts a check for the return
> value of palmas_smps_read(): If it fails, we return the error code
> upstream and stop using "reg".

Ah, thanks - I'd actually already applied the earlier version!

--iSeZnk6FyAS3EJ1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwahTkACgkQJNaLcl1U
h9CY7Qf9HfSZtw5pzUle7APOfkNoPh3jZG5dXXk8VlXNCXMrDuuoM+9w0LTFOgWj
e+CEoLowUGckkQf+5sPlY+qZBT7z942xfiXwl094TGSN9TZKpzA8kZGrjn1gAZdN
xRb9xO4MVKN4czCGExdv5v18RxT69jMrx0nENGD2krNLQYnYq5Z77L/qiJyjIo2r
oAaN3KMb484UlPoiR2mNSnK22vrqe/zEmPv0fmqBlGDwCLIlsHcTt8MfG8ckZHqv
ULOp9O/mHhAeGhvXLYmh5tqiVyO9WERaMH+t5nfuB+9HfsXpJRHpOPTkmOL6bb/a
1Wk6gu8A66H0DRRDRRB5dD+UxwTlBg==
=HrhO
-----END PGP SIGNATURE-----

--iSeZnk6FyAS3EJ1y--
