From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Tue, 31 Dec 2013 13:25:55 +0000
Message-ID: <20131231132555.GA31886@sirena.org.uk>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2906953305683386696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============2906953305683386696==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X71G3O74nGQzyUqw"
Content-Disposition: inline


--X71G3O74nGQzyUqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 12:39:38PM +0200, Jyri Sarha wrote:

> Add machine driver support for BeagleBone-Black and other boards with
> tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
> port in I2S mode. The 44100 Hz sample-rate and it's multiples can not
> be supported on Beaglebone-Black because of limited clock-rate

Can the drivers infer this from the clocks?

> support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
> The 8 least significant bits are ignored.

Where does this constraint come from?

> +	struct snd_soc_card_drvdata_davinci *drvdata =
> +		(struct snd_soc_card_drvdata_davinci *)
> +		snd_soc_card_get_drvdata(soc_card);

Again with the casting.

> +	runtime->hw.rate_min = drvdata->rate_constraint->list[0];
> +	runtime->hw.rate_max = drvdata->rate_constraint->list[
> +		drvdata->rate_constraint->count - 1];
> +	runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
> +
> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +				   drvdata->rate_constraint);
> +	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
> +				     2, 2);

Why not just set all this statically when registering the DAI?

> +static unsigned int evm_get_bclk(struct snd_pcm_hw_params *params)
> +{
> +	int sample_size = snd_pcm_format_width(params_format(params));
> +	int rate = params_rate(params);
> +	int channels = params_channels(params);
> +
> +	return sample_size * channels * rate;
> +}

snd_soc_params_to_frame_size().

> +static int evm_tda998x_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_card *soc_card = codec->card;
> +	struct platform_device *pdev = to_platform_device(soc_card->dev);
> +	unsigned int bclk_freq = evm_get_bclk(params);
> +	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
> +			   snd_soc_card_get_drvdata(soc_card))->sysclk;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, 1, sysclk / bclk_freq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "can't set CPU DAI clock divider %d\n",
> +			ret);
> +		return ret;
> +	}

This looks like something the DAI driver ought to be able to work out
for itself based on the clock rate and sample format.

> +static unsigned int tda998x_hdmi_rates[] = {
> +	32000,
> +	44100,
> +	48000,
> +	88200,
> +	96000,
> +};

The changelog said that 44.1kHz and its multiples couldn't be supported
- is that just the multiples?

> +static struct snd_pcm_hw_constraint_list *evm_tda998x_rate_constraint(
> +	struct snd_soc_card *soc_card)
> +{
> +	struct platform_device *pdev = to_platform_device(soc_card->dev);
> +	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
> +			   snd_soc_card_get_drvdata(soc_card))->sysclk;
> +	struct snd_pcm_hw_constraint_list *ret;
> +	unsigned int *rates;
> +	int i = 0, j = 0;
> +
> +	ret = devm_kzalloc(soc_card->dev, sizeof(*ret) +
> +			   sizeof(tda998x_hdmi_rates), GFP_KERNEL);
> +	if (!ret) {
> +		dev_err(&pdev->dev, "Unable to allocate rate constraint!\n");

OOM is already very verbose, don't bother.

> +		return NULL;
> +	}
> +
> +	rates = (unsigned int *)&ret[1];
> +	ret->list = rates;
> +	ret->mask = 0;
> +	for (; i < ARRAY_SIZE(tda998x_hdmi_rates); i++) {

This is all very hard to read.  Why has the assignment of i been moved
up to the declaration rather than put here as is idiomatic, what's all
the casting going on with ret and in general?

--X71G3O74nGQzyUqw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwsXgAAoJELSic+t+oim925MP/ix5sXWajo3Zu+eKPM7COKbA
ENizE560HlSTfNUma2qBxLfrntmzdVfb24VGqV9ETiy0cYKhVm1tvjW4UyT8V3Ts
uJOVaItmzMf8j3PNoOzveMSZY2WQHPWa2/cCY2Fjh5N/SSsQiHhkz/uera2dpaUH
EPKKAcjgYLHXDhRHaBhhoTcs4GzwaiWgYq90lbhYXw7SLx0Cq6YLiDwYBXG6shWn
qk04y8s1wf4nUJHWaHvzcicXsYSdbbArajUm9PzGq0ls8BSYriY5oDjb7IugdIdo
dHA9+70IitMsjSJPX8yui34JSdDXYaFqKW74puQKr+Nl+mjb0D3WLh108tLKUcGm
azrBWwPG7CuYr0QBX05PWBbMqwMukBVmnoNMp1N2pTHRsI7SzoUlIGei0H4dmC42
7NhuqKLJ2KZAPwEbnc0+yas4WgRPx6qIGEUJ6QcR8s97hn0LPgt/PFdWsczVYwz8
t9B1I5fSP9UG1JWu2+t/o3NQklOJu2kkAw33Xm6GRrZF7FHfM/2X4GjGtP96jmB8
O/vNsQWsEyj8SXv71Mo9TQ6wsczV1CIwz5lQdKMfLla8k2n3sc/RzUB4tBU/zqD8
/LkqDRLGE0Pjt7M3jb75TD/INAMrTyjL0i+VNgEQ3R1jrB2dhfFJ4/SpUqbqGl0h
SmEXduwPL3acKOxhmUym
=Sh9z
-----END PGP SIGNATURE-----

--X71G3O74nGQzyUqw--

--===============2906953305683386696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2906953305683386696==--
