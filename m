From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 08/10] ASoC: omap-mcbsp: Cleanup of module
 probe/remove code
Date: Wed, 29 Feb 2012 23:33:05 +0000
Message-ID: <20120229233305.GH8295@opensource.wolfsonmicro.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
 <1330414820-4641-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36148 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757073Ab2B2XdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 18:33:10 -0500
Content-Disposition: inline
In-Reply-To: <1330414820-4641-9-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2012 at 09:40:18AM +0200, Peter Ujfalusi wrote:
> Use devm_* where it is possible to save on cleanup path.
> Start merging the two mcbsp file content.
> Move pm_runtime_enable/disable calls to ASoC probe, remove from module
> probe/remove time.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though I don't see any reason not to enable pm_runtime in the device
model probe, that way I'd expect you can save a little power on unused
McBSP ports.

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPTrWgAAoJEBus8iNuMP3dny4P/0HussPWKLa/lbk39W0FIoVa
nNQqzU+HX3hE4ljnyhY3noAxzLl3oTONzTfd91QCukAFnOwf0LNJJvKKL+Do1eiH
5Eep0rXvQ++DAWXH7yzIc75FQAKUjs4t0d9Xkip0q2GYOeDSb61HrBIZmvFgONi5
n+aJMDKDdTrbIlbSt9QbplpO3kR927+FhlgnGRIc1qJpPVQYmp79Sc/mlUSGs3Z+
eY0saHHWvh2z9eUnd9xWTgEKpCOBLF8ksEtDpv3sgEuaz79XWWRxztI4hGCbiAbI
9Mn9T19DWABoCqveo7Ny8Wak+FGg3b2Vp+qIGxLk4p3tTLX9aE+umauXRXcPn+Nr
8wB3fHvQQLtwGrM3rp3qz18NymvQS66IlagYfNwakXMIZha1a+QsV1C6/KPWqsNY
m1G48am1exYE2GjkCmNjTwDT8iBFRrJRX4WUjLH0Oota8HQ+S8CwLSrRcoM7hTZf
B3XUnBtcs3Dk48mg/JMLkJ2+Aj8I3KHQCDc9VxASssc+iyHjXP7wFVJoihVg3433
yVZA4EomHYQIEAjgoeEcIo1vauyOz7Mdbo+Xu0gzO3mp2zY5AT60mJsv/dHVZH0d
wsfQspm0eP5rlcRSf2oZKXSNS5t32dVIxgBmey79BGpxNFORicky5kAS4P21LQnl
lJlykRazd0E+ZVfTyTHz
=pGgX
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
