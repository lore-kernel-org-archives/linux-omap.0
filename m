From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: Add system-clock-id DT parameter
 to dai nodes
Date: Sat, 21 Jun 2014 11:09:59 +0100
Message-ID: <20140621100959.GC5099@sirena.org.uk>
References: <cover.1402653217.git.jsarha@ti.com>
 <c0281e720e9ef2056d3460047cf5bc5e75684abf.1402653217.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TqC3aXMUZwuFAd9J"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51715 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbaFUKKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jun 2014 06:10:13 -0400
Content-Disposition: inline
In-Reply-To: <c0281e720e9ef2056d3460047cf5bc5e75684abf.1402653217.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, detheridge@ti.com


--TqC3aXMUZwuFAd9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 01:04:38PM +0300, Jyri Sarha wrote:
> Select clk_id parameters for set_sysclk calls in the card init phase.

This is making the ID defined by the drivers into ABI.  It's not clear
that this is something we want to do, and we certainly don't want to do
it without updating the driver bindings.  In principle what we want to
do here is have our clocks handled by the clock API, though that's not
trivial work.

--TqC3aXMUZwuFAd9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpVn0AAoJELSic+t+oim9+EEP/25rR605born/jSmY+2qeYj8
cL5SnlKieAGOxngacwZDJwI2bIsh59FLHscwTlWUHgfiBcx/g9j2J5Gu6Z8SMA2g
0hA/Lb1rcrcKu01XEfXHd3nJ8cvLrgea2EbUdE5PrtYARjX/abKoZKyHkhg97uEA
FnroMsPKFXI/NSziSEdYl6CDvo7pSvjwhktO2UNvBGRR6xdY19ScA95biIXoQvMH
AQa9blxky7dqE88v1LO8TO52lHjvoM62dBmqrmzMnYeQeWxaadsoZ9pwToWcwa64
/bI3qSAW6TD501obJoZM1B2vSeXdgQ7KK8OoiiKerY8YcUvgAc36LMOZvibkeoct
frtP/F7bMMZd5Bhh0e8n+MGFxXVjstKd/KqLcGmFCcmg9Crr/J8/2Irz6hR4sv20
QVcREaggPjjUD+qPs4jSLe8mQNC6N3eUOcwTPGNty6t315etodw6nfrt8CkFYma5
ot4QYvX6UvrpFfCR8oAvOAgtZbyYPrbf1Gx81GfwUZMeDH182MRDvpv69bgTb84U
tAMp6OYWgmsCsZ8Rq9sjgHEu/aY/WMrnZjvoThjKRHW5xO51JwNpM8jakg06SAmh
gm4GyhuTORD6MOj9EOHHIiLNoSM61EdkSjyEaQyITnc0vomyHx3XZQK2MHAlMdOE
0ZSVYwvKs1fugnw8nAl9
=pgtC
-----END PGP SIGNATURE-----

--TqC3aXMUZwuFAd9J--
