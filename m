From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange platform devices for
 ASoC drivers
Date: Fri, 23 Nov 2012 11:12:12 +0900
Message-ID: <20121123021211.GL4385@opensource.wolfsonmicro.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
 <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
 <50A5F0A5.2010105@ti.com>
 <50A6805C.3050004@ti.com>
 <50AA2D01.5020302@ti.com>
 <20121120011526.GF4483@opensource.wolfsonmicro.com>
 <50AD6FB0.3050808@ti.com>
 <20121122010358.GB4371@opensource.wolfsonmicro.com>
 <50AED989.40408@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44366 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758829Ab2KWCMR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 21:12:17 -0500
Content-Disposition: inline
In-Reply-To: <50AED989.40408@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, tony@atomide.com, lrg@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 08:03:53PM -0600, Ricardo Neri wrote:
> On 11/21/2012 07:03 PM, Mark Brown wrote:

> >instantiation infrastructure in there which is rather Linux specific.

> But the board files are only for Linux, right? The ASoC drivers will
> always be initialized anyways. They will reach probe only if the
> devices are present.

Could you be more specific please?

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrttsAAoJELSic+t+oim9rwcP/0HTPo3LvQ58XnbqoSrzASw3
0Yr3AB0eNIJ2THDzEw84xIBu8zO0tVebY8d3D/5u7DYjECByHo0QaDglbaxa8ChF
5sUmSw8Ja/cZnzx/a3OB3OOM9sDLolpfpIKsAnINeJSF79k7pVDcLSot3VKvCfUw
VOTaMl7CnUtn7pBwOeAJTShgBQyvfwbrReYDdhkik7rUoMDOR+PaapYdBXA2ZPBx
sphZswIRTz+3Q3GIfLBh0V7mD8HIzfA4DlWPPVx2Qw2QN43eUTBvDwxrFOkZa0pe
OxoiaZ1SNXxS64JU672zN9j0R5s7eVDuVjd8MnlxncHsE+W02dYASQrSkH2vP3uF
lvfgOupEGZjhny9TeK09XCulBuyzyf0N2+i9VKj8FkNv+lF1XiYsEI0lQWzFDDUS
d/z+jIyzCjtheLoQ4cKijRG2vtcIW8/MdxX4s3CQXZ0R4JCz2QzZ/BINd3wVcv+e
U68nBCWXeqq91kvnbbnVa9B4/g5U2LlkU6LzJUGxCyOqixuy++WiIaFZDUlcNLpF
/j8eNTqsbzxHwSln1rP/MXVik+BHokf2/TaLZ4EJ7MEi7o4uzUJmR4Sddl/m1so2
3871xd7E6efDjks6r3GBgH0lCfoyp00qtqZP8vvDUdwkCgdojbNfMbUqsUYhJW7j
NNlPP7mNh2MMdtjw1At+
=5g71
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--
