From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 3/5] SOUND: SOC: CODECS: Add support for
 the TWL4030 audio codec
Date: Thu, 4 Sep 2008 13:26:32 +0300
Message-ID: <20080904132632.e64c3ce2.jarkko.nikula@nokia.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	<1220504520-6067-2-git-send-email-sakoman@gmail.com>
	<1220504520-6067-3-git-send-email-sakoman@gmail.com>
	<1220504520-6067-4-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1220504520-6067-4-git-send-email-sakoman@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext sakoman@gmail.com" <sakoman@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Wed,  3 Sep 2008 22:01:58 -0700
"ext sakoman@gmail.com" <sakoman@gmail.com> wrote:

> From: Steve Sakoman <steve@sakoman.com>
> 
> ---
>  sound/soc/codecs/Kconfig   |    5 +
>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/twl4030.c |  628 +++++++++++++++++++++++++++++++++++
...
> +static void twl4030_dump_registers(void)
> +{
This is not needed since there is already nice function
for it: sound/soc/soc-core.c: codec_reg_show.

> +static void twl4030_power_up(struct snd_soc_codec *codec)
> +{
> +	u8 mode, byte, popn, hsgain;
> +
...
> +	/* wait for offset cancellation to complete */
> +	twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
> REG_ANAMICL);
> +	while ((byte & CNCL_OFFSET_START) == CNCL_OFFSET_START)
> +		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
> +					&byte, REG_ANAMICL);
> +
Probably some timeout escape here.

> +static void twl4030_power_down(struct snd_soc_codec *codec)
> +{
...
> +	udelay(10);
> +}
REVISIT comment for these kind of magic delays if doesn't work without.

> +static int twl4030_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{
...
> +	switch (params_rate(params)) {
> +	case 44100:
> +		mode |= APLL_RATE_44100;
> +		break;
> +	case 48000:
> +		mode |= APLL_RATE_48000;
> +		break;
> +	default:
> +		printk(KERN_ERR "TWL4030 hw params: unknown rate %d
> \n",
> +			params_rate(params));
> +		return -EINVAL;
> +	}
I checked that chip supports also other standard rates from 8 kHz,
11.025 kHz, etc. However I didn't find from quick look how this relates
to interface rate. I would say that small TODO comment to whom who has
platform to try these combinations would be nice.

> +static int twl4030_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +		int clk_id, unsigned int freq, int dir)
> +{
...
> +
> +	infreq |= APLL_EN;
> +	twl4030_write(codec, REG_APLL_CTL, infreq);
> +
> +	return 0;
> +}
If this actually place for set_pll callback if one wants to manage PLL
(APLL_EN bit) dynamically?


Jarkko
