From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] SOUND: SOC: CODECS: Add support for
	the TWL4030 audio codec
Date: Tue, 2 Sep 2008 12:26:33 +0100
Message-ID: <20080902112633.GB25176@sirena.org.uk>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	<1220306279-27977-2-git-send-email-sakoman@gmail.com>
	<1220306279-27977-3-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1220306279-27977-3-git-send-email-sakoman@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sakoman@gmail.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 01, 2008 at 02:57:57PM -0700, sakoman@gmail.com wrote:

> Signed-off-by: Steve Sakoman <steve@sakoman.com>

Looks mostly good.  A few comments, though:

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -50,3 +50,8 @@ config SND_SOC_CS4270_VD33_ERRATA
>  config SND_SOC_TLV320AIC3X
>  	tristate
>  	depends on I2C
> +
> +config SND_SOC_TWL4030
> +	tristate
> +	depends on SND_SOC && I2C
> +

This should also be added to SND_SOC_ALL_CODECS to ensure testing
coverage.

> +static void twl4030_dump_registers(void)
> +{
> +	int i = 0;
> +	u8 data;
> +
> +	printk(KERN_INFO "TWL 4030 Register dump for Audio Module\n");
> +
> +	for (i = REG_CODEC_MODE; i <= REG_MISC_SET_2; i++) {
> +		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &data, i);
> +		printk(KERN_INFO "Register[0x%02x]=0x%02x\n", i, data);
> +	}
> +}

Perhaps I'm missing something but I can't seem to see where
twl4030_i2c_read_u8() is defined or any of the I2C device hookup for the
codec is done?

> +struct twl4030_priv {
> +	unsigned int dummy;
> +};

If this is empty it should be removable?

> +static int twl4030_set_bias_level(struct snd_soc_codec *codec,
> +				  enum snd_soc_bias_level level)
> +{
> +
> +	printk(KERN_INFO "TWL4030 Audio Codec set bias level\n");

This printk() should be removed - it's just debug output.

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		break;
> +	}

Should you be calling power_up() and power_down() for standby and off
here?

> +static int twl4030_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{

> +		/* turn off codec before changing format */
> +		mode = twl4030_read_reg_cache(codec, REG_CODEC_MODE);
> +		mode &= ~CODECPDZ;
> +		twl4030_write(codec, REG_CODEC_MODE, mode);

The comments about powering up and down the codec could probably use a
little clarification given the fact that there are also power_down() and
power_up() functions.  

> +static int twl4030_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	u8 ldac_reg = twl4030_read_reg_cache(codec, REG_ARXL2PGA);
> +	u8 rdac_reg = twl4030_read_reg_cache(codec, REG_ARXR2PGA);
> +
> +	if (mute) {
> +		twl4030_write(codec, REG_ARXL2PGA, 0x00);
> +		twl4030_write(codec, REG_ARXR2PGA, 0x00);
> +		twl4030_write_reg_cache(codec, REG_ARXL2PGA, ldac_reg);
> +		twl4030_write_reg_cache(codec, REG_ARXR2PGA, rdac_reg);
> +	} else {
> +		twl4030_write(codec, REG_ARXL2PGA, ldac_reg);
> +		twl4030_write(codec, REG_ARXR2PGA, rdac_reg);
> +	}

It may be better to make these user visible controls - usually the mute
provided here is specifically for the DAC but these look like controls
for the PGA.  The intention here is to avoid artifacts from the DAC when
the input clock stops and start - if there aren't any then user space
may well appreciate the control.  Either way is fine.

> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		format &= ~(AIF_SLAVE_EN);
> +		format |= CLK256FS_EN;
> +		break;

> +static int twl4030_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = socdev->codec;
> +
> +	printk(KERN_INFO "TWL4030 Audio Codec suspend\n");
> +	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}

Merging the power down into set_bias_level() would mean that this would
do a controlled power down - at present it will be a no-op.

> +static int twl4030_resume(struct platform_device *pdev)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = socdev->codec;
> +	int i;
> +	u16 *cache = codec->reg_cache;
> +
> +	printk(KERN_INFO "TWL4030 Audio Codec resume\n");
> +	/* Sync reg_cache with the hardware */
> +	for (i = REG_CODEC_MODE; i <= REG_MISC_SET_2; i++)
> +		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, cache[i], i);
> +
> +	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	twl4030_set_bias_level(codec, codec->suspend_bias_level);
> +	return 0;
> +}

Similarly, adding the power up to the standby configuration would ensure
a controlled power up of the codec when resuming.  Looking at the power
up sequence I'm not sure that simply writing back the cache will work
well?

> +	twl4030_init_chip();
> +	twl4030_power_up(codec, APLL_RATE_44100 | OPT_MODE);

It looks like the driver is assuming a particular clock rate going into
the codec - does the chip require a fixed clock or is the driver only
supporting one configuration?  Either is fine.
