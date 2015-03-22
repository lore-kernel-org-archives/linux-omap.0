From: Mark Brown <broonie@kernel.org>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Sun, 22 Mar 2015 17:48:03 +0000
Message-ID: <20150322174803.GL6643@sirena.org.uk>
References: <1426741659.10003.9.camel@midgaarde>
 <550AC783.8040304@ti.com>
 <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
 <550AF442.5040203@ti.com>
 <1426787288.13824.36.camel@symus-gk-mint>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52282 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbCWE7v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 00:59:51 -0400
Content-Disposition: inline
In-Reply-To: <1426787288.13824.36.camel@symus-gk-mint>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Knight <g.knight@symetrica.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 01:48:08PM -0400, Greg Knight wrote:

> Is there a straightforward way we could enable the clock on-demand -
> when we're communicating with the codec/mixer or actually using the
> audio subsystem - while keeping it disabled when not in use? We don't
> expect to be using the audio subsystem frequently.

This is what the clock API is there for - the driver can enable the
clock whenver it needs it and disable it when it doesn't.

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwBOAAoJECTWi3JdVIfQzvsH/RClqJ2hO7/Tnt1cRQhMfCcY
2BzTc6NAGKHpG4FUFoZBq4uzxG5S+gWslqDZDpdIjjqZ9OyBcQdjKYXweeBdbJZ9
9C+eLJh6rh8oTkVAxoa77zOzJjZSuun1l7SMqZ0FtYMK5Tu4csJWEpJ/mq5PCcbf
vbGIgLIWP451gdmEeSTKtSgPSQcH0GBO16Ecg/epYt9ldeGvCsuaEoP8R7EtWgFP
e4AbYh/mVQGpJPaDRPiy7NwsTI8U6+1lkpoTxOlNNu9+C+e0tS46PXcdT61shp5r
WASx/Qx5NQj8ZUMbBoprBq8jhnR+ih1Dzov6jHIwxXznFuW5BcXDOGkzNqEQBZc=
=VzPW
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--
