From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to
 generic DMA DT binding
Date: Mon, 11 Mar 2013 16:28:14 +0000
Message-ID: <20130311162814.GD10617@opensource.wolfsonmicro.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
 <20130311143303.GC10617@opensource.wolfsonmicro.com>
 <20130311162700.GI26093@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43846 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116Ab3CKQ2Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 12:28:16 -0400
Content-Disposition: inline
In-Reply-To: <20130311162700.GI26093@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2013 at 09:27:00AM -0700, Tony Lindgren wrote:

> I suggest you take the driver changes and Benoit takes the .dts
> changes as those should be queued separately to avoid unnecessary
> merge conflicts with the .dts files.

Won't that cause a bisect issue if the driver starts looking for generic
DT stuff that's not in the DTS files?

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRPgYVAAoJELSic+t+oim9RNYP/Rl+phLBq4dM9V/MVnPHtomR
mbs7moM9zzUyDJ1h6clb2uJ/O9wZUChRY1ieIWR04St4tPrXgmMhg7kI56P7kN/g
p84QMSb6W3uxCTaAh/XmTPF+Yw7kUtX/opK9l0kDi9K56jDDXKIi6vs+7iat8WGg
QpYlYWNbQU+ercPpDCIofJ5IiyQsfJ+nmgUTSZ4IRHwGE6kZio/d6Dzupwq/Pdz3
+giAiGznjwZxhSmddUZIb71bivuqhMCV/gZlBxrSTu+KRTlFL9oSgrCv8kcxo4pR
6WwlTWyESmJOGFc0iAry0nMHYKJWb7XwcCBki2eW44YEj2ahZ20FvdUn+xrHVVqG
NIQV6yYz44E0TX5MdOqwFHZB+NpjZboqyJ4/a9wic4ete1CAnqz1w9G4bs/YbUOk
lXNcR0RQMlQr80Ope+lKAgsmvvRzd0MqvLYm1HbHFjDkxVrw1GIyGhraCrGluDxk
L3bJIthijO3CqoUyr0cdB9lVOsJGcuRvpN5Ej7l8vvGXm8P5DGs8fBN4B6KI8ZHR
EM+Z1OwfIwtfnuqsJ4Cayr9xnZeY/Pb+7NT1JT7Jh7AVrfg1buZSAU+3muTXb7KY
jjAHTH458dHtKQaa4eUIfugc36F5mHQhpP9uGDT9qFUW5m/j1zNd8TZzeAUEOTMC
+uCixdI6tXdQvNyOmema
=sVtn
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
