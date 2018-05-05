From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/7] ASoC: omap: Deprecate omap-pcm for
	sdma-pcm
Date: Sat, 5 May 2018 10:38:33 +0900
Message-ID: <20180505013833.GL13402@sirena.org.uk>
References: <20180430111958.31289-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4222430745853049318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430111958.31289-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org


--===============4222430745853049318==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 02:19:51PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v2:
> - Return -ENODEV from sdma_pcm_platform_register() in case !CONFIG_SND_SD=
MA_SOC

This doesn't seem to apply against current code, please check and
resend.

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrtCxgACgkQJNaLcl1U
h9B9DAf6A7kDHBQVuObvtKUCK1lynrQAueqQ5wVFfplRtch9h0CkQ+XtoxrcI0sC
NzUyCW7O/2TM+DVn59ezzMfwxo+6WtkWCMJU4jWqwBmmInu7t4Qja4MDe1Gzh800
dQhxK8FNf4NKqIFaXd+Mbt92TTJ3ALY2T/RP+HTMLWJd7E6Vnge6apZHVg/ehdMU
CKLw6LPVJTD4CwioQuWzBy8Mqpw/35hMB9GqRHias0F9KYriigq3CKSl2x5owb3C
oy9ZYlbintFKR2TUZmJ+4hGXJ2r5YlkdotPaiaJpK5xqoTr5uSJy4tX3geAGkRY3
DFYXEhaqrxOiV/MhN7V/WcNAUHkGbg==
=Rs6O
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--

--===============4222430745853049318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4222430745853049318==--
