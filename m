From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Sun, 22 Mar 2015 17:58:51 +0000
Message-ID: <20150322175851.GM6643@sirena.org.uk>
References: <1426741659.10003.9.camel@midgaarde>
 <550AC783.8040304@ti.com>
 <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
 <550AF442.5040203@ti.com>
 <550B1017.2000405@mail.bg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DXTueXWT3Da08pik"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52473 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbCWFD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 01:03:27 -0400
Content-Disposition: inline
In-Reply-To: <550B1017.2000405@mail.bg>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nikolay Dimitrov <picmaster@mail.bg>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Greg Knight <g.knight@symetrica.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--DXTueXWT3Da08pik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 08:06:15PM +0200, Nikolay Dimitrov wrote:

> Correct. And this is a big issue. As far as I know, the kernel drivers
> control separately the clock domains, and separately i2c devices, so
> the basic expectation on the kernel side is that there's no connection
> between these 2. In this specific case, because of the SGTL5000's

Not really - it's simply that it's the responsibility of the driver for
the device with the dependency to ensure that the dependency is
satisfied.  There are no general rules about what the requirements of
devices are.

> 2. Add "hacks" in the DAPM widgets that add control to the codec's
> reference clocks. While this seems the preferred route to many, the
> general feeling is that such approach is not very welcome in upstream.

There is no need for any hacks, we already know when register accesses
are happening so we can easily add clock enables there (by moving the
code from the MMIO layer to the generic layer, this is the first device
with this unusual requirement).

> 3. Add explicit support in the kernel's audio subsystem for
> dependencies between i2c devices and clocks, maybe via "DAPM clock
> widget" or something like this. Provided that the DAPM graphs are
> defined properly, this will work out-of-the-box for all use cases,
> without the hacks (until we see even more twisted cases).

There's nothing audio specific about the idea of a device needing a
clock for register access, doing something at the audio level is the
wrong abstraction layer.

--DXTueXWT3Da08pik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwLaAAoJECTWi3JdVIfQY30H/AiOfXLfjqHlIONLcx6Ealdq
GjI1ziCWrSchVpe4aSDPEknKaZpHBxOXd4+eqFcjGRba8q6gzWn8oEVcrw/f/LPS
0lqL2uzHcMSRy2mHvjAADIki9PzaxnA/RuUtnV0yhyDywR0tpium/azc1PeNribg
HmQYZK4RrMLkv6pl7Dr8H+w4FDEDIbX+ZtHhWi6tzDjxf9tsHnZlsVsl6EX+abJ3
bm2Krqw9Xewy26LMkf40mgCYaNvNqFEwtbmjEi0TDBwmR1twxsrFxYNj7/bR8NWh
/fs+OaU+Pw4Y+oBM7pGBrwYcmC4SepAgI6jD/7I4rCRe9AEiw7wsJ7hJEOtm5C4=
=TGyB
-----END PGP SIGNATURE-----

--DXTueXWT3Da08pik--
