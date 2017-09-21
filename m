From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: fsl-asoc-card: Handle return
 value of devm_kasprintf
Date: Thu, 21 Sep 2017 16:18:32 +0100
Message-ID: <20170921151832.6rs4gx6cft6tfdis@sirena.co.uk>
References: <d973fbc962f750ef87c0bccf7b2df6536c8e987f.1505971045.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6651052826436098005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d973fbc962f750ef87c0bccf7b2df6536c8e987f.1505971045.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, tiwai@suse.com, timur@tabi.org, nicoleotsuka@gmail.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org


--===============6651052826436098005==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cgn76rxy6rogobow"
Content-Disposition: inline


--cgn76rxy6rogobow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 21, 2017 at 10:50:03AM +0530, Arvind Yadav wrote:
> devm_kasprintf() can fail here and we must check its return value.

This is patch 2/3 but you've only sent me this one patch.  This is
missing the point of numbering a series, the only reason for the
numbering is to provide ordering within the series.  If you send a patch
separately or as part of a different series then the numbering should
change to reflect how things are being sent.

--cgn76rxy6rogobow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnD2EcACgkQJNaLcl1U
h9D2ewf+JiFmOniuOYGmxekij9kfGD32tPzXcQc/BDO6F9dK/1G02bmWVLlJjxwD
Gr5rRi8xFG4iXcE+usUyC6XzF9nMiDwRpgnJ97bLb0KgXtu4+0ae5fcsUipzfP5X
wxckZPZXa5ZC4MyzTVURO2TRlQkR00J6USHHHUPU8suZE3rIfrFyL71XSdxvcomk
dENs7o8H5Ovgw3AKulS8odT/fNs/9iTAOZCufnV3JLgMip8XsYfx9arxd3BWea0G
mV6nsZIgC5IAzyJf6tfxaNa9KIHyeKzQLKjpsyQ5wVaitwCOnxa7OEqAFWuB9Opv
pxxHgKnSXozSRv/4wULRU+KbcWlmGQ==
=XWBI
-----END PGP SIGNATURE-----

--cgn76rxy6rogobow--

--===============6651052826436098005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6651052826436098005==--
