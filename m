From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: codec: cpcap: new codec
Date: Mon, 10 Jul 2017 18:51:52 +0100
Message-ID: <20170710175152.2jglyjezvptamreq@sirena.org.uk>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3197932348674268682=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170707164229.5868-2-sebastian.reichel@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============3197932348674268682==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rz5z5zl44dvdwzhq"
Content-Disposition: inline


--rz5z5zl44dvdwzhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2017 at 06:42:27PM +0200, Sebastian Reichel wrote:

>  snd-soc-cq93vc-objs := cq93vc.o
> +snd-soc-cpcap-objs := cpcap.o

Please keep Kconfig and Makefile lexically sorted.

> +static int cpcap_audio_write(struct cpcap_audio *cpcap,
> +			     u16 reg, u16 mask, u16 val)
> +{
> +	struct snd_soc_codec *codec = cpcap->codec;
> +	struct device *dev = codec->dev;
> +	int err;
> +
> +	err = regmap_update_bits(cpcap->regmap, reg, mask, val);
> +	if (err)
> +		dev_err(dev, "write failed: reg=%04x mask=%04x val=%04x err=%d",
> +			reg, mask, val, err);
> +
> +	return err;
> +}

If we're going to have wrappers for the regmap functions it'd be good if
they were named in a similar way to the functions that they wrap, just
for clarity.  They're also not used consistently (and TBH I'm not sure
what they buy but if you want them that's fine).

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		err += regmap_write(cpcap->regmap, CPCAP_REG_TEST,
> +				    STM_STDAC_EN_TEST_PRE);
> +		err += regmap_write(cpcap->regmap, CPCAP_REG_ST_TEST1,
> +				    STM_STDAC_EN_ST_TEST1_PRE);
> +		return err;

This'll return a nonsense error code if both error out, better to do
something like

	if (!err)
		err = regmap_write(...

> +static const char * const cpcap_onoff_texts[] = {
> +	"Off", "On"
> +};
> +static const SOC_ENUM_SINGLE_DECL(cpcap_ext_cap_l_enum,
> +	CPCAP_REG_TXI, CPCAP_BIT_RX_L_ENCODE, cpcap_onoff_texts);
> +static const SOC_ENUM_SINGLE_DECL(cpcap_ext_cap_r_enum,
> +	CPCAP_REG_TXI, CPCAP_BIT_RX_R_ENCODE, cpcap_onoff_texts);
> +static const struct snd_kcontrol_new cpcap_extr_cap_control =
> +	SOC_DAPM_ENUM("Ext Right Capture", cpcap_ext_cap_r_enum);
> +static const struct snd_kcontrol_new cpcap_extl_cap_control =
> +	SOC_DAPM_ENUM("Ext Left Capture", cpcap_ext_cap_l_enum);

Why are these enums and not simple Switch controls?  They appear to be
muxes with only one arm connected.

> +static int cpcap_hifi_set_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cpcap_audio *cpcap = snd_soc_codec_get_drvdata(codec);
> +	static const u16 reg = CPCAP_REG_RXSDOA;
> +	static const u16 mask = BIT(CPCAP_BIT_ST_DAC_SW);
> +	u16 val = mute ? 0 : BIT(CPCAP_BIT_ST_DAC_SW);

Please write a normal if statement, this was a bit confusing at first
glance.

> +#ifdef CONFIG_OF
> +static const struct of_device_id cpcap_audio_of_match[] = {
> +	{ .compatible = "motorola,cpcap-audio-codec", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cpcap_audio_of_match);
> +#endif

If this is part of a MFD shouldn't the parent device register it without
it needing to be in the DT?

--rz5z5zl44dvdwzhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlljvrcACgkQJNaLcl1U
h9DmLAf9EMDF438Xa0KV9bpNKE2g41Lb+gF4vs0t4Z7qPVn+nyCQ/qoKshO45shQ
rKQi/3iP2m46e/ULkDELCbzcRX/B3Rpp8dAWjnWAUHl95gphx59Ob+B01bn+vZwL
zLDveJxMxm5qCWnhBM+eLvu3nGAJo8lEochPfoQ6A+eWCrXXhATG2mdWsiNkdz2Y
RcM3I11Riw1TCnJmD8SVsXfy2Rl29JYman01RHWPbTw2C6hGx6B5ii68il8qt0c6
sa/YTH++x8ewH/FF4krKQLh4UsYqAK8MOvTg3zqdRn+oNAyrJqy1E4NJxbVnxICQ
nGOG6O4N49HnTvLdn8MxMNLNgsMtwA==
=XhV9
-----END PGP SIGNATURE-----

--rz5z5zl44dvdwzhq--

--===============3197932348674268682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3197932348674268682==--
