From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 4/9] ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR
 signal muxing
Date: Wed, 22 Aug 2012 20:13:35 +0100
Message-ID: <20120822191335.GK7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B5QUy/LYob3AO56P"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36713 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757835Ab2HVTNh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 15:13:37 -0400
Content-Disposition: inline
In-Reply-To: <1345124468-8876-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>


--B5QUy/LYob3AO56P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 16, 2012 at 04:41:03PM +0300, Peter Ujfalusi wrote:
> The muxing is done at board level, no need to do it in the ASoC machine
> driver.

Applied, thanks.

--B5QUy/LYob3AO56P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS8UAAoJEFJkBDiqVpZ4bnYP/3cQQDd979/6Nre3M6UJG4Uu
qgrZJXdOIovlFcHfhH5TeyESZCW7iaV46bvb42tbkB1KuiZJnfDaEihbAczINimT
5q6sfQ1Dy/TURkoFMuBx7riTRLhhR5KLzT6vRqsGqeMpf0D+Ev7EptG+SycUhaiT
qP2YVywoouOT5wK3DaiConJdZftkhaW1hbfEpweCmXY9S1IvSQ8lnQJ35yNtkPvB
BhCsUnUqpqr1OP8K9dKRxUA8p5yr/A72UHtMNzy+VT26iv0LaTJ43fllrYqlVvxb
p1ggC8bAYp0HXSkwhoyUBXPGMKK6Bdbagbf4wR4upeF9hqORfZPyPv9t9EjR7tRs
7EXVEU3AlOkiHwfW5LX3IBQS3a+GvpDmOOHcp4S7CM38zWFIs/IJc2LPRevG3+TR
67TYqFCG5f/PrlrwlX27ppGiAR3YSamYqDQdfl5fCVEbBDwFFgqLEc+uggxx/otN
UktxqY5T6VQEAZcxlHDywv0EQem3Ucb4Ny7FRx2pvzfdrwTjxjX9rnYkl/wYf3JS
H+MTcU40RdvP7z9JlKaI4moIWkojJP7/1z+udNSA2G5jY9HaIv3RV58gCsfUBwu0
xWSS9Y5MZ23teXZAamc0l+AldNWjDvq8Zi1yDj64RCF8K+leY1yQ/yhfQLltjmLm
nS01v5GkMBs+DqNnUSao
=ONxj
-----END PGP SIGNATURE-----

--B5QUy/LYob3AO56P--
