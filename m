From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Date: Tue, 9 Aug 2016 15:59:52 +0200
Message-ID: <20160809135952.GA1666@katana>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
 <20160809115740.GA5528@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160809115740.GA5528@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Michal Simek <michal.simek@xilinx.com>, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Jochen Friedrich <jochen@scram.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Seth
List-Id: linux-omap@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 01:57:40PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Wolfram,
>=20
> On Tue, Aug 09, 2016 at 01:36:17PM +0200, Wolfram Sang wrote:
> > The core will do this for us now.
>=20
> Would be nice to point out the relevant commit that changed the core in
> the commit log.

I agree, but it was a series of commits[1] so I skipped that idea.

[1] http://www.spinics.net/lists/linux-i2c/msg25496.html


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXqeHYAAoJEBQN5MwUoCm2NckQAJyW/JvI0urSd/AbV7A333of
X12IGIzG1Uw3qrR5t5D5v5/V1XRSY8Bv8EbxcRHDhQwtIG7llvZrN0Lu8dFW8KLc
b0NiNapsFPkv7tgyOcDKvcB2f6YeTWuznWTcfCO4emNAKOt4W581rYp+NHidDNkd
WvauJi7ZRXof0JXh6PyyjN3OBGeQZ7uBVKtxsHMi7VkLxnBjIHIqs4Qfy3UJ8t2w
Mc0Q5oFU2XjhE57SkZYxdtOu+LSolckROvKtsCVMi1s3Nec1M1P9RD5HIIrlvah3
H86mjmZRs+3pWwEPuhgwChmFzGdYMMO0YewET5UeZLWIxag3vl6mdii62GKLA12L
txu2xrIWYzAk8L8ID/u40kjOe7ToNauzeqFjUHSQHctzxafjmy0nIEq5huMlFCWI
LOlienxQBDwcEwBNJLNyxAJCfM1U8rM2qj8NOWITqySCBh7a7ETPGNe4p34s+/kD
sdSks0LjcnSMQaVLKfKYrv7c31d6Edc2pu31SzF5R+gyeDajVXs05Zwh3/nbeMCM
kliHCZ3S79VNBs3lKQJRCt2lI/6oorJH4cvYx8gsu1E744R4PZ9siueAvmJB1zKT
ABziT6BTjt+PGNinBwtR/5zQ8klSTqcEPa0Kw+I1b8KXE8392yqDy3UVE7dIdWhW
dFPYJIiAo2AgTDmSbAHT
=kjW1
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
