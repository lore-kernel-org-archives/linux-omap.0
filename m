From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5 v1] ASoC Add TLV320AIC23 codec driver
Date: Tue, 30 Sep 2008 11:19:52 +0100
Message-ID: <20080930101951.GA19862@sirena.org.uk>
References: <dfeb90390809300259k1b848aaehc3519ec50c6ec96d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <dfeb90390809300259k1b848aaehc3519ec50c6ec96d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 30, 2008 at 03:29:32PM +0530, Arun KS wrote:

Thanks!  It looks like you've addressed pretty much all the comments
from the first round of reviews but a few additional (fairly minor
comments):

> +static const char *tlv320aic23_rec_src[] = { "Line", "Mic" };
> +static const char *tlv320aic23_sidetone_src[] =
> +    { "-6db", "-9db", "-12db", "-18db", "0db" };
> +
> +static const struct soc_enum tlv320aic23_enum[] = {
> +	SOC_ENUM_SINGLE(TLV320AIC23_ANALOG_AUDIO_CONTROL, 2, 2,
> +			tlv320aic23_rec_src),
> +	SOC_ENUM_SINGLE(TLV320AIC23_ANALOG_AUDIO_CONTROL, 6, 5,
> +			tlv320aic23_sidetone_src),
> +};
> +

sidetone_src really ought to be a SOC_SINGLE_TLV rather than an enum
from the looks of it - it's not selecting between sources for the
sidetone, it's determining the level of the signal so a gain control
with TLV information would present better in UIs.

> +static const struct snd_kcontrol_new tlv320aic23_rec_src_mux_controls =
> +SOC_DAPM_ENUM("Route", tlv320aic23_enum[0]);

> +static const struct snd_kcontrol_new tlv320aic23_sidetone_src_controls =
> +SOC_DAPM_ENUM("Route", tlv320aic23_enum[1]);

I know some of the older codec drivers do it but there's no need to have
the enums be an array and it doesn't help clarity.  Equally well, it's
not a blocker for merge.

> +static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
> +	SOC_DOUBLE_R("PCM Playback Volume", TLV320AIC23_LEFT_CHANNEL_VOLUME,
> +		     TLV320AIC23_RIGHT_CHANNEL_VOLUME, 0, 0x7f, 0),

TLV information might be nice here too (but it's not required).  I
suspect "Digital Playback Volume" would be a better name, but I'm not
100% sure on that one.

> +	SOC_DOUBLE_R("Line Input Mute", TLV320AIC23_LEFT_LINE_VOLUME,
> +		     TLV320AIC23_RIGHT_LINE_VOLUME, 7, 0x01, 0),

This should be "Line Input Switch" for user interfaces to pick it up
properly.

> +static const struct snd_soc_dapm_route intercon[] = {
> +
> +	{"LHPOUT", NULL, "DAC"},
> +	{"RHPOUT", NULL, "DAC"},
> +
> +	{"LOUT", NULL, "DAC"},
> +	{"ROUT", NULL, "DAC"},
> +
> +	{"Capture Source", "Line", "LLINEIN"},
> +	{"Capture Source", "Line", "RLINEIN"},
> +
> +	{"Capture Source", "Mic", "MICIN"},
> +
> +	{"PGA Mixer", "Line Switch", "Capture Source"},
> +	{"PGA Mixer", "Mic Switch", "Capture Source"},
> +
> +	{"ADC", NULL, "PGA Mixer"},
> +};

There are no routes here for your bypass path(s) - this will mean that
DAPM won't power them on unless there's an active playback and record.
At present that's fine for digital only bypass paths but if there are
analogue ones they should be visible here.

> +static int tlv320aic23_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	u16 reg;
> +
> +	reg =
> +	    tlv320aic23_read_reg_cache(codec,
> +				       TLV320AIC23_DIGITAL_AUDIO_CONTROL) &
> +	    ~DACM_MUTE;

Have you resolved the word wrapping issues with your mailer?  I've not
tried applying the patch but things like this make me think that it has
been mangled.

> +static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				      int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct tlv320aic23_priv *tlv320aic23 = codec->private_data;
> +
> +	tlv320aic23->sysclk = freq;
> +	return 0;
> +}

You don't actually use sysclk for anything so you may as well drop this
function and the local variable.

> +		tlv320aic23->master = 1;
> +		iface_reg |= MS_MASTER;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		tlv320aic23->master = 0;
> +		break;

You don't seem to use master anywhere either so it could also be
dropped?

> +
> +/* Left (right) line input volume control register */
> +#define LRS_ENABLED			0x0100
> +#define LIM_MUTED			0x0080
> +#define LIV_DEFAULT			0x0017
> +#define LIV_MAX				0x001f
> +#define LIV_MIN				0x0000

All the definitions in the header should be namespaced - there's things
like:

> +/* Power control down register */
> +#define DEVICE_POWER_OFF	  	0x0080
> +#define CLK_OFF				0x0040
> +#define OSC_OFF				0x0020
> +#define OUT_OFF				0x0010
> +#define DAC_OFF				0x0008
> +#define ADC_OFF				0x0004
> +#define MIC_OFF				0x0002
> +#define LINE_OFF			0x0001

which are very likely to collide with other chips.
