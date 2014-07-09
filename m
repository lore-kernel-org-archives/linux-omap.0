From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: omap-dmic: Use devm_snd_soc_register_component
Date: Wed, 9 Jul 2014 10:16:20 +0200
Message-ID: <20140709081620.GI30458@sirena.org.uk>
References: <1404838397-5309-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TALVG7vV++YnpwZG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54406 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaGIISS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 04:18:18 -0400
Content-Disposition: inline
In-Reply-To: <1404838397-5309-1-git-send-email-badarkhe.manish@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com


--TALVG7vV++YnpwZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 10:23:17PM +0530, Manish Badarkhe wrote:
> Replaced snd_soc_register_component with its devres equivalent,
> devm_snd_soc_register_component.

Applied, thanks.

--TALVG7vV++YnpwZG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvPpRAAoJELSic+t+oim98qQP/0aI8pxG1vq+Zeo3L8udkL3b
mw8M4L1akE6ViQ1nZQsqBhvKxKriRQ4dYrYU0SxeRNmR7wDVX8UqOdDjDghyv2uI
Xm0UkxN3ZE/sJVEH6ReTngghjnmXUwHs8Ol9SeSulTjDoIDJzAY3EkWqLRy1UPlK
qUACUjVZQbCozHAEcf0uDjeb5UPNHf7fV7yrOfM0pjvpBEeIV4kpguq7dg/Zqn1K
+O1A1mjvX7dawXELrn53RzAM1czlNbXxRBMnPj6ECxH6YXguOPt9ppU5GD8bRJz9
XWKQ7O9OtO3usO7dq2DI3kWQgn9reLVDGauK/9K5C5K+9Itla0U+5E24HoFzHt4k
h5tlxRnBhPn4olQg0o5ZJyNOAWnxXClwtVLf+wQK0e4dF6vH8MBB/Ql8pnckiufg
xdFiR0dogWk7obXECA1dG7KGC3SMKsu/EWTv7NFPhUV7bTB8nNBX7mzr4Dz7ota0
swEDpwgJTSsho2B0rZAyexK9PaZxGSe6Q71++a5syXRPlVxbys/li3qFIGnCfY9K
JXUOYOkhV7wLKwvIJznyLpPkcJzuKVvTbaqAE1zkmn2rzlUhxreBA4842qZSKpsr
LgKIX9s05nstnZig1KH8+s++7lmi2tgp3n45MMjvD8YxgNpBwToaXZjhbO2ycSEa
CfnQVm7ujlUnIu1sR6Y0
=smAc
-----END PGP SIGNATURE-----

--TALVG7vV++YnpwZG--
