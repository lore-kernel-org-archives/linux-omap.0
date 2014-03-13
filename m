From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove snd_soc_codec_set_cache_io()
 call
Date: Thu, 13 Mar 2014 17:32:17 +0000
Message-ID: <20140313173217.GC366@sirena.org.uk>
References: <1394727755-7091-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FMJTF8LVhUQkvsEb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55904 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbaCMRcZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 13:32:25 -0400
Content-Disposition: inline
In-Reply-To: <1394727755-7091-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lgirdwood@gmail.com, lars@metafoo.de, tiwai@suse.de


--FMJTF8LVhUQkvsEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 06:22:35PM +0200, Jyri Sarha wrote:
> Remove snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP) call
> and codec->control_data = aic31xx->regmap assignment since that
> already done by core.

Applied, thanks.

--FMJTF8LVhUQkvsEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIeueAAoJELSic+t+oim9NiMP/3Fgn69aaxX5XB9w5hmym9vx
PVlv/WGV46MYzjTIlwxCJesj5zxiffiyqyacmIileOFavgaf+Z/WVXM9W4PBO6Xl
AnLQJt9StzNtO0uOGvKkvRQb2XvNNH3nEUQHsNMMiSt1cxBNaVQxHriQEJMqQj6Q
t1HGMFlGxj/0VeDhKrq5ulu42Ofak+p5rqpaUJ2of0GAnM5WnA3mlqkRMwdDdyLT
zgv2o4UMTES91vPlvjex5iuGv5FFYhhQCo+LwUdyqEJ97BpTG5S4lg/Q4TqmAFlw
CpHU1oefn4Kb9X+Z5ockThfHxcoDE0eOrr4QoltLkRGGveLYws877E7Ty2g1EldV
b8pX8BOhp5non9/StNb4EYp1n4qLVkUawGRaMVCjB1CoO1LT4vG91sYwhzBJlCEF
kIN734vH90cbtVPQOZx1HvN3pUwP+DJKA355clcLt+9rPahUXy4WH5DFoEcv8OUe
5c/3ywxH4XQCPLmv87l/qT33mX9P5KhHXMoVywnFWmEbO3xFNDN4SudHvueZ/XVS
EXSqfV0TSEwVVW/9o/ERb8SwPBUXvf1dlQ3xGqFDsKPMwFAl+j+ahHqVebuQ71Lf
i9Re20do8X+sQraYNAQ+95ueKX5rMeihcsOxhgNz1F1TcytjeY36ZkKT1GVtLJPl
sMzK5IRUPR7tNRF16EuR
=eerK
-----END PGP SIGNATURE-----

--FMJTF8LVhUQkvsEb--
