From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/14] Rework OMAP4+ HDMI audio support
Date: Wed, 13 Aug 2014 18:26:32 +0100
Message-ID: <20140813172632.GE17528@sirena.org.uk>
References: <cover.1407503813.git.jsarha@ti.com>
 <20140813110425.GL17528@sirena.org.uk>
 <53EB5F6A.9060308@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsIYMYvOvXaGWzg6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33691 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbaHMR0s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2014 13:26:48 -0400
Content-Disposition: inline
In-Reply-To: <53EB5F6A.9060308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com


--KsIYMYvOvXaGWzg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 13, 2014 at 03:51:54PM +0300, Jyri Sarha wrote:

> I guess then the least bad alternative would be cutting the cpu-dai driver
> away from drivers/video/fbdev/omap2/dss/hdmi_audio.c and placing it under
> sound/soc/omap and registering it from hdmi_audio.c the same way as
> hdmi-audio-codec and asoc-simple-card is now registered.

> There would be two devices for a single ip, but at least the ASoC side
> driver would receive its resources directly from the HDMI video driver with
> necessary tools to synchronize the access.

Just a MFD really.

> This approach would work for other HDMI audio situation too, where there
> would usually (for tda998x and SiI9022 at least) be a need to register an
> i2s codec driver associated with the HDMI encoder. It would probably be
> possible to make a single codec driver to work with multiple HDMI encoders
> if the API between the codec and endcoder drivers is designed that in mind.

> How does this sound?

This sounds like a way forward, I definitely think it's a good idea to
standardise the interfaces as much as we can.

--KsIYMYvOvXaGWzg6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT65/FAAoJELSic+t+oim9+8gP/Antp/nkv1/bPsS9DXA2tgHM
pcZqD6ZwciTZEgoy26rw6DQC99hE/qL1nQr6i41DHL56LRv78/pmx5DTzDrl3uGA
BSFSGniJQ2SjjdZWHTN1b0HKecH9LUWpM1OCwm4HJWczR5tgNZzyFf1qzmzqNx/u
QJ8pauFCbm5YSbY05DKTZ3cycrVvYViQisRoHcNAct7ckJnGS2pyoHuOVSLqz8o0
e08CtKlte3mYQCPChbiv3g/CBDEKG4Og8gFP308xD33SHMUZ9Hv6UJnvoYR3w4kd
t7avmNfA1mpa8SrN8lypmDfytzX0le2xdahEAgAvarHEzxGihlMvJFhYtyUgJiSR
nnO6V/GpTLU0/sUJxWUjTZpUA+guRFnEtxKlmbOjG8ncYzGFp9XtWWRlp0t5UujR
DoEFMb4J/5kDpEdP7n17IX/ng0UvnjlmeOe0dGy3g4+MoFl7ltARHy/M+RiPhmkr
6dOBawKsfUJDftAvQS134/6qtpRWdTyNx2OsRHUqfwTHfRd4N8g1xIF8nNPZVG2k
gSt1mVL2GKq1AqRY9mGXPsHXK58vBBpJQ3mCFyirBOTnFwOEsQiLwrc7QmHnKjN4
w5d3jI0otMpBj9H6V/5QyYFAbHUMWtuo0NKHScpDVfG5yn2JwyTlo8l4hkCiVR4e
Nth2Xzcn6Kzm7444hyrJ
=8jcY
-----END PGP SIGNATURE-----

--KsIYMYvOvXaGWzg6--
