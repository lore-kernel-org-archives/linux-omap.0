From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: Add HA (HEAD acoustics) DSP
 codec driver template
Date: Tue, 29 Apr 2014 11:47:19 -0700
Message-ID: <20140429184719.GI15125@sirena.org.uk>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
 <1398687476-10829-2-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1544463380640099491=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1398687476-10829-2-git-send-email-sr@denx.de>
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


--===============1544463380640099491==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 02:17:53PM +0200, Stefan Roese wrote:

> +static int ha_dsp_hw_params(struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *params,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +
> +	dev_dbg(codec->dev, "Sample format 0x%X\n", params_format(params));
> +	dev_dbg(codec->dev, "Channels %d\n", params_channels(params));
> +	dev_dbg(codec->dev, "Rate %d\n", params_rate(params));
> +
> +	return 0;
> +}

This doesn't do anything, you should either implement active code here
or remove it (I note that a range of sample rates are supported and the
CODEC can be clock master so I'd expect to see code here).

> +	/* codec role */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		dev_dbg(codec->dev, "Codec is master\n");
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		dev_dbg(codec->dev, "Codec is slave\n");
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This isn't doing anything with what it parsed, how does that work?

> +/*
> + * This name/ID is neded to match the DT node for the codec
> + */
> +static const struct i2c_device_id ha_dsp_i2c_id[] = {
> +	{ "ha-dsp-audio", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ha_dsp_i2c_id);

This doesn't have any actual part numbers?

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX/OzAAoJELSic+t+oim9EbwP/1gDhBxhHgTq0hbXULpgd7f7
BYUItWzuewUumEez7PiUCu51R2/1nyx0trSDeA2hCromURFerdZE+c2lErgTiojv
3AIKq/5xgeeX5ga43aMWJhhMYSWU5RQvi/xJWA5C7lIPNUUzdKti+WwtxRocQg5X
1eAR6tbVg/YatMQBZzbplsOD1xbl2eghlcbZ5FHP8IoggR6pm9lr6rFmfZRb2rW5
MP7z0Mb1WP2uN31gIY/5txlA1E0iRU9nrU0FOi0EIhkT1WBd6bqe/DlRZpNc+nAV
VtQT41MNfl5q0OmGZQHVB+PQyxoJbSEMsHAxxkmIZ66H2Bkj/C3I1Lbb23VfYB/n
zKSvuO7sQlZ1WS6u6fRACXRiM7BI746e2+pQY0kiIQwPAlmVIGfoJTgE82RS9MGd
XO2rjuRjvVT0SuFHRIJz4mTV1Ns09psEy4KPcqwJe4YBXhTsh1hcnjU920KM70Ar
LA0UG4WMOWJ9Oz46UYRG8qMEXW06cuxwCqOQ7eCiGbAtYaHZQgBE8u0GrNDNqnlu
OVw0zgBTMZ3scD9xLuby32SHOQD+nbzkWxX574UfROIJx7Sbub5rB6GYSCGBo6Lp
Ijn/nyx6UqWucDbU80C7XpgBP+DydeYHHH/04xrLrZrw7DhRfqTOXZ9Vc/lgnuLv
8/iV1VDG51VfyjfS3pXH
=6Lvj
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--

--===============1544463380640099491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1544463380640099491==--
