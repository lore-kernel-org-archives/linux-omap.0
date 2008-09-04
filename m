From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/5] SOUND: SOC: CODECS: Add support for
	the TWL4030 audio codec
Date: Thu, 4 Sep 2008 13:04:42 +0100
Message-ID: <20080904120441.GB21663@sirena.org.uk>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	<1220504520-6067-2-git-send-email-sakoman@gmail.com>
	<1220504520-6067-3-git-send-email-sakoman@gmail.com>
	<1220504520-6067-4-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
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
To: sakoman@gmail.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 03, 2008 at 10:01:58PM -0700, sakoman@gmail.com wrote:

> +static void twl4030_power_up(struct snd_soc_codec *codec)
> +{
> +	u8 mode, byte, popn, hsgain;
> +
> +	/* set CODECPDZ to turn on codec */
> +	mode = twl4030_read_reg_cache(codec, REG_CODEC_MODE);
> +	twl4030_write(codec, REG_CODEC_MODE, mode | CODECPDZ);
> +	udelay(10);
> +
> +	/* initiate offset cancellation */
> +	twl4030_write(codec, REG_ANAMICL,
> +		twl4030_reg[REG_ANAMICL] | CNCL_OFFSET_START);

It looks a bit odd to see this reading the register defaults rather than
the register cache.

> +	/* wait for offset cancellation to complete */
> +	twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte, REG_ANAMICL);
> +	while ((byte & CNCL_OFFSET_START) == CNCL_OFFSET_START)
> +		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
> +					&byte, REG_ANAMICL);

How long is this likely to take?  If it might take a while then putting
a delay in between reads might be nice.  As Jarkko said, a timeout would
be a good idea too in case something went wrong.

> +	/* anti-pop when changing analog gain */
> +	twl4030_write(codec, REG_MISC_SET_1,
> +		twl4030_reg[REG_MISC_SET_1] | SMOOTH_ANAVOL_EN);

Another one reading the register defaults rather than register cache...

> +	/* disable bias out */
> +	popn &= ~VMID_EN;
> +	twl4030_write(codec, REG_HS_POPN_SET, popn);

...

> +	case SND_SOC_BIAS_ON:
> +		twl4030_power_up(codec);
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		twl4030_power_down(codec);
> +		break;

Normally SND_SOC_BIAS_STANDBY would leave Vmid enabled but your power
down function turns it off.  The normal thing here is to have standby
bring the codec up and then apply relatively small tweaks in _ON and
_PREPARE that do things like improve the quality of the reference
voltages.  Equally well, since the driver does not yet implement DAPM
support doing this will give you power savings that you wouldn't
otherwise get.

Does the codec have any bypass paths that can be set up?  If not it
shouldn't do much harm either way until you implement DAPM.

> +/* AUDIO_IF (0x0E) Fields */
> +
> +#define AIF_SLAVE_EN		0x80
> +#define DATA_WIDTH		0x60

These should really all get namespaced - some of them look relatively
likely to collide with registers for CPU side stuff.
