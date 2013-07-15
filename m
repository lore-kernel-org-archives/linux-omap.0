From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: Enable COMPILE_TEST build for
	DT platforms
Date: Mon, 15 Jul 2013 18:03:07 +0100
Message-ID: <20130715170307.GV11538@sirena.org.uk>
References: <1373903876-26370-1-git-send-email-broonie@kernel.org>
 <51E426C2.5060209@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3316865185229061215=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <51E426C2.5060209@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============3316865185229061215==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SidV/bKy1CyabPX8"
Content-Disposition: inline


--SidV/bKy1CyabPX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2013 at 06:43:46PM +0200, Peter Ujfalusi wrote:
> On 07/15/2013 05:57 PM, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > The DT platforms don't have any source dependency on any OMAP stuff so
> > allow them to be built when COMPILE_TEST is enabled.

> The OMAP3 generic machine driver could be also included in this patch:
> SND_OMAP_SOC_OMAP_TWL4030

There's no need for that - it has no dependencies other than the TWL4030
core driver and SND_OMAP_SOC so as soon as SND_OMAP_SOC can be enabled
it is too.

--SidV/bKy1CyabPX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5CtIAAoJELSic+t+oim9vskQAJ0sZYIJdIWaWAWYDUPPoSFL
Qgxrue8lLc/VAdxnsiSAZev7jkgV7nGjmAzZ6Ly+7oeDmJHCdK4IimdLftZkeGV5
z9gbyvBEeeut+pqufVFD+z/ipK/m1RSvLwhctg5hyzsP25W2GsR923Pfqw/6i/Vd
BLz5HacdyDWhyPQU78O9lkEEIC9jwUPiaweY4W8KU0+80qQtTzEOKaQkAA7jdLoA
OUMcnR3vtYMmDBaBPsWnsF89WbbFMC6lD+5LvtaY8oSGfBR9D1B29ByWd9bcQSBA
6YoX9vs69Bwlwv9km7GlkSgbusBhgJ25SImcibfH2L+6s9FUp+cGLmgGmcLz2l9H
e/1OiK1gWhA8T4hGm8STa9qBK2wEp/wtg8GtZU+C5Pa8Q/A7XrPilWT9QwJ4jgTW
MhsHx2/56LUNfQdcLTEAX6krBwkaRnP/DWVC/zeHGSLcOT09JsSvQso2/gs8qM/8
bFp1zr2Glw5rAYlLoaKhyNXmDG4cE5p8l5IZB/QVlPnjEQk40chw5FlZ4Ejr6T6w
S9qGTl3Qj88uzGGyyGL0ncJlhAr2l7g2JFVGL2OqekKE3cNzhCUHUhdHPo/CraXy
fFiFf8Nreem3ih0cBL9QkVOPZco2kq7KBHVHI5urwalpYjrp87qHQHLaZThlEQt/
otz38gV4sQ1mTjv2uINI
=ojXs
-----END PGP SIGNATURE-----

--SidV/bKy1CyabPX8--

--===============3316865185229061215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3316865185229061215==--
