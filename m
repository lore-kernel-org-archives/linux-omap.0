From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 0/7] i2c: omap: updates
Date: Mon, 5 Nov 2012 09:46:07 +0200
Message-ID: <20121105074607.GA32468@arwen.pp.htv.fi>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43655 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab2KEHwZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 02:52:25 -0500
Content-Disposition: inline
In-Reply-To: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, w.sang@pengutronix.de

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Sun, Nov 04, 2012 at 04:14:26PM +0530, Shubhrajyoti D wrote:
> Does the followiing
> - Make the revision a 32- bit consisting of rev_lo amd rev_hi each
> of 16 bits.
>=20
> - Also use the revision register for the erratum i207.
> - Refactor the i2c_omap_init code.
>=20
>=20
> Also more cleanup is possible will check on that subsequently.
>=20
>=20
> Tested on OMAP4430sdp  ,4460 ,omap3630 ,3430 and omap2430.
>=20
> For omap2 testing the below patch was used
> [PATCH] ARM: vfp: fix save and restore when running on pre-VFPv3 and CONF=
IG_VFPv3 set
>=20
> Also for using the pm testing below patches are used.
>=20
> arm: sched: stop sched_clock() during suspend
> ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
>=20
> Also available through
> git://gitorious.org/linus-tree/linus-tree.git i2c_omap/for_3.8
>=20
>=20
> Shubhrajyoti D (7):
>   i2c: omap: Fix the revision register read
>   i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
>   i2c: omap: remove the dtrev
>   ARM: i2c: omap: Remove the i207 errata flag
>   i2c: omap: re-factor omap_i2c_init function
>   i2c: omap: make reset a seperate function
>   i2c: omap: Restore i2c context always
>=20
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +-
>  drivers/i2c/busses/i2c-omap.c              |  166 +++++++++++++++++-----=
------
>  include/linux/i2c-omap.h                   |    1 -
>  4 files changed, 104 insertions(+), 75 deletions(-)

since I have reviewed your previous version, it would be nice to Cc me
so I don't loose your series ;-)

--=20
balbi

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl26/AAoJEIaOsuA1yqRE2GgQAKEDyz8STQ12WUy2GKIk5VAy
dxb4HtZ+81bwvAJXMW2aUE1XQkFQFVUs2J3zaBQH3r0ds5vMm9D7STMD6ti44tJq
4FDsSL5Hk0lWFnqdusq/PbQJOOcib6onDvCoZ/0n5pRfrDrNNOXwPSHrOY0wLopq
Xnwl3lB3CZQEqHtVcOv8SlRzAI5S8knlK5b2hAan1bqXIhnu9cKtIdcZovaKLEbd
q7wv53yuTJYCEE6MARrZsFKJfZsHwIy2ws/Y0mxdewDFKhrq7/xLgl3nDSyy852J
aWxj58DTqkqLZPzFFognvQAf4A+6bsDZ6bzNQ5h8TnU3wc6dxnNKNc1iErNUc0Mh
SEl8SgGK88mXxFfPwwPieog98ioW9UgSpJh/+eaQDkozWH9IGmJipW+hlmTEPBJb
UNZTxvT0kSSY13BhaB/HHL3nnGdNhE3qFBAM/7HomCIo4/D8Tjdx3Hp0YJxn2yLG
Z5wOi6zXGyRvblwS4KAl2O8A9c2UfrC+3VmE8S0hqLgUNEciX5ZQ7omxwXbiNgH4
N5Us3UKfWgdGvAQdOQQXU2OhVd2Xv1Im5ExnuP8js6hP9aoem89K1D33edXuk3IO
kwkEooXexghV5zibWCs0E6ool9E/5qmL5sjpzCPyeiKsNowVSglkZIWYUg4i/CK1
TZ0ystBdjVkcEF0sc7E2
=GI0z
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
