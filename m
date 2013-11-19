From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 5/9] ASoC: hdmi-codec: Add SNDRV_PCM_FMTBIT_32_LE
 playback format
Date: Tue, 19 Nov 2013 18:21:00 +0000
Message-ID: <20131119182100.GD2674@sirena.org.uk>
References: <cover.1384862950.git.jsarha@ti.com>
 <ccbca51db46f6f38e3a1233cbdc058dbe0906bfe.1384862950.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qKojvbh47KHQqxue"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59170 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab3KSSVD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 13:21:03 -0500
Content-Disposition: inline
In-Reply-To: <ccbca51db46f6f38e3a1233cbdc058dbe0906bfe.1384862950.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, detheridge@ti.com


--qKojvbh47KHQqxue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 02:12:25PM +0200, Jyri Sarha wrote:
> The new playback format is needed for tda998x HDMI audio support. At
> the moment the only other user of this codec is omap-hdmi-audio. This
> change should not break anything because omap-hdmi-audio-dai, the
> cpu-dai of omap-hdmi-audio, enforces sufficient constraints to
> available sample formats.

Applied, thanks.

--qKojvbh47KHQqxue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi6wJAAoJELSic+t+oim9qwIP/2VOpI4qsPBSwy3F31bCSP9c
qfwZz3kl4OuYEnAh622kfkxODq0BcQ8DlkXeB8/7KzusUXgd8MJFkKCP7Dtyn1z9
An/40pck/2fL7D0ROugaNEkpdskdGm049nJsKJ5ziFZZlKVU7uXy8kpzcXK6HVIg
yYcR8FSxXmovwKy4uxTcavuSuim73WLbDblOUoYNO0SJTcIdr5vOp0tCOdLwpSQp
xCLHZb5+iy8HGHW4WUI659ahVAwcQbvDfWsmjRNUUfp5nhMFec+9q8E6ktMoMC6c
K2cnsfVe86PdB2J0Cs000wvZ4oM3hsMuTp8Fj3+drSU6XmL/hS3vjipClr7ajChX
pmulhql1uAj/BaiwqgrKvkbGUnO4lO2UypziH9pEn+lID164x+7enk2iWIKdMD3F
wp50P4KRdR7xCv/eqa+8dVOENrH5z8lfZfDGEq+Y2V0v6pgEmYrs7GBnRjMn5Zyz
Epu2aDTgoY51awGCyEcRegYZ7u3CxjVhlMNjPH0S4zPsru1INiAiz8tXir/bkIu0
uQO9mwRmiltcM46LCJGO/1nQ7b5ehRGZx3Lc5UH2xxIws26xcAYWg5+kveDvrlt6
fx2hmnrt+IQ5woBXkf/uUDg37y/f1SlFlgqGpb/3xXN5t6Fpz2oX7g3CcVuxgsOf
N7ONYA0LoKW2YOeDjhVc
=/v3V
-----END PGP SIGNATURE-----

--qKojvbh47KHQqxue--
