From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: davinci-mcasp: Allow best effort
 in selecting BCLK divider
Date: Sat, 21 Jun 2014 11:04:52 +0100
Message-ID: <20140621100452.GA5099@sirena.org.uk>
References: <cover.1402652359.git.jsarha@ti.com>
 <6f645a7d31219c4410db31030a3ab07a4af6ae0e.1402652359.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2682762194445751245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <6f645a7d31219c4410db31030a3ab07a4af6ae0e.1402652359.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, detheridge@ti.com
List-Id: linux-omap@vger.kernel.org


--===============2682762194445751245==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WRrKW00JGQBXpjyg"
Content-Disposition: inline


--WRrKW00JGQBXpjyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 12:50:00PM +0300, Jyri Sarha wrote:
> Do not fail if the exact BLCK rate can not be produced, just print a
> warning. Check that sysclk frequency is set before implicitly setting
> the BCLK divider.

I've appled this but not as a fix - it's kind of on the edge if we
should be doing this at all, it's helpful for interoperability but
getting an inexact frequency obviously impacts the resulting audio.

--WRrKW00JGQBXpjyg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpVjAAAoJELSic+t+oim9ppUP/26zCW5fM2luP4Qzrk4OxJ5E
w+a1M19GzocCDpRNPgqDIpgSQkeNMZNAa5dMGR7x+41TNJ3Z9Ev1O3RSD1zPnGVP
2CeXh3HQZvcNYeB7hFEPwd+YCTBrvTB/1yFkvLgBL4odBTYfNctwL577xzZqRrjv
V5omX/Zl8k8y3p0kTeOzEvw/jUIGSGecABXoSqo24xNmueh5Hauy4FpGvQ6nvgvo
dG7YY+xJswwCtfJ2ZjO/xTF7XkBegwyTSpnEA1tnXLE0WCEsx/pQR1+t0sUDmYwx
pxBKAHWf1fx1hDCdvSp3yc56QjRX6fohY+mYF7nCJINmcseTmqB6BhO8jxdNtOX+
WAq3meAKYaX45rKl15RkShJ3Mprf1svbUIVRdJoSS3+0bG/UOSPv9qQ2FOMUkbUi
6K7aHBzond6W0wQaR8xNznEP8yaN7l3f8s8yWuySolC31mst/GZnzBuesj259+9j
mgTmsssSeBkyX5HUOTdsVlpzFHZDjpR6lvO1CdAYlNyRCtnaBcdeKhki+9Qvtxq7
KfJZmGl0DxrWeTZyy0OlVOyhmMKtpTR23yls96y2FH8Utmck1bgvMfEy5ZZhBjhS
b+oYR42xoQromHsFlzVlfpvPWWEYzbPnsDuAXOfTJ9deTYGXwrgc+Dsq/8DE01bb
1ZHm1fG1krA2eiOkV0Rz
=ZfPh
-----END PGP SIGNATURE-----

--WRrKW00JGQBXpjyg--

--===============2682762194445751245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2682762194445751245==--
