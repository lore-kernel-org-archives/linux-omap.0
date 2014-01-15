From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI
 audio support for TDA998x trough McASP I2S bus
Date: Wed, 15 Jan 2014 13:27:21 +0200
Message-ID: <52D67099.1040904@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
 <20131231132555.GA31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20131231132555.GA31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/31/2013 03:25 PM, Mark Brown wrote:
> On Fri, Dec 20, 2013 at 12:39:38PM +0200, Jyri Sarha wrote:
>
>> Add machine driver support for BeagleBone-Black and other boards with
>> tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
>> port in I2S mode. The 44100 Hz sample-rate and it's multiples can not
>> be supported on Beaglebone-Black because of limited clock-rate
>
> Can the drivers infer this from the clocks?

It does. The commit message is referring to a BBB HW specific feature. 
Guess I should remove that note from the commit message, since it does 
not concern the code itself.

>
>> support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
>> The 8 least significant bits are ignored.
>
> Where does this constraint come from?
>

 From driver/gpu/drm/i2c/tda998x_drv.c. The driver configures CTS_N 
register statically to a value that works only with 4 byte samples. 
According to my tests it is possible to support 3 and 2 byte samples too 
by changing the CTS_N register value, but I am not sure if the 
configuration can be changed on the fly. My data sheet of the nxp chip 
is very vague about the register definitions, but I suppose the register 
configures some clock divider on the chip. HDMI supports only upto 24bit 
audio and the data sheet states that any extraneous least significant 
bits are ignored.

>> +	struct snd_soc_card_drvdata_davinci *drvdata =
>> +		(struct snd_soc_card_drvdata_davinci *)
>> +		snd_soc_card_get_drvdata(soc_card);
>
> Again with the casting.
>

I'll fix that.

>> +	runtime->hw.rate_min = drvdata->rate_constraint->list[0];
>> +	runtime->hw.rate_max = drvdata->rate_constraint->list[
>> +		drvdata->rate_constraint->count - 1];
>> +	runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
>> +
>> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
>> +				   drvdata->rate_constraint);
>> +	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
>> +				     2, 2);
>
> Why not just set all this statically when registering the DAI?

Because there is no relevant DAI to where to put these limitations. I 
did not want to add yet another dummy codec driver, but decided to use 
the already existing ASoC HDMI codec. By default the driver support all 
audio params supported by HDMI. The limitations are coming from NXP 
chip, the NXP driver, and because the chip is used in i2s mode. In other 
words the limitation is coming from machine setup, not from the DAIs.

>
>> +static unsigned int evm_get_bclk(struct snd_pcm_hw_params *params)
>> +{
>> +	int sample_size = snd_pcm_format_width(params_format(params));
>> +	int rate = params_rate(params);
>> +	int channels = params_channels(params);
>> +
>> +	return sample_size * channels * rate;
>> +}
>
> snd_soc_params_to_frame_size().
>

Rather snd_soc_params_to_bclk(), but thanks. I'll use that.

>> +static int evm_tda998x_hw_params(struct snd_pcm_substream *substream,
>> +				 struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +	struct snd_soc_codec *codec = rtd->codec;
>> +	struct snd_soc_card *soc_card = codec->card;
>> +	struct platform_device *pdev = to_platform_device(soc_card->dev);
>> +	unsigned int bclk_freq = evm_get_bclk(params);
>> +	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
>> +			   snd_soc_card_get_drvdata(soc_card))->sysclk;
>> +	int ret;
>> +
>> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, 1, sysclk / bclk_freq);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "can't set CPU DAI clock divider %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>
> This looks like something the DAI driver ought to be able to work out
> for itself based on the clock rate and sample format.
>

I guess that could be done.

Peter, what do you say if I set BCLK divider automatically if mcasp 
set_sysclk() has been called with SND_SOC_CLOCK_IN?

>> +static unsigned int tda998x_hdmi_rates[] = {
>> +	32000,
>> +	44100,
>> +	48000,
>> +	88200,
>> +	96000,
>> +};
>
> The changelog said that 44.1kHz and its multiples couldn't be supported
> - is that just the multiples?
>

As I mentioned earlier, that is a BBB HW limitation only, the code 
bellow is able to decide what rates are available based on the sysclk rate.

>> +static struct snd_pcm_hw_constraint_list *evm_tda998x_rate_constraint(
>> +	struct snd_soc_card *soc_card)
>> +{
>> +	struct platform_device *pdev = to_platform_device(soc_card->dev);
>> +	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
>> +			   snd_soc_card_get_drvdata(soc_card))->sysclk;
>> +	struct snd_pcm_hw_constraint_list *ret;
>> +	unsigned int *rates;
>> +	int i = 0, j = 0;
>> +
>> +	ret = devm_kzalloc(soc_card->dev, sizeof(*ret) +
>> +			   sizeof(tda998x_hdmi_rates), GFP_KERNEL);
>> +	if (!ret) {
>> +		dev_err(&pdev->dev, "Unable to allocate rate constraint!\n");
>
> OOM is already very verbose, don't bother.
>

Ok, I'll remove that.

>> +		return NULL;
>> +	}
>> +
>> +	rates = (unsigned int *)&ret[1];
>> +	ret->list = rates;
>> +	ret->mask = 0;
>> +	for (; i < ARRAY_SIZE(tda998x_hdmi_rates); i++) {
>
> This is all very hard to read.  Why has the assignment of i been moved
> up to the declaration rather than put here as is idiomatic, what's all
> the casting going on with ret and in general?
>

No excuse for i initialization, I'll fix that. The casting is just to 
survive with just one kmalloc call instead of separate memory blobs for
struct snd_pcm_hw_constraint_list and referred list of supported sample 
rates. I'll allocate a second blob, if that is easier to read.

Best regards,
Jyri
