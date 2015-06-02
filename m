From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 2/7] ASoC: hdmi: Remove obsolete dummy HDMI codec
Date: Tue, 2 Jun 2015 21:10:13 +0100
Message-ID: <20150602201013.GR14071@sirena.org.uk>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
 <1432666751-24794-3-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rpOPesfUXqAMaEty"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39711 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbFBUKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 16:10:24 -0400
Content-Disposition: inline
In-Reply-To: <1432666751-24794-3-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, moinejf@free.fr, rmk+kernel@arm.linux.org.uk


--rpOPesfUXqAMaEty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 09:59:06PM +0300, Jyri Sarha wrote:

> -#ifdef CONFIG_OF
> -static const struct of_device_id hdmi_audio_codec_ids[] = {
> -	{ .compatible = "linux,hdmi-audio", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, hdmi_audio_codec_ids);
> -#endif

There is actually a binding document, you should remove that too.

--rpOPesfUXqAMaEty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbg2kAAoJECTWi3JdVIfQ+sUH/R+4QXH+jN5ReZZzGFI5CDab
KLDx4tqeIgx3oB+JuVE4G33aojgdhvsaboWcG7p22jwV6Xb+Dsp31cLSooj2K1BM
hx+1QzNXJu5JpguHnPVNy3JsLKHEU15zSD6lmiPqpmuRz5GpIXIQJevvpANB5wUD
Liw1vk4msE/cUTpczWHdpoyE/SsLD6UcJ4vJXEXGYxpAml6oqkW5nCJV9YD9amMp
6eHVSG7NsLks9ngZ2w4xLmBYQECXrCPwh6SXk56VmaPoGTe7Bp4eRd0/30HGX2KR
f6TOLZRkhNSVkKUzDHif27R9ifGPCtjBTgK4o3y3jypCMDvGQ0x2Ba9EK/vekFw=
=UOUC
-----END PGP SIGNATURE-----

--rpOPesfUXqAMaEty--
