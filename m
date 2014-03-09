From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: tlv320aic31xx: Add basic codec driver
 implementation
Date: Sun, 9 Mar 2014 08:13:10 +0000
Message-ID: <20140309081310.GN28112@sirena.org.uk>
References: <cover.1394195429.git.jsarha@ti.com>
 <3bd49217f42db2ac889ae61632c3e9b91bb71dd2.1394195429.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7wSVvjdhopu+7bZ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55907 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaCIINP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Mar 2014 04:13:15 -0400
Content-Disposition: inline
In-Reply-To: <3bd49217f42db2ac889ae61632c3e9b91bb71dd2.1394195429.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com


--C7wSVvjdhopu+7bZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2014 at 02:58:33PM +0200, Jyri Sarha wrote:
> This commit adds a bare bones driver support for TLV320AIC31XX family
> audio codecs. The driver adds basic stereo playback trough headphone
> and speaker outputs and mono capture trough microphone inputs.

I've not looked at this since at least the issue with the mic bias
naming still applies.

--C7wSVvjdhopu+7bZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHCKTAAoJELSic+t+oim97ioP/11bsIPvxLAZIMYaOGPJGWar
S+Xv7vbFPBmUdWIteJuRhA2o1diF53JPf5Cf30gIkSrBGZsCUtkLlF9Bql1kau8t
dOuQFhT4jEaajgZjpQjpTdcJJpdeKIvZu4ar8reCi8YHxbus/5g8LHwfB4iY/vql
1tFJGb+apycs4JqM5GM2NaKujTqgbmfcOZxkjIsI4GwkPxoKCpWzIQi1FTRBxiK2
XtYqM6WCz+/LZzXePKlckvWtko0GDAF6k2VqhdRx12vm6eNaSfkZT4M3wbSjMM52
VmBN+jbWiCBQoU7ww0DWlIVGJdrMBI+81YvvxLGClXvDT3mEhvtRcRCyPzhwHhqH
6OvvqcUvAt1ITRnEkNa1AihlF3aVmtaYGAqyRtrjW0RomQfEYezstpQIKrdRWevK
dLUucaeP3F6SlYzjK5iyo160E0hVBK1TKsApr2pxdWltRqL3uyBYcgQsrMyeqyEN
dLS7+ikhjHVCbN8GV30kO9f104HBn4J8s6lx2z/ptTE6xSrg6esQr+YnkcXw16JJ
1dF+pGS3SVG0wxDH8DOU6IkKFZ65jrGZsq2+ofDJOLhUkzFEKh+Tm3Mz8Pm0stoy
FC4samMxBd6xKLu8w+DJVPOLp3V/sj0Y9LrN6InqexljQYtI0TWuHz48IH5uPlL/
Po9u98oeyVkpm4aIcKIa
=JJ5i
-----END PGP SIGNATURE-----

--C7wSVvjdhopu+7bZ--
