From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 4/9] ASoC: hdmi-codec: Add devicetree binding with
 documentation
Date: Wed, 20 Nov 2013 13:33:15 +0000
Message-ID: <20131120133315.GC2674@sirena.org.uk>
References: <cover.1384862950.git.jsarha@ti.com>
 <829968f1a6b34176de8a04dd4ad473b2b37be783.1384862950.git.jsarha@ti.com>
 <20131120102342.7befe75e@armhf>
 <20131120100959.GV2674@sirena.org.uk>
 <20131120133458.3822a165@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3m6ZAtymzEdXvUYk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60975 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3KTNdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 08:33:38 -0500
Content-Disposition: inline
In-Reply-To: <20131120133458.3822a165@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Jyri Sarha <jsarha@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com


--3m6ZAtymzEdXvUYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 01:34:58PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > We still want to be able to have users just name the CODEC on their
> > board rather than have to type in all the details from the datasheet,
> > if we're going to try to amalgamate the drivers it should still let
> > people do that.

> OK. But it seems to me that the codec is not tied to the board, but
> rather to the audio connector / transmitter.

No, not at all.  The majority of these devices are simple CODECs, DACs
and ADCs with no register control which are soldered down onto the
board.  What's connected beyond them is irrelevant.  If anything the
devices that don't have fixed functions are even more likely to want or
need to have specific code, for example code could be written to enforce
the results of HDMI capability discovery.

> In the case of the tda998x HDMI transmitter, either i2s or s/pdif may
> be used, thanks to the actual codecs 'hdmi' and 'spdif tx'. But they
> don't work the same way: the 'hdmi' codec handles both playback and
> record, and recording is disabled by program in the sound device,
> while the 'spdif tx' codec is selected by the codec-dai-name
> ("dit-hifi" - it is "dir-hifi" for recording). It would be nice if
> these codecs would have the same behaviour...

Well, send patches refactoring one or the other then...

--3m6ZAtymzEdXvUYk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjLoYAAoJELSic+t+oim9MhQQAJksxLsGaBzuaAxsEch0RJpH
8LMx93Zpcm8GExDX4Xj2//Ju+HuqfVlf19PHgPDTdvN+2VVeQlcHeEVPW6ubCvfV
v0yez9rN20RBzw4On43G8NC6CHq8HfEthGlFPlkpKItWoujVhAk3dMGHLMkCffAA
rjcKQQUevYmdUbEIOEI70VvaBnXSHz2qNP+481TA1qFnukdeFOtCtet84lShmhG0
8uzcEzD1JtAiAzX1UiLs5GcSHa3EcSPwF7HLaCaM8dxlWwca7naUa2S362eIn/NU
5Gy7BjxSRg4MU2QNMoJSQse5P1AgBzMOLJoC2/eV2SYDpkZKPy0WJzot6i/d9uZV
AQJJ+Qzf++oP+C7ZHIH+1MqygN7Mxg7us4uHXGfoiBONf0gTulIIzbPJ/zQOmvt1
mx43F/RGLyJuadR1GuyjMCEY6n97KbcJJA0xhGgKN9zb6DiZjt+vidF6rSdnG14f
wYs4ih0fTD9Sv1zYauLDCzGZ8iXigG0N1M8MIe7cM2pTGIQzfJGgyqx2i1H5FgZw
MvL/pG/HAPlqAAWPVdMMdz25p54KtsxKxzB6cxhwOXLhWE6BbFBaKZ/Kz6mpvODn
wd+UlmZUGNn+mylxNHvXNJ9a0RkPNUwiklF6LT1h1kwLY79trx+vfGoqpmsNWGlb
VzWGcq1Ij0PXDXNabbIw
=9bGT
-----END PGP SIGNATURE-----

--3m6ZAtymzEdXvUYk--
