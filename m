From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7.1 09/19] ASoC: omap-hdmi-audio: Add platform device
 for OMAP HDMI audio support
Date: Mon, 1 Dec 2014 19:21:52 +0000
Message-ID: <20141201192152.GK7712@sirena.org.uk>
References: <cover.1415803064.git.jsarha@ti.com>
 <9a528990bbe116d9bb073f690b835c847b3fa0bf.1415803065.git.jsarha@ti.com>
 <20141129113230.GC7712@sirena.org.uk>
 <547C1598.1000509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="66JA64BHvaVFYarG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45328 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbaLATV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2014 14:21:59 -0500
Content-Disposition: inline
In-Reply-To: <547C1598.1000509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com


--66JA64BHvaVFYarG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 01, 2014 at 09:15:36AM +0200, Jyri Sarha wrote:

> The only reason is that I have not encountered any other audio capable HDMI
> device falling in this category (cpu-dai integrated within HDMI device
> block). Without at least two devices utilizing this code it remains
> questionable whether the code is really generic. At least the dss_version
> should be replaced with some explicit data to fill struct
> snd_soc_dai_driver. Also struct omap_dss_audio is coming directly from omap
> dss code, its contents is generic but I am not sure if the information
> within struct snd_aes_iec958 and struct snd_cea_861_aud_if is enough to
> configure the HDMI IP in all possible cases.

It should be no big deal to add extra information if required.  Given
how poor the upstreaming state is for HDMI I expect we'd get people
coming out of the woodwork if there were infrastructure, some of the
Exynos stuff looked similar to your situation for example.

> I can work on making this API look more generic, but before there is another
> candidate to use this API it is questionable if the code will ever be used
> by any other device.

Unless there is something obviously terrible about the hardware design
that I'm missing which means nobody else would ever have implemented
something like it I'd expect there will be at least one other system
that can make use of the code.

--66JA64BHvaVFYarG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfL/QAAoJECTWi3JdVIfQvpsIAIAVOmnFJVHllx/jP1YZDmNd
0tY0PUpiCl9a7N5nTkegNtWDJA1IT+qMEcPavj8o/w5Uzto/ZvWHDMfTqsNr0ps5
mSyyxvDw4aSZYZhNSlNXP3/9Ml3UR58r30GYmUUEekAbqu+alpguIJAR/Fb1G6Fy
JvF5tZCv4G1b7o3JrRePyiq/zfCSUaYdNxfkOEhGCW/4WWq+81cpazx2eYQtky4+
6Tc5OkX9yi2LiQ7+Kl6CVDbvp0xVsyVb2dvdKzKEYWUSK9wcKzkFZP6vzbui1WmF
FcQ5owT1/Bd4cokGPE5+AetnfxL/y3CS9dn/MDib4QLK1iBMXGblL8A9hPsTLXg=
=xl8q
-----END PGP SIGNATURE-----

--66JA64BHvaVFYarG--
