From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: twl4030: Correct the support for Voice port
Date: Wed, 2 Jan 2013 13:04:52 +0000
Message-ID: <20130102130451.GB4627@opensource.wolfsonmicro.com>
References: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
 <1356951109-4286-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:41150 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627Ab3ABNEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jan 2013 08:04:55 -0500
Content-Disposition: inline
In-Reply-To: <1356951109-4286-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, NeilBrown <neilb@suse.de>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 31, 2012 at 11:51:42AM +0100, Peter Ujfalusi wrote:
> In order to be able to use the Voice port of twl4030 three bits need to be
> handled in VOICE_IF register:
> VIF_EN: to enable the voice port (needed for both playback and capture)
> VIF_DIN_EN: Need to be enabled for playback only (input to the codec)
> VIF_DOUT_EN: Need to be enabled for capture only (output from codec)

Applied all, thanks.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ5DBlAAoJELSic+t+oim9vTEP/Rm8pXQExp8yZGWNANtg84CZ
v738xn+pykwtaCD+bkxYqYtbP5sQBciBLPgUa5aU6xQXiLQ+2L9UJlAljR7BfBHt
Aj9AgLa/HR2ez0F+yMj6nFspU7MIuzatQHlE9W98GliY+akH/WyQ1QhMvGhql9N/
9wTpDUvFOt0xibJ5G29KqH/eeEVDqlgERBJTMmbt7n52gsEDBI5sHXB8tYfvoj1p
1PLUPO3XznKoqez4uCTKGoONAbP6mK1OaV/ysu9Rx1+jTRpxMqWR4ljo1FvfEDo9
Lgsr7h4235sttaUsmmcKBvr04rDE8ag4RnbES2L/ppoo6Um0ViotLAW+hc0yjtts
PVDrK9cuVr3bPYJvirUJwDwdf2MWvlSbgxRMrH2XSDT3VWOEIQfsXquGtLeSS6oi
HIyx8G93a61oTTnw6BygRlqVJUU/4fIJdisA4ZJlKadKAO7nk2I3DDSEGXsYWIQp
dHKorUdyFK//8BAXEFwkJhHQXdtisgZ0ZqDwjhBD1JNqSJLp6/tupH9wlPUZddTm
Q+k/XZ3zTc8efW3Hz8mmh/4j2lOq+Fy6DmM2FICspsewauAFMRHiqqzIQ+w+EWrZ
AXEMh/1YBV7lomW7C9w87C5tPWwnj+KnW0ion965FvohH/O7YtE4RA5BZits/yhb
slowedvu7/abnvrg16N9
=U65t
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
