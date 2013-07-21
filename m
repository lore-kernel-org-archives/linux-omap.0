From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Support SND_SOC_DAIFMT_CBM_CFS for
 omap3/4
Date: Mon, 22 Jul 2013 00:58:06 +0100
Message-ID: <20130721235806.GG9858@sirena.org.uk>
References: <20130721162400.GA17491@panicking>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/zLL6W406Aotuby1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:37359 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab3GUX6L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Jul 2013 19:58:11 -0400
Content-Disposition: inline
In-Reply-To: <20130721162400.GA17491@panicking>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--/zLL6W406Aotuby1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 21, 2013 at 06:24:01PM +0200, Michael Trimarchi wrote:
> Add SND_SOC_DAIFMT_CBM_CFS support for omap3/omap4. The patch was tested on
> a pandaboard-es board connected to the pcm1792a codec. mcbspx_fsx must
> configured as output and mcbspx_clkx must be configured as input.

Applied, thanks.

--/zLL6W406Aotuby1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7HWLAAoJELSic+t+oim9LDwP/AmyV2334ewOCP13QqWyJTGN
CEVzqp8Z+nj9xcvWAjRZ7BVAtXB3CEzl0OmAgHKEQwvMdDgTU7xDuWgbBZAfvgs4
1Rl0/gBy/BllTHUIwqr9vLu/EhKQb6MKELsomhY4dU6jMiRQVbf2RcTtnK+bny4A
hENLNN1mjiwneifTf//AbDhpa3PtaBXg6bvF76IeqJ9+YlndCTBK4uOKVIqCIkjb
UUlpK6TfC4A7mjElghD/I5LNKCR64qOn9Vu9Hl2lpdOjHbLip9sbxNWT9fbjhO7h
MPUsxU2YsTbQ+Ss+fGhYOl2sVJDxnWRh2Aq5Mg5HPRghA6inPQWuw3weVXICjU6Q
cG8a9bT2mnq8VKh2HMofTLC5ee2NiEsUXmklrVNCbMQm+dPI6uVEhHgyyP/YZ+Eu
szkyW/WDbyylfGp2VnrlHdh+xbt1sl0Ll9nywZHp6xLosx8aOmzUPCVOf3J789Lb
rHjaDKfXiU3uprVsQ/C3hIH9j1TwUC4xvaQ1RkomVZclYGengL8h0OqxEaDe6nsH
EI8vMWHqGEswEh78eGyYzjCuOX5f3UH0fsLiKOGwqruKvLevN+gQ2rfuV8+iYRRZ
4IZ2fWC2SykfjhRZgc4sWCA2AlKHuqjoCbxp24q5tTMEKTqKM5+asQj7CVHi5Ygx
QDycFNb8DYH7H/5Eaun1
=yd0A
-----END PGP SIGNATURE-----

--/zLL6W406Aotuby1--
