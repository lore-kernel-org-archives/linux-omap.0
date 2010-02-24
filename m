From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec
	driver
Date: Wed, 24 Feb 2010 10:38:01 +0000
Message-ID: <1267007881.3274.136.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2010-02-23 at 18:10 -0600, Olaya, Margarita wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> Initial version of TWL6030 codec driver.
> 
> The TWL6030 codec uses a propietary PDM-based digital audio interface.
> Audio paths supported are:
> 
> - Input: Main Mic, Sub Mic, Headset Mic, Auxiliary-FM Left/Right
> - Output: Headset Left/Right, Handsfree Left/Right
> 
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> ---
>  sound/soc/codecs/Kconfig   |    4 +
>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/twl6030.c |  823 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/twl6030.h |   94 +++++
>  4 files changed, 923 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/twl6030.c
>  create mode 100644 sound/soc/codecs/twl6030.h
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 52b005f..3b3d739 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -33,6 +33,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_TPA6130A2 if I2C
>         select SND_SOC_TLV320DAC33 if I2C
>         select SND_SOC_TWL4030 if TWL4030_CORE
> +       select SND_SOC_TWL6030 if TWL4030_CORE
>         select SND_SOC_UDA134X
>         select SND_SOC_UDA1380 if I2C
>         select SND_SOC_WM8350 if MFD_WM8350
> @@ -155,6 +156,9 @@ config SND_SOC_TWL4030
>         select TWL4030_CODEC
>         tristate
> 
> +config SND_SOC_TWL6030
> +       tristate
> +
>  config SND_SOC_UDA134X
>         tristate
> 
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index dbaecb1..e11a193 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -20,6 +20,7 @@ snd-soc-tlv320aic26-objs := tlv320aic26.o
>  snd-soc-tlv320aic3x-objs := tlv320aic3x.o
>  snd-soc-tlv320dac33-objs := tlv320dac33.o
>  snd-soc-twl4030-objs := twl4030.o
> +snd-soc-twl6030-objs := twl6030.o
>  snd-soc-uda134x-objs := uda134x.o
>  snd-soc-uda1380-objs := uda1380.o
>  snd-soc-wm8350-objs := wm8350.o
> @@ -76,6 +77,7 @@ obj-$(CONFIG_SND_SOC_TLV320AIC26)     += snd-soc-tlv320aic26.o
>  obj-$(CONFIG_SND_SOC_TLV320AIC3X)      += snd-soc-tlv320aic3x.o
>  obj-$(CONFIG_SND_SOC_TLV320DAC33)      += snd-soc-tlv320dac33.o
>  obj-$(CONFIG_SND_SOC_TWL4030)  += snd-soc-twl4030.o
> +obj-$(CONFIG_SND_SOC_TWL6030)  += snd-soc-twl6030.o
>  obj-$(CONFIG_SND_SOC_UDA134X)  += snd-soc-uda134x.o
>  obj-$(CONFIG_SND_SOC_UDA1380)  += snd-soc-uda1380.o
>  obj-$(CONFIG_SND_SOC_WM8350)   += snd-soc-wm8350.o
> diff --git a/sound/soc/codecs/twl6030.c b/sound/soc/codecs/twl6030.c
> new file mode 100644
> index 0000000..8b52aa1
> --- /dev/null
> +++ b/sound/soc/codecs/twl6030.c
> @@ -0,0 +1,823 @@
> +/*
> + * ALSA SoC TWL6030 codec driver
> + *
> + * Author:      Misael Lopez Cruz <x0052729@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/pm.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c/twl.h>
> +
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
> +#include <sound/tlv.h>
> +
> +#include "twl6030.h"
> +
> +#define TWL6030_RATES   (SNDRV_PCM_RATE_96000)
> +#define TWL6030_FORMATS         (SNDRV_PCM_FMTBIT_S32_LE)
> +
> +/* codec private data */
> +struct twl6030_data {
> +       struct snd_soc_codec codec;
> +       int audpwron;
> +       int codec_powered;
> +};
> +
> +/*
> + * twl6030 register cache & default register settings
> + */
> +static const u8 twl6030_reg[TWL6030_CACHEREGNUM] = {
> +       0x00, /* not used               0x00    */
> +       0x4B, /* TWL6030_ASICID (ro)    0x01    */
> +       0x00, /* TWL6030_ASICREV (ro)   0x02    */
> +       0x00, /* TWL6030_INTID          0x03    */
> +       0x7B, /* TWL6030_INTMR          0x04    */
> +       0x00, /* TWL6030_NCPCTRL        0x05    */
> +       0x00, /* TWL6030_LDOCTL         0x06    */
> +       0x00, /* TWL6030_HPPLLCTL       0x07    */
> +       0x00, /* TWL6030_LPPLLCTL       0x08    */
> +       0x00, /* TWL6030_LPPLLDIV       0x09    */
> +       0x00, /* TWL6030_AMICBCTL       0x0A    */
> +       0x00, /* TWL6030_DMICBCTL       0x0B    */
> +       0x18, /* TWL6030_MICLCTL        0x0C    */
> +       0x18, /* TWL6030_MICRCTL        0x0D    */
> +       0x00, /* TWL6030_MICGAIN        0x0E    */
> +       0x1B, /* TWL6030_LINEGAIN       0x0F    */
> +       0x00, /* TWL6030_HSLCTL         0x10    */
> +       0x00, /* TWL6030_HSRCTL         0x11    */
> +       0x00, /* TWL6030_HSGAIN         0x12    */
> +       0x06, /* TWL6030_EARCTL         0x13    */
> +       0x00, /* TWL6030_HFLCTL         0x14    */
> +       0x03, /* TWL6030_HFLGAIN        0x15    */
> +       0x00, /* TWL6030_HFRCTL         0x16    */
> +       0x03, /* TWL6030_HFRGAIN        0x17    */
> +       0x00, /* TWL6030_VIBCTLL        0x18    */
> +       0x00, /* TWL6030_VIBDATL        0x19    */
> +       0x00, /* TWL6030_VIBCTLR        0x1A    */
> +       0x00, /* TWL6030_VIBDATR        0x1B    */
> +       0x00, /* TWL6030_HKCTL1         0x1C    */
> +       0x00, /* TWL6030_HKCTL2         0x1D    */
> +       0x00, /* TWL6030_GPOCTL         0x1E    */
> +       0x00, /* TWL6030_ALB            0x1F    */
> +       0x00, /* TWL6030_DLB            0x20    */
> +       0x00, /* not used               0x21    */
> +       0x00, /* not used               0x22    */
> +       0x00, /* not used               0x23    */
> +       0x00, /* not used               0x24    */
> +       0x00, /* not used               0x25    */
> +       0x00, /* not used               0x26    */
> +       0x00, /* not used               0x27    */
> +       0x00, /* TWL6030_TRIM1          0x28    */
> +       0x00, /* TWL6030_TRIM2          0x29    */
> +       0x00, /* TWL6030_TRIM3          0x2A    */
> +       0x00, /* TWL6030_HSOTRIM        0x2B    */
> +       0x00, /* TWL6030_HFOTRIM        0x2C    */
> +       0x09, /* TWL6030_ACCCTL         0x2D    */
> +       0x00, /* TWL6030_STATUS (ro)    0x2E    */
> +};
> +
> +/*
> + * twl6030 vio/gnd registers:
> + * registers under vio/gnd supply can be accessed
> + * before the power-up sequence, after NRESPWRON goes high
> + */
> +static const int twl6030_vio_reg[TWL6030_VIOREGNUM] = {
> +       TWL6030_REG_ASICID,
> +       TWL6030_REG_ASICREV,
> +       TWL6030_REG_INTID,
> +       TWL6030_REG_INTMR,
> +       TWL6030_REG_NCPCTL,
> +       TWL6030_REG_LDOCTL,
> +       TWL6030_REG_AMICBCTL,
> +       TWL6030_REG_DMICBCTL,
> +       TWL6030_REG_HKCTL1,
> +       TWL6030_REG_HKCTL2,
> +       TWL6030_REG_GPOCTL,
> +       TWL6030_REG_TRIM1,
> +       TWL6030_REG_TRIM2,
> +       TWL6030_REG_TRIM3,
> +       TWL6030_REG_HSOTRIM,
> +       TWL6030_REG_HFOTRIM,
> +       TWL6030_REG_ACCCTL,
> +       TWL6030_REG_STATUS,
> +};
> +
> +/*
> + * twl6030 vdd/vss registers:
> + * registers under vdd/vss supplies can only be accessed
> + * after the power-up sequence
> + */
> +static const int twl6030_vdd_reg[TWL6030_VDDREGNUM] = {
> +       TWL6030_REG_HPPLLCTL,
> +       TWL6030_REG_LPPLLCTL,
> +       TWL6030_REG_LPPLLDIV,
> +       TWL6030_REG_MICLCTL,
> +       TWL6030_REG_MICRCTL,
> +       TWL6030_REG_MICGAIN,
> +       TWL6030_REG_LINEGAIN,
> +       TWL6030_REG_HSLCTL,
> +       TWL6030_REG_HSRCTL,
> +       TWL6030_REG_HSGAIN,
> +       TWL6030_REG_EARCTL,
> +       TWL6030_REG_HFLCTL,
> +       TWL6030_REG_HFLGAIN,
> +       TWL6030_REG_HFRCTL,
> +       TWL6030_REG_HFRGAIN,
> +       TWL6030_REG_VIBCTLL,
> +       TWL6030_REG_VIBDATL,
> +       TWL6030_REG_VIBCTLR,
> +       TWL6030_REG_VIBDATR,
> +       TWL6030_REG_ALB,
> +       TWL6030_REG_DLB,
> +};
> +
> +/*
> + * read twl6030 register cache
> + */
> +static inline unsigned int twl6030_read_reg_cache(struct snd_soc_codec *codec,
> +                                               unsigned int reg)
> +{
> +       u8 *cache = codec->reg_cache;
> +
> +       if (reg >= TWL6030_CACHEREGNUM)
> +               return -EIO;
> +
> +       return cache[reg];
> +}
> +
> +/*
> + * write twl6030 register cache
> + */
> +static inline void twl6030_write_reg_cache(struct snd_soc_codec *codec,
> +                                               u8 reg, u8 value)
> +{
> +       u8 *cache = codec->reg_cache;
> +
> +       if (reg >= TWL6030_CACHEREGNUM)
> +               return;
> +       cache[reg] = value;
> +}
> +
> +/*
> + * read from twl6030 hardware register
> + */
> +static int twl6030_read(struct snd_soc_codec *codec,
> +                       unsigned int reg)
> +{
> +       u8 value;
> +
> +       if (reg >= TWL6030_CACHEREGNUM)
> +               return -EIO;
> +
> +       twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &value, reg);
> +       twl6030_write_reg_cache(codec, reg, value);


You probably want to read from the cache if the register is not
volatile. This saves a slow I2C read.


> +
> +       return value;
> +}
> +
> +/*
> + * write to the twl6030 register space
> + */
> +static int twl6030_write(struct snd_soc_codec *codec,
> +                       unsigned int reg, unsigned int value)
> +{
> +       if (reg >= TWL6030_CACHEREGNUM)
> +               return -EIO;
> +
> +       twl6030_write_reg_cache(codec, reg, value);
> +       return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value, reg);
> +}
> +
> +static void twl6030_init_vio_regs(struct snd_soc_codec *codec)
> +{
> +       u8 *cache = codec->reg_cache;
> +       int reg, i;
> +
> +       /* allow registers to be accessed by i2c */
> +       twl6030_write(codec, TWL6030_REG_ACCCTL, cache[TWL6030_REG_ACCCTL]);
> +
> +       for (i = 0; i < TWL6030_VIOREGNUM; i++) {
> +               reg = twl6030_vio_reg[i];
> +               /* skip read-only registers (ASICID, ASICREV, STATUS) */
> +               if ((reg == TWL6030_REG_ASICID) ||
> +                   (reg == TWL6030_REG_ASICREV) ||
> +                   (reg == TWL6030_REG_STATUS))
> +                       continue;
> +               twl6030_write(codec, reg, cache[reg]);
> +       }
> +}
> +
> +static void twl6030_init_vdd_regs(struct snd_soc_codec *codec)
> +{
> +       u8 *cache = codec->reg_cache;
> +       int reg, i;
> +
> +       for (i = 0; i < TWL6030_VDDREGNUM; i++) {
> +               reg = twl6030_vdd_reg[i];
> +               twl6030_write(codec, reg, cache[reg]);
> +       }
> +}
> +

Are these two functions writing the default codec register values to the
CODEC or are these non default (i.e. reset) values. If they are reset
values is it not better to just issue the reset (and save the slow I2C
writes) ?

> +/*
> + * MICATT volume control:
> + * from -6 to 0 dB in 6 dB steps
> + */
> +static DECLARE_TLV_DB_SCALE(mic_preamp_tlv, -600, 600, 0);
> +
> +/*
> + * MICGAIN volume control:
> + * from 6 to 30 dB in 6 dB steps
> + */
> +static DECLARE_TLV_DB_SCALE(mic_amp_tlv, 600, 600, 0);
> +
> +/*
> + * HSGAIN volume control:
> + * from -30 to 0 dB in 2 dB steps
> + */
> +static DECLARE_TLV_DB_SCALE(hs_tlv, -3000, 200, 0);
> +
> +/*
> + * HFGAIN volume control:
> + * from -52 to 6 dB in 2 dB steps
> + */
> +static DECLARE_TLV_DB_SCALE(hf_tlv, -5200, 200, 0);
> +
> +/* Left analog microphone selection */
> +static const char *twl6030_amicl_texts[] =
> +       {"Headset Mic", "Main Mic", "Aux/FM Left", "Off"};
> +
> +/* Right analog microphone selection */
> +static const char *twl6030_amicr_texts[] =
> +       {"Headset Mic", "Sub Mic", "Aux/FM Right", "Off"};
> +
> +static const struct soc_enum twl6030_enum[] = {
> +       SOC_ENUM_SINGLE(TWL6030_REG_MICLCTL, 3, 3, twl6030_amicl_texts),
> +       SOC_ENUM_SINGLE(TWL6030_REG_MICRCTL, 3, 3, twl6030_amicr_texts),
> +};
> +
> +static const struct snd_kcontrol_new amicl_control =
> +       SOC_DAPM_ENUM("Route", twl6030_enum[0]);
> +
> +static const struct snd_kcontrol_new amicr_control =
> +       SOC_DAPM_ENUM("Route", twl6030_enum[1]);
> +
> +/* Headset DAC playback switches */
> +static const struct snd_kcontrol_new hsdacl_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSLCTL, 5, 1, 0);
> +
> +static const struct snd_kcontrol_new hsdacr_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSRCTL, 5, 1, 0);
> +
> +/* Handsfree DAC playback switches */
> +static const struct snd_kcontrol_new hfdacl_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFLCTL, 2, 1, 0);
> +
> +static const struct snd_kcontrol_new hfdacr_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFRCTL, 2, 1, 0);
> +
> +/* Headset driver switches */
> +static const struct snd_kcontrol_new hsl_driver_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSLCTL, 2, 1, 0);
> +
> +static const struct snd_kcontrol_new hsr_driver_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HSRCTL, 2, 1, 0);
> +
> +/* Handsfree driver switches */
> +static const struct snd_kcontrol_new hfl_driver_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFLCTL, 4, 1, 0);
> +
> +static const struct snd_kcontrol_new hfr_driver_switch_controls =
> +       SOC_DAPM_SINGLE("Switch", TWL6030_REG_HFRCTL, 4, 1, 0);
> +
> +static const struct snd_kcontrol_new twl6030_snd_controls[] = {
> +       /* Capture gains */
> +       SOC_DOUBLE_TLV("Capture Preamplifier Volume",
> +               TWL6030_REG_MICGAIN, 6, 7, 1, 1, mic_preamp_tlv),
> +       SOC_DOUBLE_TLV("Capture Volume",
> +               TWL6030_REG_MICGAIN, 0, 3, 4, 0, mic_amp_tlv),
> +
> +       /* Playback gains */
> +       SOC_DOUBLE_TLV("Headset Playback Volume",
> +               TWL6030_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
> +       SOC_DOUBLE_R_TLV("Handsfree Playback Volume",
> +               TWL6030_REG_HFLGAIN, TWL6030_REG_HFRGAIN, 0, 0x1D, 1, hf_tlv),
> +
> +};
> +
> +static const struct snd_soc_dapm_widget twl6030_dapm_widgets[] = {
> +       /* Inputs */
> +       SND_SOC_DAPM_INPUT("MAINMIC"),
> +       SND_SOC_DAPM_INPUT("HSMIC"),
> +       SND_SOC_DAPM_INPUT("SUBMIC"),
> +       SND_SOC_DAPM_INPUT("AFML"),
> +       SND_SOC_DAPM_INPUT("AFMR"),
> +
> +       /* Outputs */
> +       SND_SOC_DAPM_OUTPUT("HSOL"),
> +       SND_SOC_DAPM_OUTPUT("HSOR"),
> +       SND_SOC_DAPM_OUTPUT("HFL"),
> +       SND_SOC_DAPM_OUTPUT("HFR"),
> +
> +       /* Analog input muxes for the capture amplifiers */
> +       SND_SOC_DAPM_MUX("Analog Left Capture Route",
> +                       SND_SOC_NOPM, 0, 0, &amicl_control),
> +       SND_SOC_DAPM_MUX("Analog Right Capture Route",
> +                       SND_SOC_NOPM, 0, 0, &amicr_control),
> +
> +       /* Analog capture PGAs */
> +       SND_SOC_DAPM_PGA("MicAmpL",
> +                       TWL6030_REG_MICLCTL, 0, 0, NULL, 0),
> +       SND_SOC_DAPM_PGA("MicAmpR",
> +                       TWL6030_REG_MICRCTL, 0, 0, NULL, 0),
> +
> +       /* ADCs */
> +       SND_SOC_DAPM_ADC("ADC Left", "Left Front Capture",
> +                       TWL6030_REG_MICLCTL, 2, 0),
> +       SND_SOC_DAPM_ADC("ADC Right", "Right Front Capture",
> +                       TWL6030_REG_MICRCTL, 2, 0),
> +
> +       /* Microphone bias */
> +       SND_SOC_DAPM_MICBIAS("Headset Mic Bias",
> +                       TWL6030_REG_AMICBCTL, 0, 0),
> +       SND_SOC_DAPM_MICBIAS("Main Mic Bias",
> +                       TWL6030_REG_AMICBCTL, 4, 0),
> +       SND_SOC_DAPM_MICBIAS("Digital Mic1 Bias",
> +                       TWL6030_REG_DMICBCTL, 0, 0),
> +       SND_SOC_DAPM_MICBIAS("Digital Mic2 Bias",
> +                       TWL6030_REG_DMICBCTL, 4, 0),
> +
> +       /* DACs */
> +       SND_SOC_DAPM_DAC("HSDAC Left", "Headset Playback",
> +                       TWL6030_REG_HSLCTL, 0, 0),
> +       SND_SOC_DAPM_DAC("HSDAC Right", "Headset Playback",
> +                       TWL6030_REG_HSRCTL, 0, 0),
> +       SND_SOC_DAPM_DAC("HFDAC Left", "Handsfree Playback",
> +                       TWL6030_REG_HFLCTL, 0, 0),
> +       SND_SOC_DAPM_DAC("HFDAC Right", "Handsfree Playback",
> +                       TWL6030_REG_HFRCTL, 0, 0),
> +
> +       /* Analog playback switches */
> +       SND_SOC_DAPM_SWITCH("HSDAC Left Playback",
> +                       SND_SOC_NOPM, 0, 0, &hsdacl_switch_controls),
> +       SND_SOC_DAPM_SWITCH("HSDAC Right Playback",
> +                       SND_SOC_NOPM, 0, 0, &hsdacr_switch_controls),
> +       SND_SOC_DAPM_SWITCH("HFDAC Left Playback",
> +                       SND_SOC_NOPM, 0, 0, &hfdacl_switch_controls),
> +       SND_SOC_DAPM_SWITCH("HFDAC Right Playback",
> +                       SND_SOC_NOPM, 0, 0, &hfdacr_switch_controls),
> +
> +       SND_SOC_DAPM_SWITCH("Headset Left Driver",
> +                       SND_SOC_NOPM, 0, 0, &hsl_driver_switch_controls),
> +       SND_SOC_DAPM_SWITCH("Headset Right Driver",
> +                       SND_SOC_NOPM, 0, 0, &hsr_driver_switch_controls),
> +       SND_SOC_DAPM_SWITCH("Handsfree Left Driver",
> +                       SND_SOC_NOPM, 0, 0, &hfl_driver_switch_controls),
> +       SND_SOC_DAPM_SWITCH("Handsfree Right Driver",
> +                       SND_SOC_NOPM, 0, 0, &hfr_driver_switch_controls),
> +
> +       /* Analog playback PGAs */
> +       SND_SOC_DAPM_PGA("HFDAC Left PGA",
> +                       TWL6030_REG_HFLCTL, 1, 0, NULL, 0),
> +       SND_SOC_DAPM_PGA("HFDAC Right PGA",
> +                       TWL6030_REG_HFRCTL, 1, 0, NULL, 0),
> +
> +};
> +
> +static const struct snd_soc_dapm_route intercon[] = {
> +       /* Capture path */
> +       {"Analog Left Capture Route", "Headset Mic", "HSMIC"},
> +       {"Analog Left Capture Route", "Main Mic", "MAINMIC"},
> +       {"Analog Left Capture Route", "Aux/FM Left", "AFML"},
> +
> +       {"Analog Right Capture Route", "Headset Mic", "HSMIC"},
> +       {"Analog Right Capture Route", "Sub Mic", "SUBMIC"},
> +       {"Analog Right Capture Route", "Aux/FM Right", "AFMR"},
> +
> +       {"MicAmpL", NULL, "Analog Left Capture Route"},
> +       {"MicAmpR", NULL, "Analog Right Capture Route"},
> +
> +       {"ADC Left", NULL, "MicAmpL"},
> +       {"ADC Right", NULL, "MicAmpR"},
> +
> +       /* Headset playback path */
> +       {"HSDAC Left Playback", "Switch", "HSDAC Left"},
> +       {"HSDAC Right Playback", "Switch", "HSDAC Right"},
> +
> +       {"Headset Left Driver", "Switch", "HSDAC Left Playback"},
> +       {"Headset Right Driver", "Switch", "HSDAC Right Playback"},
> +
> +       {"HSOL", NULL, "Headset Left Driver"},
> +       {"HSOR", NULL, "Headset Right Driver"},
> +
> +       /* Handsfree playback path */
> +       {"HFDAC Left Playback", "Switch", "HFDAC Left"},
> +       {"HFDAC Right Playback", "Switch", "HFDAC Right"},
> +
> +       {"HFDAC Left PGA", NULL, "HFDAC Left Playback"},
> +       {"HFDAC Right PGA", NULL, "HFDAC Right Playback"},
> +
> +       {"Handsfree Left Driver", "Switch", "HFDAC Left PGA"},
> +       {"Handsfree Right Driver", "Switch", "HFDAC Right PGA"},
> +
> +       {"HFL", NULL, "Handsfree Left Driver"},
> +       {"HFR", NULL, "Handsfree Right Driver"},
> +};
> +
> +static int twl6030_add_widgets(struct snd_soc_codec *codec)
> +{
> +       snd_soc_dapm_new_controls(codec, twl6030_dapm_widgets,
> +                                ARRAY_SIZE(twl6030_dapm_widgets));
> +
> +       snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
> +
> +       snd_soc_dapm_new_widgets(codec);
> +
> +       return 0;
> +}
> +
> +static int twl6030_set_bias_level(struct snd_soc_codec *codec,
> +                               enum snd_soc_bias_level level)
> +{
> +       struct twl6030_data *priv = codec->private_data;
> +       int audpwron = priv->audpwron;
> +
> +       switch (level) {
> +       case SND_SOC_BIAS_ON:
> +       case SND_SOC_BIAS_PREPARE:
> +       case SND_SOC_BIAS_STANDBY:
> +               if (priv->codec_powered)
> +                       break;
> +
> +               if (gpio_is_valid(audpwron)) {
> +                       /* use AUDPWRON line */
> +                       gpio_set_value(audpwron, 1);
> +
> +                       /* power-up sequence latency */
> +                       mdelay(16);

This is perhaps too long for mdelay. Probably want to sleep here.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
