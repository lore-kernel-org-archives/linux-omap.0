From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/7] ASoC: omap: Deprecate omap-pcm for
	sdma-pcm
Date: Wed, 9 May 2018 17:26:40 +0900
Message-ID: <20180509082640.GR13402@sirena.org.uk>
References: <20180507085000.6414-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2539268126088145937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180507085000.6414-1-peter.ujfalusi@ti.com>
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


--===============2539268126088145937==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Ocr+Jy+jPJR1APa"
Content-Disposition: inline


--/Ocr+Jy+jPJR1APa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 11:49:53AM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> Changes since v3:
> - Rebased to make sure it applies cleanly (I had one local Kconfig patch)

What have you rebased against?  It's still not applying patch 2 cleanly
(indeed due to a change in snd/soc/davinci/Kconfig which my git doesn't
have any SHA1s for, plus some conflicts in davinci-mcasp.c).

--/Ocr+Jy+jPJR1APa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrysL8ACgkQJNaLcl1U
h9A47gf9ED4W1X1TcBQIgv83cxjaH8wk4FBVY3gzSlcaOEbkDgFTolh6oCnpG7UW
mHeIXEZn7OhjMN81V6CNUQAUt50FVAK0fkPivxflbpEPASc7Q+XbBAUlo8FS/RIc
VlizaRePUwotSs8y8lLzBYF+MIQsU9r+CwY6Ukplx1+TRjhgUo14KGicATSenHt7
Zn2Olg1nMESUIllaX3lWf79y04K/CaVONpiou56SjfzZlquKUXIu46vFosnKvQUV
0M+16TE9Nm3aIZ9mLmHUldy0qhs7H0C0o3KtakztMFFHDbI6T/y+V5JOT5F+Ivxa
QObfBUvkwb1nESADzaFwd2ENWrcRig==
=JbQ1
-----END PGP SIGNATURE-----

--/Ocr+Jy+jPJR1APa--

--===============2539268126088145937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2539268126088145937==--
