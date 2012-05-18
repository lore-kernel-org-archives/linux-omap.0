From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/11] ASoC: OMAP: HDMI: Introduce codec
Date: Fri, 18 May 2012 17:32:40 +0100
Message-ID: <20120518163240.GM4039@opensource.wolfsonmicro.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
 <1337323363-11449-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36146 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab2ERQcn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 12:32:43 -0400
Content-Disposition: inline
In-Reply-To: <1337323363-11449-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: lrg@ti.com, x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2012 at 01:42:33AM -0500, Ricardo Neri wrote:
> Introduce codec for HDMI. At the moment, this is a dummy codec. In the
> future it will parse the EDID to modify the supported parameters, such
> as the number of channels and the sample rates. At the moment, it blindly
> supports all the sample rates and audio channels described in the HDMI
> 1.4a specification.

Applied this one, though I had to manually fix up the Kconfig and
Makefile - you should always submit against the current development
tree.

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPtnmhAAoJEBus8iNuMP3d1UcP/33DRTWIIK0/cEJMe8fvlxw6
VVePo5fAEnvcGtLjw0xM8BO70Nc5qV3r5+Adz2j9vqf7664VkkubJ/9A+VOBcNEM
8KgZhchbDozKSZ9X/GxgEuYxC9Is3XLlaqeciBDARjQt1JvnKnn1T++gWaNbCLel
nTDDJUptzw1daeL2e/JxRpQj5mSqxbWW3GLA+0hOzZx3EWjAhW98W9wCwWL0FLbf
jmCq/EsCKQ8ItHrQ/L5hcTP5K2XLWG1jI09r11ZUVTA7F5wkhggo9L7FVSuLEZ8O
/Lrgl5vvz+zS31bAVfaLLXDjXvCnGG46XqEHzqBT8GyorRk/hQal76Xf/uEboYu7
cC8mWXrsRsv2DQfUgRvXoFLRC0eC8p5aBCJVFfkoyk/I+9SiAfHiF8tfgevQVV01
izd6R4+7ecVPoY+aKul3aE1/u8UjvlYP/AbxDqQaMT5aPlBMt5v7zNeOmdhMwNX9
cjw5MEuJ40utTIzo6Sq8RcjP8khST2RbJqeroaa9xL0sI1LoZN6JLbQOM1D0lIWE
ThGPiMPQkNKIHrZOK4yb678dtD9mJNVTDENqkhFC4Hf7EJABeNgTDIZznsqox9PO
hCgyDpWNSHA5/+x4sxY5mxiv2C5NvwVivheN88T0QULOa5V7NVGVrAT3QpDnWqt1
RCrVhVOJVhqNYFAgWng8
=XFBG
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--
