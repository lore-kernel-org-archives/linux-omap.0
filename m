From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 02/12] ASoC: davinci-evm: Add device
	tree binding
Date: Tue, 22 Oct 2013 12:01:47 +0100
Message-ID: <20131022110147.GA9388@sirena.org.uk>
References: <cover.1382110089.git.jsarha@ti.com>
 <66c21e66320e30453e6deded0f37ef582b4fba7c.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2615543784846279692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <66c21e66320e30453e6deded0f37ef582b4fba7c.1382110089.git.jsarha@ti.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, joelf@ti.com, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============2615543784846279692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 06:37:41PM +0300, Jyri Sarha wrote:

> +  TLV320AIC3X pins:
> +
> +  * LLOUT
> +  * RLOUT
> +  * MONO_LOUT
> +  * HPLOUT
> +  * HPROUT
> +  * HPLCOM
> +  * HPRCOM
> +  * MIC3L
> +  * MIC3R
> +  * LINE1L
> +  * LINE2L
> +  * LINE1R
> +  * LINE2R

These should be documented in the CODEC binding and not in the card
driver, that way this doesn't need to be replicated in every machine and
any future software compatible devices can just work with the existing
binding.

> +	ret = snd_soc_register_card(&evm_soc_card);

This should be using devm_snd_soc_register_card().

> +	/*
> +	 * If dtb is there, the devices will be created dynamically.
> +	 * Only register platfrom driver structure.
> +	 */
> +	if (of_have_populated_dt())
> +		return platform_driver_register(&davinci_evm_driver);
> +

Why not register the driver unconditionally?

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZlsYAAoJELSic+t+oim9G+4P/iduB+vcrbdcgoUJbp0WfAFR
LhzacMejreGH+NWZOzaPUklY0eo+8eUNjPqDAsgWv5mbNb11RowdW/hU81PL7vfp
ThVLP3qXRtukgLJOk7vXqU9KleLkTS7HrP5qp7uSfJYZXd1i9uLwCy6Kmu4zNvk2
Rcw+7S7jLvcWW3FFN1LjfRVr1LNj+w+cU6+7sLRrwbshM+4+0g7AcCr2Ewc1lhso
CRv2XMxxJeXB/YNYQtkDi5y9TiMkq5tVvXc4Z0kWDkfkRp77u22fTJTw9dijJP+j
WSwk0kDBoHmdKJEg6yfjI6JnlWfa/IwBhh8nNuLEwiAmZRQ+NWbkTen4rAVaDf4R
IKY7SMTVgSO/20jWIA0iIDbjTTQIJSAJYGCMsaN11SgJ2JLeLIwGuRLCv4EN7Bf2
WfdS4sqQf3hDaIqJdMm1SmpY+lZ/eV8FIQpdSbjqfVqmyWl+qahBMVyN8DGtxTAS
YGwy4WjiMrxiP0mUFzlfvZaijD+OjgK7IlMWb20cfHdXb9qTu5H6Qz57/grrOAwY
uOUW7q6p0eSiZkhPZFBBDgqTXeFlPSJimacmwLAa6S1m2ml3Gpl8bnNmkrp5V4CW
7BtjSmhr4ldQQLuMg+XqU+qzeGecrVeoS8WdaytosrzTncTOHpn3ntFe3TXoAAsr
eXAGtPrWnXst4jhrVQ90
=sLK7
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--===============2615543784846279692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2615543784846279692==--
