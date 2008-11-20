From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: TWL4030 asoc kcontrols and widgets
Date: Thu, 20 Nov 2008 12:55:15 +0200
Message-ID: <31e679430811200255w33198a1r810f516b7326f414@mail.gmail.com>
References: <ef0d8a250811200202o5852dabct8c5b135b86141f67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:1333 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbYKTKzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 05:55:18 -0500
Received: by yw-out-2324.google.com with SMTP id 9so181643ywe.1
        for <linux-omap@vger.kernel.org>; Thu, 20 Nov 2008 02:55:17 -0800 (PST)
In-Reply-To: <ef0d8a250811200202o5852dabct8c5b135b86141f67@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

This list has been moved to linux-omap@vger.kernel.org

Please, keep that in Cc, also for ASoC development, send it also to the
proper alsa mailing list alsa-devel@alsa-project.org

Tony, I think you should apply this patch in mainline tree:

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dae455..54c8e90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4010,6 +4010,13 @@ P:       Alex Dubov
 M:     oakad@yahoo.com
 S:     Maintained

+TI OMAP
+P:     Tony Lindgren
+M:     tony@atomide.com
+L:     linux-omap@vger.kernel.org
+T:     git kernel.org:/pub/scm/linux/tmlind/linux-omap-2.6.git
+S:     Maintained
+
 TI OMAP MMC INTERFACE DRIVER
 P:     Carlos Aguiar, Anderson Briglia and Syed Khasim
 M:     linux-omap@vger.kernel.org


On Thu, Nov 20, 2008 at 12:02 PM, naveen krishna ch
<naveenkrishna.ch@gmail.com> wrote:
> Hi All
>
> I have been working on TWL4030 codec driver for ALSA SOC.
> I have taken sound/soc/codec/twl4030.c as reference from main line
>
> This Patch adds some kcontrols, widgets and interconnection map for some of
> the TWL4030 ASOC codec
> I was building it for a custom board as it was for OVERO
>
>
> Suggestions on the DAPM part of the driver would be helpful
>
> Thanks in advance.
>
> The patch is as follows.
>
>
> --- twl4030.c    2008-11-19 12:04:32.000000000 +0530
> +++ /home/chnaveen/Desktop/twl4030.c    2008-11-21 15:08:06.000000000 +0530
> @@ -16,7 +16,9 @@
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>  * 02110-1301 USA
> - *
> + * Modified by  : Naveen Krishna Ch
> + * Added Kcontrols for OMAP3 WaterlooBoard
> + * Dated    : 28th october 2008
>  */
>
>  #include <linux/module.h>
> @@ -29,24 +31,27 @@
>  #include <linux/i2c/twl4030.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
> +#include <sound/jack.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
>  #include <sound/initval.h>
> -
> +#include <asm/arch/twl4030.h>
>  #include "twl4030.h"
>
> +static int twl4030_jack_func;
> +
>  /*
>  * twl4030 register cache & default register settings
>  */
>  static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
>     0x00, /* this register not used        */
> -    0x93, /* REG_CODEC_MODE        (0x1)    */
> +    0x03, /* REG_CODEC_MODE        (0x1)    */
>     0xc3, /* REG_OPTION        (0x2)    */
>     0x00, /* REG_UNKNOWN        (0x3)    */
>     0x00, /* REG_MICBIAS_CTL    (0x4)    */
> -    0x24, /* REG_ANAMICL        (0x5)    */
> -    0x04, /* REG_ANAMICR        (0x6)    */
> +    0xb0, /* REG_ANAMICL        (0x5)    */
> +    0x10, /* REG_ANAMICR        (0x6)    */
>     0x0a, /* REG_AVADC_CTL        (0x7)    */
>     0x00, /* REG_ADCMICSEL        (0x8)    */
>     0x00, /* REG_DIGMIXING        (0x9)    */
> @@ -67,22 +72,22 @@
>     0x00, /* REG_ARX2VTXPGA        (0x18)    */
>     0x00, /* REG_ARXL1_APGA_CTL    (0x19)    */
>     0x00, /* REG_ARXR1_APGA_CTL    (0x1A)    */
> -    0x4b, /* REG_ARXL2_APGA_CTL    (0x1B)    */
> -    0x4b, /* REG_ARXR2_APGA_CTL    (0x1C)    */
> +    0x2b, /* REG_ARXL2_APGA_CTL    (0x1B)    */
> +    0x2b, /* REG_ARXR2_APGA_CTL    (0x1C)    */
>     0x00, /* REG_ATX2ARXPGA        (0x1D)    */
>     0x00, /* REG_BT_IF        (0x1E)    */
>     0x00, /* REG_BTPGA        (0x1F)    */
>     0x00, /* REG_BTSTPGA        (0x20)    */
> -    0x00, /* REG_EAR_CTL        (0x21)    */
> -    0x24, /* REG_HS_SEL        (0x22)    */
> -    0x0a, /* REG_HS_GAIN_SET    (0x23)    */
> -    0x00, /* REG_HS_POPN_SET    (0x24)    */
> -    0x00, /* REG_PREDL_CTL        (0x25)    */
> -    0x00, /* REG_PREDR_CTL        (0x26)    */
> -    0x00, /* REG_PRECKL_CTL        (0x27)    */
> -    0x00, /* REG_PRECKR_CTL        (0x28)    */
> -    0x00, /* REG_HFL_CTL        (0x29)    */
> -    0x00, /* REG_HFR_CTL        (0x2A)    */
> +    0x20, /* REG_EAR_CTL        (0x21)    */
> +    0x00, /* REG_HS_SEL        (0x22)    */
> +    0x05, /* REG_HS_GAIN_SET    (0x23)    */
> +    0x42, /* REG_HS_POPN_SET    (0x24)    */
> +    0x20, /* REG_PREDL_CTL        (0x25)    */
> +    0x20, /* REG_PREDR_CTL        (0x26)    */
> +    0x20, /* REG_PRECKL_CTL        (0x27)    */
> +    0x20, /* REG_PRECKR_CTL        (0x28)    */
> +    0x1f, /* REG_HFL_CTL        (0x29)    */
> +    0x1f, /* REG_HFR_CTL        (0x2A)    */
>     0x00, /* REG_ALC_CTL        (0x2B)    */
>     0x00, /* REG_ALC_SET1        (0x2C)    */
>     0x00, /* REG_ALC_SET2        (0x2D)    */
> @@ -112,9 +117,40 @@
>     0x00, /* REG_VIBRA_CTL        (0x45)    */
>     0x00, /* REG_VIBRA_SET        (0x46)    */
>     0x00, /* REG_VIBRA_PWM_SET    (0x47)    */
> -    0x00, /* REG_ANAMIC_GAIN    (0x48)    */
> +    0x24, /* REG_ANAMIC_GAIN    (0x48)    */
>     0x00, /* REG_MISC_SET_2        (0x49)    */
>  };
> +static void twl4030_ext_control(struct snd_soc_codec *codec)
> +{
> +        if (twl4030_jack_func)
> +                snd_soc_dapm_enable_pin(codec, "Headphone Jack");
> +        else
> +                snd_soc_dapm_disable_pin(codec, "Headphone Jack");
> +
> +            snd_soc_dapm_sync(codec);
> +}
> +
> +static int twl4030_get_jack(struct snd_kcontrol *kcontrol,
> +                         struct snd_ctl_elem_value *ucontrol)
> +{
> +        ucontrol->value.integer.value[0] = twl4030_jack_func;
> +
> +        return 0;
> +}
> +
> +static int twl4030_set_jack(struct snd_kcontrol *kcontrol,
> +                         struct snd_ctl_elem_value *ucontrol)
> +{
> +        struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
> +
> +        if (twl4030_jack_func == ucontrol->value.integer.value[0])
> +                return 0;
> +
> +        twl4030_jack_func = ucontrol->value.integer.value[0];
> +        twl4030_ext_control(codec);
> +
> +        return 1;
> +}
>
>  /*
>  * read twl4030 register cache
> @@ -188,14 +224,83 @@
>         twl4030_write(codec, i,    twl4030_reg[i]);
>
>  }
> +static const char *jack_function[] = {"Off", "Headphone"};
> +
> +static const struct soc_enum twl4030_enum[] = {
> +        SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(jack_function), jack_function),
> +};
> +
>
>  static const struct snd_kcontrol_new twl4030_snd_controls[] = {
> -    SOC_DOUBLE_R("Master Playback Volume",
> -         TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> -        0, 127, 0),
> -    SOC_DOUBLE_R("Capture Volume",
> -         TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> -        0, 127, 0),
> +
> +    /* Master Playback Volume Controls */
> +    SOC_DOUBLE_R("Master PLayback Course Gain ctrl",
> +                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> +                6, 3, 0),
> +    SOC_DOUBLE_R("Master Playback Fine Gain ctrl",
> +                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> +                0, 63, 0),
> +
> +    /* Playback Speaker volume controls */
> +    SOC_DOUBLE_R("Speaker R2+L2 Volume ctrls",
> +        TWL4030_REG_ARXL2_APGA_CTL, TWL4030_REG_ARXR2_APGA_CTL,
> +         3, 17, 0),
> +
> +        /* Capture Gain controls */
> +        SOC_DOUBLE_R("Master Capture Gain ctrl",
> +                TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> +                0, 31, 0),
> +    /* Loop gain controls*/
> +        SOC_DOUBLE("Loop Gain ctrl", TWL4030_REG_ATX2ARXPGA,
> +                3 , 0, 7, 0),
> +
> +        SOC_DOUBLE("Main +Sub mic capture gain ctrl",
> +                TWL4030_REG_ANAMIC_GAIN, 3 , 0, 5, 0),
> +
> +        SOC_DOUBLE_R("External Speaker Volume control",
> +                TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
> +                4, 3, 0),
> +
> +    SOC_DOUBLE_R("Pre Car kit Volume control",
> +                TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
> +                4, 3, 0),
> +
> +    SOC_SINGLE("DACL2", TWL4030_REG_AVDAC_CTL, 3, 1, 0),
> +        SOC_SINGLE("DACR2", TWL4030_REG_AVDAC_CTL, 2, 1, 0),
> +
> +        SOC_ENUM_EXT("Jack Function", twl4030_enum[0],
> +                        twl4030_get_jack, twl4030_set_jack),
> +};
> +
> +/* Right PGA Mixer control switches */
> +static const struct snd_kcontrol_new twl4030_right_pga_mixer_controls[] = {
> +        SOC_DAPM_SINGLE("HS Mic switch", TWL4030_REG_ANAMICL, 1, 1, 0),
> +        SOC_DAPM_SINGLE("Aux/FM right switch", TWL4030_REG_ANAMICR, 2, 1,
> 0),
> +        SOC_DAPM_SINGLE("Sub Mic switch", TWL4030_REG_ANAMICR, 0, 1, 0),
> +};
> +
> +/* Left PGA Mixer control switches */
> +static const struct snd_kcontrol_new twl4030_left_pga_mixer_controls[] = {
> +        SOC_DAPM_SINGLE("HS Mic switch", TWL4030_REG_ANAMICL, 1, 1, 0),
> +        SOC_DAPM_SINGLE("Aux/FM left switch", TWL4030_REG_ANAMICL, 2, 1,
> 0),
> +        SOC_DAPM_SINGLE("Main Mic switch", TWL4030_REG_ANAMICL, 0, 1, 0),
> +};
> +
> +/* Right DACR2 Mixer */
> +static const struct snd_kcontrol_new twl4030_dacr2_mixer_controls[] = {
> +        SOC_DAPM_SINGLE("Headset-R switch", TWL4030_REG_HS_SEL, 5, 1, 0),
> +        SOC_DAPM_SINGLE("Handsfree-R switch", TWL4030_REG_HFR_CTL, 5, 1,
> 0),
> +    SOC_DAPM_SINGLE("PRECK-R switch", TWL4030_REG_PRECKR_CTL, 2, 1,
> 0),
> +    SOC_DAPM_DOUBLE("E class-D amp-R switch", TWL4030_REG_PREDR_CTL, 3, 2,
> 1, 0, 0),
> +};
> +
> +/* Left DACL2 Mixer */
> +static const struct snd_kcontrol_new twl4030_dacl2_mixer_controls[] = {
> +        SOC_DAPM_SINGLE("Headset-L switch", TWL4030_REG_HS_SEL, 2, 1, 0),
> +        SOC_DAPM_SINGLE("Handsfree-L switch", TWL4030_REG_HFL_CTL, 5, 1,
> 0),
> +        SOC_DAPM_SINGLE("Ear peice switch", TWL4030_REG_EAR_CTL, 2, 1,
> 0),
> +    SOC_DAPM_SINGLE("PRECK-L switch", TWL4030_REG_PRECKL_CTL, 2, 1, 0),
> +        SOC_DAPM_DOUBLE("E class-D amp-L switch", TWL4031_REG_PREDL_CTL, 3,
> 2, 1, 0, 0),
>  };
>
>  /* add non dapm controls */
> @@ -215,27 +320,96 @@
>  }
>
>  static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
> -    SND_SOC_DAPM_INPUT("INL"),
> -    SND_SOC_DAPM_INPUT("INR"),
> -
> -    SND_SOC_DAPM_OUTPUT("OUTL"),
> -    SND_SOC_DAPM_OUTPUT("OUTR"),
> -
> -    SND_SOC_DAPM_DAC("DACL", "Left Playback", SND_SOC_NOPM, 0, 0),
> -    SND_SOC_DAPM_DAC("DACR", "Right Playback", SND_SOC_NOPM, 0, 0),
> -
> -    SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
> -    SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
> +
> +    SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +
> +        /* Left ADC for capture */
> +        SND_SOC_DAPM_ADC("ADCL", "Left Capture ADC", TWL4030_REG_AVADC_CTL,
> 3, 0),
> +
> +        /* dapm widget (path domain) for left PGA mixer */
> +        SND_SOC_DAPM_MIXER("LINEIN-L", SND_SOC_NOPM, 0, 0,
> +                           &twl4030_left_pga_mixer_controls[0],
> +                           ARRAY_SIZE(twl4030_left_pga_mixer_controls)),
> +
> +    /* Right ADC for capture*/
> +        SND_SOC_DAPM_ADC("ADCR", "Right Capture ADC",
> TWL4030_REG_AVADC_CTL, 1, 0),
> +
> +        /* dapm widget (path domain) for right PGA mixer */
> +        SND_SOC_DAPM_MIXER("LINEIN-R", SND_SOC_NOPM, 0, 0,
> +                           &twl4030_right_pga_mixer_controls[0],
> +                           ARRAY_SIZE(twl4030_right_pga_mixer_controls)),
> +
> +        /* dapm widget (path domain) for left DACL2 Mixer */
> +
> +    SND_SOC_DAPM_MIXER("DACL2 Mixer", SND_SOC_NOPM, 0, 0,
> +                           &twl4030_dacl2_mixer_controls[0],
> +                           ARRAY_SIZE(twl4030_dacl2_mixer_controls)),
> +
> +        /* dapm widget (path domain) for DACR2 Mixer */
> +        SND_SOC_DAPM_MIXER("DACR2 Mixer", SND_SOC_NOPM, 0, 0,
> +                           &twl4030_dacr2_mixer_controls[0],
> +                           ARRAY_SIZE(twl4030_dacr2_mixer_controls)),
> +
> +     /* Inputs Left*/
> +        SND_SOC_DAPM_INPUT("HSMIC"),
> +        SND_SOC_DAPM_INPUT("Aux/fm left"),
> +        SND_SOC_DAPM_INPUT("Main mic"),
> +
> +        /* Inputs Right*/
> +        SND_SOC_DAPM_INPUT("HSMIC"),
> +        SND_SOC_DAPM_INPUT("Aux/fm right"),
> +        SND_SOC_DAPM_INPUT("Sub mic"),
> +
> +    /* Outputs Left*/
> +        SND_SOC_DAPM_OUTPUT("HSOL"),
> +        SND_SOC_DAPM_OUTPUT("IHF_LEFT"),
> +        SND_SOC_DAPM_OUTPUT("EAR"),
> +        SND_SOC_DAPM_OUTPUT("E class-D L"),
> +    SND_SOC_DAPM_OUTPUT("PRECK-L");
> +
> +        /* Outputs Right */
> +        SND_SOC_DAPM_OUTPUT("HSOR"),
> +        SND_SOC_DAPM_OUTPUT("IHF_RIGHT"),
> +        SND_SOC_DAPM_OUTPUT("E class-D R"),
> +    SND_SOC_DAPM_OUTPUT("PRECK-R");
>  };
>
>  static const struct snd_soc_dapm_route intercon[] = {
> -    /* outputs */
> -    {"OUTL", NULL, "DACL"},
> -    {"OUTR", NULL, "DACR"},
> -
> -    /* inputs */
> -    {"ADCL", NULL, "INL"},
> -    {"ADCR", NULL, "INR"},
> +
> +        /* ******** Left input ******** */
> +        {"LINEIN-L", "HS Mic switch", "HSMIC"},
> +        {"LINEIN-L", "Aux/FM left switch", "Aux/fm left"},
> +        {"LINEIN-L", "Main Mic switch", "Main mic"},
> +
> +        {"ADCL", NULL, "LINEIN-L"},
> +
> +
> +        /* ******** Right Input ******** */
> +        {"LINEIN-R", "HS Mic switch", "HSMIC"},
> +        {"LINEIN-R", "Aux/FM right switch", "Aux/fm right"},
> +        {"LINEIN-R", "Sub Mic switch", "Sub mic"},
> +
> +        {"ADCR", NULL, "LINEIN-R"},
> +
> +    /* ******** Left Output ******** */
> +        //{"DACL2", NULL, "DACL2 Mixer"},
> +
> +        {"DACL2 Mixer", "Headset-L switch", "HSOL"},
> +        {"DACL2 Mixer", "Handsfree-L switch", "IHF_LEFT"},
> +        {"DACL2 Mixer", "Ear peice switch", "EAR"},
> +    {"DACL2 Mixer", "PRECK-L switch", "PRECK-L"},
> +        {"DACL2 Mixer","E class-D amp-L switch","E class-D L"},
> +
> +    {"Headphone Jack",NULL, "HSOL"},
> +        /* ******** Right Output ******** */
> +        //{"DACR2", NULL, "DACR2 Mixer"},
> +
> +        {"DACR2 Mixer", "Headset-R switch","HSOR"},
> +        {"DACR2 Mixer", "Handsfree-R switch","IHF_RIGHT"},
> +    {"DACR2 Mixer", "PRECK-R switch", "PRECK-R"},
> +        {"DACR2 Mixer","E class-D amp-R switch","E class-D R"},
> +
> +        {"Headphone Jack",NULL, "HSOR"},
>  };
>
>  static int twl4030_add_widgets(struct snd_soc_codec *codec)
> @@ -280,7 +454,7 @@
>     /* toggle CODECPDZ as per TRM */
>     twl4030_clear_codecpdz(codec);
>     twl4030_set_codecpdz(codec);
> -
> +
>     /* program anti-pop with bias ramp delay */
>     popn = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
>     popn &= TWL4030_RAMP_DELAY;
> @@ -384,6 +558,9 @@
>     case 48000:
>         mode |= TWL4030_APLL_RATE_48000;
>         break;
> +    case 96000:
> +        mode |= TWL4030_APLL_RATE_96000;
> +        break;
>     default:
>         printk(KERN_ERR "TWL4030 hw params: unknown rate %d\n",
>             params_rate(params));
> @@ -434,6 +611,7 @@
>     u8 infreq;
>
>     switch (freq) {
> +
>     case 19200000:
>         infreq = TWL4030_APLL_INFREQ_19200KHZ;
>         break;
> @@ -504,20 +682,24 @@
>     return 0;
>  }
>
> -#define TWL4030_RATES     (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
> +#define TWL4030_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |     \
> +                       SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |    \
> +                       SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |    \
> +                       SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
> +
>  #define TWL4030_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FORMAT_S24_LE)
>
>  struct snd_soc_dai twl4030_dai = {
>     .name = "twl4030",
>     .playback = {
>         .stream_name = "Playback",
> -        .channels_min = 2,
> +        .channels_min = 1,
>         .channels_max = 2,
>         .rates = TWL4030_RATES,
>         .formats = TWL4030_FORMATS,},
>     .capture = {
>         .stream_name = "Capture",
> -        .channels_min = 2,
> +        .channels_min = 1,
>         .channels_max = 2,
>         .rates = TWL4030_RATES,
>         .formats = TWL4030_FORMATS,},
> @@ -616,13 +798,14 @@
>
>     codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
>     if (codec == NULL)
> -        return -ENOMEM;
> -
> +        return -ENOMEM;
> +
>     socdev->codec = codec;
>     mutex_init(&codec->mutex);
>     INIT_LIST_HEAD(&codec->dapm_widgets);
>     INIT_LIST_HEAD(&codec->dapm_paths);
> -
> +
> +
>     twl4030_socdev = socdev;
>     twl4030_init(socdev);
>
> Patch ends..
>
> Thanks and Regards,
>
> (: Naveen Krishna Ch :)
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
