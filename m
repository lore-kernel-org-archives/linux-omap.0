From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040
 dependency
Date: Fri, 6 Mar 2015 19:50:33 +0000
Message-ID: <20150306195032.GV21293@sirena.org.uk>
References: <22890811.0MuvZ4MxOU@wuerfel>
 <54EDEAE3.6080605@ti.com>
 <2707228.SKhEXovzW4@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXmg4rwOCWWn8Dzk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54453 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375AbbCFTux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 14:50:53 -0500
Content-Disposition: inline
In-Reply-To: <2707228.SKhEXovzW4@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, lgirdwood@gmail.com


--BXmg4rwOCWWn8Dzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 04:42:12PM +0100, Arnd Bergmann wrote:
> The change to enable OMAP5 support on this platform was a little too
> eager in adding a 'select' for a particular clock driver that might
> not be enabled in all configurations, which in turn leads to a build
> error:

Applied, thanks.

--BXmg4rwOCWWn8Dzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gUIAAoJECTWi3JdVIfQLrIH/j8mnSi3/hSr+Wl5eWxi63sL
42670ux2XjrflPA4RO5YNV2ls4apm14MBe4ziSHcDqupKqLHPY8TjtLvY2oVMtz2
N70+JPr7IUu5OityLfCyfOTcePTEZe4213eflRsj0BC6oXmWjWl1P9ijYLRok4Mn
vwOWCOWb5mUZasi16/mPZaSVo6Kl0o8QmVaOjXwxUbxsTHLqM4RTibC1H7q+8dqI
R91h/W6v+b0nYQbZPq8T+Y7pNFz0hBd6p4aK/6bFRr3A9fcudYt/z560LGE2SNtQ
dW9WiaxJfpwdw2tbslbM/V8iLlXoeVLMxtk3jRYv5+7P6jneVv0t6caceMHNtvw=
=o6Zn
-----END PGP SIGNATURE-----

--BXmg4rwOCWWn8Dzk--
