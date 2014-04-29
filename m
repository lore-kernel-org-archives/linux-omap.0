From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: omap: Add HA (HEAD acoustics)
 DSP add-on card audio driver for TAO3530
Date: Tue, 29 Apr 2014 11:54:59 -0700
Message-ID: <20140429185459.GJ15125@sirena.org.uk>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
 <1398687476-10829-3-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8221375467051488417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1398687476-10829-3-git-send-email-sr@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Roese <sr@denx.de>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============8221375467051488417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Content-Disposition: inline


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 02:17:54PM +0200, Stefan Roese wrote:

> +	switch (params_channels(params)) {
> +	case 2:
> +	case 4:
> +	case 8:
> +	case 16:
> +		fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Why is this "conditional" on the number of channels (though the same
value is always chosen)?

> +		/*
> +		 * Calculate McBSP SRG divisor in McBSP master mode
> +		 */
> +		div = 96000000 / params_rate(params) / params_channels(params);
> +		switch (params_format(params)) {
> +		case SNDRV_PCM_FORMAT_S16_LE:
> +			div /= 16;
> +			break;
> +		case SNDRV_PCM_FORMAT_S24_LE:
> +		case SNDRV_PCM_FORMAT_S32_LE:
> +			div /= 32;
> +			break;
> +		};

params_width().

> +		ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, div);
> +		if (ret < 0) {
> +			pr_err("can't set SRG clock divider\n");
> +			return ret;
> +		}

Why not put this code into the DAI driver for the SoC - what's board
specific about the calcuation?  I'd expect this to be handlable by
set_sysclk().

> +	if (!node) {
> +		dev_err(&pdev->dev, "No DT node provided\n");
> +		return -ENODEV;
> +	}

You've got something with a DT binding here but no binding document,
documentation is mandatory for new DT bindings.

> +	priv->slave = of_property_read_bool(node, "ha_dsp_codec_slave");
> +	if (priv->slave)
> +		dev_info(&pdev->dev, "Using slave mode for testing!\n");

This seems like something that shouldn't be in production code, or
perhaps a build time option if the testing is valuable?

> +	if (snd_soc_of_parse_card_name(card, "ti,model")) {
> +		dev_err(&pdev->dev, "Card name is not provided\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}

Why not have a default?

> +	ret = snd_soc_register_card(card);
> +	if (ret) {
> +		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
> +			ret);
> +		goto err;
> +	}

devm_snd_soc_register_card().

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX/WAAAoJELSic+t+oim99Y4P/0LQc5m+eDU2uS2f8Hxiu2a0
MSvNBQVyUyc3AZFVheu+6Dp1bokNeY5l8WyiVxi5wf+LcliCEO7Cou/K9EGqQO0c
LXsbXhAwt/QMfpQXo0PYqeQw0Xp/YlVtfuQSQDgkdvsFmBsZohe57KDqYt4GBREj
JEQ4Lb0KhUGCz+1bULEInEgp9afEy4V34dw0e9zIT08u2hDfCOsY2g5ddtlIyhwd
B+JlMzuPsVgWxiK2Ku+xW6tSvCmhCz4qBIjy4qPN4QZEUsnSOHFUhVivjFfdleyG
aso3ckH9Aipabw16VQkMO10X1y4sySKM2rJ049+Sul4UtCx88ux8ovsmq9wQeuso
qEbwyWCicEHpuwofhwVB9pCLN86ypJyiVEsaijDnsxQVuCtzwm/Tom8lMwPuj0Jp
bb0fobh7e6RMAaxllpeON/8OTru0/bBCwx3foKP6Mdqf6mmU5uqnOW1ZZ0SFXZdH
fv5vs13ous4gmvEjuEDvyvV7+HujYN6bH/ZGCeTEnCm38HUhUX5cfYxpVcpbQsvu
OPKTFMbcHS8BAPcSIzCrrq+bYl35uI2KNlAc9OW+9ucMoQw01ScvmtW8qpY71gN2
biuvke5dma4sLLXO5zhQaTMBsb47ewmZBMa1U/s6anXcvAjqi6OZoOdPB5mtHEj9
Tr6krdPy4hK8JhsNAPvV
=rCEU
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--

--===============8221375467051488417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8221375467051488417==--
