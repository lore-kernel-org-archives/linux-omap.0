From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND PATCH v3 5/5] ARM: OMAP4+: HDMI: Refine the DMA port
 resource for audio
Date: Mon, 14 Jan 2013 08:20:04 +0900
Message-ID: <20130113232003.GL5041@opensource.wolfsonmicro.com>
References: <1357341987-3327-1-git-send-email-rneri@dextratech.com>
 <1357341987-3327-6-git-send-email-rneri@dextratech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UUBKWyapWpFAak7q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58074 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756147Ab3AMXUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 13 Jan 2013 18:20:10 -0500
Content-Disposition: inline
In-Reply-To: <1357341987-3327-6-git-send-email-rneri@dextratech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <rneri@dextratech.com>
Cc: tomi.valkeinen@ti.com, lrg@ti.com, tony@atomide.com, peter.ujfalusi@ti.com, dzuniga@dextratech.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--UUBKWyapWpFAak7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2013 at 05:26:27PM -0600, Ricardo Neri wrote:
> Instead of passing the complete address space to the platform device for audio,
> just pass the address offset of the DMA port for audio samples. Thus, we prevent
> that two drivers try to ioremap the same resources. This is to be safe, as the
> ASoC HDMI CPU-DAI driver will not need to ioremap such resource.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--UUBKWyapWpFAak7q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ80EdAAoJELSic+t+oim9vAAP/3Mldwe5FEs2IkJx4jc1d96o
yTvP8GEajkbBu/rXUR8BeA3wTeMTsFJLEPWh2HoDmBalBO9GjwcItEJHqVyxKuye
AMwZ6IOeCHSXzlyjAjxekiM9h6QcjRVQUhlX+OxBDJROHlk5Xz1bMpP7Q8d4/6VP
80bv+tY+wZ0o3XlezYrKaQvXkidmA6tAh+prAg32vcOXh7atbMqEpLxxgYwqWyej
BLY6ebtTjN3cIWolkcOgj8q2IfpCFKNJTCOvvgDFUGYMNIvVuNzh42f/RTw6bGO7
cuRXDP/Ki7GmU3alc5ptfS4aoXtj4/litvrFM2TfKB5wrAhNnsHiN+zoxxexrhfc
+MHv2PFAiSvKMNcWfu0UW3zz0fXi+lFByMxx8pPQjMaezvYnFYkIN6YIxmcPm2H5
QFGhWUtIaF1TAD//e8Ht0U9NW2Mmm0jsmFFrVDIbIcOTDCmLfZfo/qSUy1ho677i
NbU1R0ddyYMVVGpdBJ1+VDF7LGiNZV6EGT3mrj9LbI+8AY4zaHjUIXHiSNtzMrHd
y39Ap6lGbed88+SDvSlfW4vprnKQ8yW0PtI0wDS8ZJlIguDdb8RFF2yTPs6a9V1p
Mur/o4cI63kIqqNLf2Y1koeEE7wH7T1qtecNFiOCuJtus6p0bPNMGe3mKS0Sab3J
4SS4snZ0OkzCInFtfznu
=Rwdi
-----END PGP SIGNATURE-----

--UUBKWyapWpFAak7q--
