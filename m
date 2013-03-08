From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5] ASoC: OMAP2+: Update Audio IP with sDMA binding for
 DT boot
Date: Sat, 9 Mar 2013 01:24:41 +0800
Message-ID: <20130308172439.GE26088@opensource.wolfsonmicro.com>
References: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
 <51389023.2000907@ti.com>
 <20130308092543.c355b2c6235c297efbe162e0@bitmer.com>
 <5139AE1D.3080102@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45088 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933174Ab3CHRYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 12:24:48 -0500
Content-Disposition: inline
In-Reply-To: <5139AE1D.3080102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sebastien Guiriec <s-guiriec@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2013 at 10:23:41AM +0100, Peter Ujfalusi wrote:

> If we have them as separate we will have runtime regression between the
> patches. It is better to have them squashed together.

Other than the issues mentioned this looks OK to me.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROh7OAAoJELSic+t+oim9PvIP/jGgkQ0iIjnLH70X1AMESqsP
ezM4N1Aj37X+lXWvzDJWcVwR6SI1rohxGM9YlOHmDTNS/T5RiXF2GGhvpju9pQX3
X61xOKHz3+3Frs2n+DDkYcMRooqjdQLCm8B5n8Ygzx1aZ/K11VFj2Cv0r+sWIMWo
0+Bd5z0hYZGVDmIO2/gXqO61+6zBNiGWzcxyBTDijOr66KBcSaYNVrIKtYbgyVAp
0QJzmM4RLFgXPSMZilppUKFthIKZAfALDUl7jAPbMuJpbgQj+slZsCzN8DF7b6Y5
hchDdRHoeZsNE5+ppQ3x872KHYCxYf7lZd19E2BAJXbTo+LUGKBtqBpdXuxtSiL7
w66WkCcjbUUJdMs3BJpQQjXeL1ThpOEWyBPsr3kJFaNeI/8FXdEOGdL8HMm810EK
rEtsu0sPE5LyebFz6+KJ45H6+GkwQpwPIwHma0oUM/oT4455Gt8WDxrL8yNJvlKE
T5vcTDHWRq5cjEFT1xEf94JMLkUOYUtIpYWcxAUxRbdmkDz3lW9YjUtss49y6S9Z
u8Q+dPeE7sTEXrZhpl/ErX6BfHJNTE+9T8dQYN9y7gN0QhOJ5zbV74R88Hdy/wpr
3d1PtAP74xuPHyZKyjRbYOoqamCyAyHxlmcrYfdPm3OFfqvlpN2I/pl2whYsC7Wg
YNBcyWNENynF3IgA+02E
=pqYa
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
