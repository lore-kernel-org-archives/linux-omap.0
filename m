From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 1/1] ASoC: Add drivers for the Texas Instruments
	OMAP processors
Date: Mon, 21 Apr 2008 11:16:14 -0700
Message-ID: <20080421181614.GZ12099@atomide.com>
References: <1207300948-11598-1-git-send-email-jarkko.nikula@nokia.com> <1207300948-11598-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55867 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbYDUSQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 14:16:19 -0400
Content-Disposition: inline
In-Reply-To: <1207300948-11598-2-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

Hi,

Just one comment on using the platform_data below.

* Jarkko Nikula <jarkko.nikula@nokia.com> [080404 02:22]:
> Add common OMAP ASoC drivers and machine driver for Nokia N810. Currently
> supported features are:
> 
> - Covers OMAPs from 1510 to 2420
> - Common DMA driver
> - DAI link driver using McBSP port in I2S mode
> - Basic machine driver for Nokia N810
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  sound/soc/Kconfig           |    1 +
>  sound/soc/Makefile          |    2 +-
>  sound/soc/omap/Kconfig      |   19 ++
>  sound/soc/omap/Makefile     |   11 ++
>  sound/soc/omap/n810.c       |  336 +++++++++++++++++++++++++++++++++++
>  sound/soc/omap/omap-mcbsp.c |  414 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/omap/omap-mcbsp.h |   49 +++++
>  sound/soc/omap/omap-pcm.c   |  357 +++++++++++++++++++++++++++++++++++++
>  sound/soc/omap/omap-pcm.h   |   35 ++++
>  9 files changed, 1223 insertions(+), 1 deletions(-)
>  create mode 100644 sound/soc/omap/Kconfig
>  create mode 100644 sound/soc/omap/Makefile
>  create mode 100644 sound/soc/omap/n810.c
>  create mode 100644 sound/soc/omap/omap-mcbsp.c
>  create mode 100644 sound/soc/omap/omap-mcbsp.h
>  create mode 100644 sound/soc/omap/omap-pcm.c
>  create mode 100644 sound/soc/omap/omap-pcm.h
> 
> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
> index 088b084..5ad8a0d 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -34,6 +34,7 @@ source "sound/soc/au1x/Kconfig"
>  source "sound/soc/blackfin/Kconfig"
>  source "sound/soc/fsl/Kconfig"
>  source "sound/soc/davinci/Kconfig"
> +source "sound/soc/omap/Kconfig"
>  
>  # Supported codecs
>  source "sound/soc/codecs/Kconfig"
> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
> index 3e1be50..18f2c17 100644
> --- a/sound/soc/Makefile
> +++ b/sound/soc/Makefile
> @@ -1,4 +1,4 @@
>  snd-soc-core-objs := soc-core.o soc-dapm.o
>  
>  obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
> -obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ imx/ au1x/ blackfin/ fsl/ davinci/
> +obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ imx/ au1x/ blackfin/ fsl/ davinci/ omap/
> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> new file mode 100644
> index 0000000..0230d83
> --- /dev/null
> +++ b/sound/soc/omap/Kconfig
> @@ -0,0 +1,19 @@
> +menu "SoC Audio for the Texas Instruments OMAP"
> +
> +config SND_OMAP_SOC
> +	tristate "SoC Audio for the Texas Instruments OMAP chips"
> +	depends on ARCH_OMAP && SND_SOC
> +
> +config SND_OMAP_SOC_MCBSP
> +	tristate
> +	select OMAP_MCBSP
> +
> +config SND_OMAP_SOC_N810
> +	tristate "SoC Audio support for Nokia N810"
> +	depends on SND_OMAP_SOC && MACH_NOKIA_N810
> +	select SND_OMAP_SOC_MCBSP
> +	select SND_SOC_TLV320AIC3X
> +	help
> +	  Say Y if you want to add support for SoC audio on Nokia N810.
> +
> +endmenu
> diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> new file mode 100644
> index 0000000..d8d8d58
> --- /dev/null
> +++ b/sound/soc/omap/Makefile
> @@ -0,0 +1,11 @@
> +# OMAP Platform Support
> +snd-soc-omap-objs := omap-pcm.o
> +snd-soc-omap-mcbsp-objs := omap-mcbsp.o
> +
> +obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
> +obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
> +
> +# OMAP Machine Support
> +snd-soc-n810-objs := n810.o
> +
> +obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
> diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
> new file mode 100644
> index 0000000..83b1eb4
> --- /dev/null
> +++ b/sound/soc/omap/n810.c
> @@ -0,0 +1,336 @@
> +/*
> + * n810.c  --  SoC audio for Nokia N810
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
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
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/arch/hardware.h>
> +#include <asm/arch/gpio.h>
> +#include <asm/arch/mcbsp.h>
> +
> +#include "omap-mcbsp.h"
> +#include "omap-pcm.h"
> +#include "../codecs/tlv320aic3x.h"
> +
> +#define RX44_HEADSET_AMP_GPIO	10
> +#define RX44_SPEAKER_AMP_GPIO	101
> +
> +static struct clk *sys_clkout2;
> +static struct clk *sys_clkout2_src;
> +static struct clk *func96m_clk;
> +
> +static int n810_spk_func;
> +static int n810_jack_func;
> +
> +static void n810_ext_control(struct snd_soc_codec *codec)
> +{
> +	snd_soc_dapm_set_endpoint(codec, "Ext Spk", n810_spk_func);
> +	snd_soc_dapm_set_endpoint(codec, "Headphone Jack", n810_jack_func);
> +
> +	snd_soc_dapm_sync_endpoints(codec);
> +}
> +
> +static int n810_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->socdev->codec;
> +
> +	n810_ext_control(codec);
> +	return clk_enable(sys_clkout2);
> +}
> +
> +static void n810_shutdown(struct snd_pcm_substream *substream)
> +{
> +	clk_disable(sys_clkout2);
> +}
> +
> +static int n810_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
> +	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
> +	int err;
> +
> +	/* Set codec DAI configuration */
> +	err = codec_dai->dai_ops.set_fmt(codec_dai,
> +					 SND_SOC_DAIFMT_I2S |
> +					 SND_SOC_DAIFMT_NB_NF |
> +					 SND_SOC_DAIFMT_CBM_CFM);
> +	if (err < 0)
> +		return err;
> +
> +	/* Set cpu DAI configuration */
> +	err = cpu_dai->dai_ops.set_fmt(cpu_dai,
> +				       SND_SOC_DAIFMT_I2S |
> +				       SND_SOC_DAIFMT_NB_NF |
> +				       SND_SOC_DAIFMT_CBM_CFM);
> +	if (err < 0)
> +		return err;
> +
> +	/* Set the codec system clock for DAC and ADC */
> +	err = codec_dai->dai_ops.set_sysclk(codec_dai, 0, 12000000,
> +					    SND_SOC_CLOCK_IN);
> +
> +	return err;
> +}
> +
> +static struct snd_soc_ops n810_ops = {
> +	.startup = n810_startup,
> +	.hw_params = n810_hw_params,
> +	.shutdown = n810_shutdown,
> +};
> +
> +static int n810_get_spk(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	ucontrol->value.integer.value[0] = n810_spk_func;
> +
> +	return 0;
> +}
> +
> +static int n810_set_spk(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
> +
> +	if (n810_spk_func == ucontrol->value.integer.value[0])
> +		return 0;
> +
> +	n810_spk_func = ucontrol->value.integer.value[0];
> +	n810_ext_control(codec);
> +
> +	return 1;
> +}
> +
> +static int n810_get_jack(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	ucontrol->value.integer.value[0] = n810_jack_func;
> +
> +	return 0;
> +}
> +
> +static int n810_set_jack(struct snd_kcontrol *kcontrol,
> +			 struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
> +
> +	if (n810_jack_func == ucontrol->value.integer.value[0])
> +		return 0;
> +
> +	n810_jack_func = ucontrol->value.integer.value[0];
> +	n810_ext_control(codec);
> +
> +	return 1;
> +}
> +
> +static int n810_spk_event(struct snd_soc_dapm_widget *w,
> +			  struct snd_kcontrol *k, int event)
> +{
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		omap_set_gpio_dataout(RX44_SPEAKER_AMP_GPIO, 1);
> +	else
> +		omap_set_gpio_dataout(RX44_SPEAKER_AMP_GPIO, 0);
> +
> +	return 0;
> +}
> +
> +static int n810_jack_event(struct snd_soc_dapm_widget *w,
> +			   struct snd_kcontrol *k, int event)
> +{
> +	if (SND_SOC_DAPM_EVENT_ON(event))
> +		omap_set_gpio_dataout(RX44_HEADSET_AMP_GPIO, 1);
> +	else
> +		omap_set_gpio_dataout(RX44_HEADSET_AMP_GPIO, 0);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_dapm_widget aic33_dapm_widgets[] = {
> +	SND_SOC_DAPM_SPK("Ext Spk", n810_spk_event),
> +	SND_SOC_DAPM_HP("Headphone Jack", n810_jack_event),
> +};
> +
> +static const char *audio_map[][3] = {
> +	{"Headphone Jack", NULL, "HPLOUT"},
> +	{"Headphone Jack", NULL, "HPROUT"},
> +
> +	{"Ext Spk", NULL, "LLOUT"},
> +	{"Ext Spk", NULL, "RLOUT"},
> +};
> +
> +static const char *spk_function[] = {"Off", "On"};
> +static const char *jack_function[] = {"Off", "Headphone"};
> +static const struct soc_enum n810_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(2, spk_function),
> +	SOC_ENUM_SINGLE_EXT(3, jack_function),
> +};
> +
> +static const struct snd_kcontrol_new aic33_n810_controls[] = {
> +	SOC_ENUM_EXT("Speaker Function", n810_enum[0],
> +		     n810_get_spk, n810_set_spk),
> +	SOC_ENUM_EXT("Jack Function", n810_enum[1],
> +		     n810_get_jack, n810_set_jack),
> +};
> +
> +static int n810_aic33_init(struct snd_soc_codec *codec)
> +{
> +	int i, err;
> +
> +	/* Not connected */
> +	snd_soc_dapm_set_endpoint(codec, "MONO_LOUT", 0);
> +	snd_soc_dapm_set_endpoint(codec, "HPLCOM", 0);
> +	snd_soc_dapm_set_endpoint(codec, "HPRCOM", 0);
> +
> +	/* Add N810 specific controls */
> +	for (i = 0; i < ARRAY_SIZE(aic33_n810_controls); i++) {
> +		err = snd_ctl_add(codec->card,
> +			snd_soc_cnew(&aic33_n810_controls[i], codec, NULL));
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	/* Add N810 specific widgets */
> +	for (i = 0; i < ARRAY_SIZE(aic33_dapm_widgets); i++)
> +		snd_soc_dapm_new_control(codec, &aic33_dapm_widgets[i]);
> +
> +	/* Set up N810 specific audio path audio_map */
> +	for (i = 0; i < ARRAY_SIZE(audio_map); i++)
> +		snd_soc_dapm_connect_input(codec, audio_map[i][0],
> +			audio_map[i][1], audio_map[i][2]);
> +
> +	snd_soc_dapm_sync_endpoints(codec);
> +
> +	return 0;
> +}
> +
> +/* Digital audio interface glue - connects codec <--> CPU */
> +static struct snd_soc_dai_link n810_dai = {
> +	.name = "TLV320AIC33",
> +	.stream_name = "AIC33",
> +	.cpu_dai = &omap_mcbsp_dai[0],
> +	.codec_dai = &aic3x_dai,
> +	.init = n810_aic33_init,
> +	.ops = &n810_ops,
> +};
> +
> +/* Audio machine driver */
> +static struct snd_soc_machine snd_soc_machine_n810 = {
> +	.name = "N810",
> +	.dai_link = &n810_dai,
> +	.num_links = 1,
> +};
> +
> +/* Audio private data */
> +static struct aic3x_setup_data n810_aic33_setup = {
> +	.i2c_address = 0x18,
> +};
> +
> +/* Audio subsystem */
> +static struct snd_soc_device n810_snd_devdata = {
> +	.machine = &snd_soc_machine_n810,
> +	.platform = &omap_soc_platform,
> +	.codec_dev = &soc_codec_dev_aic3x,
> +	.codec_data = &n810_aic33_setup,
> +};
> +
> +static struct platform_device *n810_snd_device;
> +
> +static int __init n810_soc_init(void)
> +{
> +	int err;
> +	struct device *dev;
> +
> +	if (!machine_is_nokia_n810())
> +		return -ENODEV;
> +
> +	n810_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!n810_snd_device)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(n810_snd_device, &n810_snd_devdata);
> +	n810_snd_devdata.dev = &n810_snd_device->dev;
> +	*(unsigned int *)n810_dai.cpu_dai->private_data = 1; /* McBSP2 */
> +	err = platform_device_add(n810_snd_device);
> +	if (err)
> +		goto err1;
> +
> +	dev = &n810_snd_device->dev;
> +
> +	sys_clkout2_src = clk_get(dev, "sys_clkout2_src");
> +	if (IS_ERR(sys_clkout2_src)) {
> +		dev_err(dev, "Could not get sys_clkout2_src clock\n");
> +		return -ENODEV;
> +	}
> +	sys_clkout2 = clk_get(dev, "sys_clkout2");
> +	if (IS_ERR(sys_clkout2)) {
> +		dev_err(dev, "Could not get sys_clkout2\n");
> +		goto err1;
> +	}
> +	/*
> +	 * Configure 12 MHz output on SYS_CLKOUT2. Therefore we must use
> +	 * 96 MHz as its parent in order to get 12 MHz
> +	 */
> +	func96m_clk = clk_get(dev, "func_96m_ck");
> +	if (IS_ERR(func96m_clk)) {
> +		dev_err(dev, "Could not get func 96M clock\n");
> +		goto err2;
> +	}
> +	clk_set_parent(sys_clkout2_src, func96m_clk);
> +	clk_set_rate(sys_clkout2, 12000000);
> +
> +	if (omap_request_gpio(RX44_HEADSET_AMP_GPIO) < 0)
> +		BUG();
> +	if (omap_request_gpio(RX44_SPEAKER_AMP_GPIO) < 0)
> +		BUG();
> +	omap_set_gpio_direction(RX44_HEADSET_AMP_GPIO, 0);
> +	omap_set_gpio_direction(RX44_SPEAKER_AMP_GPIO, 0);
> +
> +	return 0;
> +err2:
> +	clk_put(sys_clkout2);
> +	platform_device_del(n810_snd_device);
> +err1:
> +	platform_device_put(n810_snd_device);
> +
> +	return err;
> +
> +}

The platform_device_register() should be done in board-*.c files.

This way you will know which board has this snd_device when
compiling in support for multiple boards into the same kernel,
and you don't need to use machine_is_some_arm() in drivers.

You probably also will want to pass the struct clk * in the
platform_data so the driver can then do clk_enable/disable as needed.


> +
> +static void __exit n810_soc_exit(void)
> +{
> +	platform_device_unregister(n810_snd_device);
> +}
> +
> +module_init(n810_soc_init);
> +module_exit(n810_soc_exit);
> +
> +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
> +MODULE_DESCRIPTION("ALSA SoC Nokia N810");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> new file mode 100644
> index 0000000..40d87e6
> --- /dev/null
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -0,0 +1,414 @@
> +/*
> + * omap-mcbsp.c  --  OMAP ALSA SoC DAI driver using McBSP port
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
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
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +
> +#include <asm/arch/control.h>
> +#include <asm/arch/dma.h>
> +#include <asm/arch/mcbsp.h>
> +#include "omap-mcbsp.h"
> +#include "omap-pcm.h"
> +
> +#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_44100 | \
> +				 SNDRV_PCM_RATE_48000 | \
> +				 SNDRV_PCM_RATE_KNOT)
> +
> +struct omap_mcbsp_data {
> +	unsigned int			bus_id;
> +	struct omap_mcbsp_reg_cfg	regs;
> +	/*
> +	 * Flags indicating is the bus already activated and configured by
> +	 * another substream
> +	 */
> +	int				active;
> +	int				configured;
> +};
> +
> +#define to_mcbsp(priv)	container_of((priv), struct omap_mcbsp_data, bus_id)
> +
> +static struct omap_mcbsp_data mcbsp_data[NUM_LINKS];
> +
> +/*
> + * Stream DMA parameters. DMA request line and port address are set runtime
> + * since they are different between OMAP1 and later OMAPs
> + */
> +static struct omap_pcm_dma_data omap_mcbsp_dai_dma_params[NUM_LINKS][2] = {
> +{
> +	{ .name		= "I2S PCM Stereo out", },
> +	{ .name		= "I2S PCM Stereo in", },
> +},
> +};
> +
> +#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
> +static const int omap1_dma_reqs[][2] = {
> +	{ OMAP_DMA_MCBSP1_TX, OMAP_DMA_MCBSP1_RX },
> +	{ OMAP_DMA_MCBSP2_TX, OMAP_DMA_MCBSP2_RX },
> +	{ OMAP_DMA_MCBSP3_TX, OMAP_DMA_MCBSP3_RX },
> +};
> +static const unsigned long omap1_mcbsp_port[][2] = {
> +	{ OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
> +	  OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
> +	{ OMAP1510_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1,
> +	  OMAP1510_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1 },
> +	{ OMAP1510_MCBSP3_BASE + OMAP_MCBSP_REG_DXR1,
> +	  OMAP1510_MCBSP3_BASE + OMAP_MCBSP_REG_DRR1 },
> +};
> +#else
> +static const int omap1_dma_reqs[][2] = {};
> +static const unsigned long omap1_mcbsp_port[][2] = {};
> +#endif
> +#if defined(CONFIG_ARCH_OMAP2420)
> +static const int omap2420_dma_reqs[][2] = {
> +	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
> +	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },
> +};
> +static const unsigned long omap2420_mcbsp_port[][2] = {
> +	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
> +	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
> +	{ OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1,
> +	  OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1 },
> +};
> +#else
> +static const int omap2420_dma_reqs[][2] = {};
> +static const unsigned long omap2420_mcbsp_port[][2] = {};
> +#endif
> +
> +static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +	int err = 0;
> +
> +	if (!cpu_dai->active)
> +		err = omap_mcbsp_request(mcbsp_data->bus_id);
> +
> +	return err;
> +}
> +
> +static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +
> +	if (!cpu_dai->active) {
> +		omap_mcbsp_free(mcbsp_data->bus_id);
> +		mcbsp_data->configured = 0;
> +	}
> +}
> +
> +static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		if (!mcbsp_data->active++)
> +			omap_mcbsp_start(mcbsp_data->bus_id);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		if (!--mcbsp_data->active)
> +			omap_mcbsp_stop(mcbsp_data->bus_id);
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
> +	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
> +	unsigned long port;
> +
> +	if (cpu_class_is_omap1()) {
> +		dma = omap1_dma_reqs[bus_id][substream->stream];
> +		port = omap1_mcbsp_port[bus_id][substream->stream];
> +	} else if (cpu_is_omap2420()) {
> +		dma = omap2420_dma_reqs[bus_id][substream->stream];
> +		port = omap2420_mcbsp_port[bus_id][substream->stream];
> +	} else {
> +		/*
> +		 * TODO: Add support for 2430 and 3430
> +		 */
> +		return -ENODEV;
> +	}
> +	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
> +	omap_mcbsp_dai_dma_params[id][substream->stream].port_addr = port;
> +	cpu_dai->dma_data = &omap_mcbsp_dai_dma_params[id][substream->stream];
> +
> +	if (mcbsp_data->configured) {
> +		/* McBSP already configured by another stream */
> +		return 0;
> +	}
> +
> +	switch (params_channels(params)) {
> +	case 2:
> +		/* Set 1 word per (McBPSP) frame and use dual-phase frames */
> +		regs->rcr2	|= RFRLEN2(1 - 1) | RPHASE;
> +		regs->rcr1	|= RFRLEN1(1 - 1);
> +		regs->xcr2	|= XFRLEN2(1 - 1) | XPHASE;
> +		regs->xcr1	|= XFRLEN1(1 - 1);
> +		break;
> +	default:
> +		/* Unsupported number of channels */
> +		return -EINVAL;
> +	}
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		/* Set word lengths */
> +		regs->rcr2	|= RWDLEN2(OMAP_MCBSP_WORD_16);
> +		regs->rcr1	|= RWDLEN1(OMAP_MCBSP_WORD_16);
> +		regs->xcr2	|= XWDLEN2(OMAP_MCBSP_WORD_16);
> +		regs->xcr1	|= XWDLEN1(OMAP_MCBSP_WORD_16);
> +		/* Set FS period and length in terms of bit clock periods */
> +		regs->srgr2	|= FPER(16 * 2 - 1);
> +		regs->srgr1	|= FWID(16 - 1);
> +		break;
> +	default:
> +		/* Unsupported PCM format */
> +		return -EINVAL;
> +	}
> +
> +	omap_mcbsp_config(bus_id, &mcbsp_data->regs);
> +	mcbsp_data->configured = 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * This must be called before _set_clkdiv and _set_sysclk since McBSP register
> + * cache is initialized here
> + */
> +static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
> +				      unsigned int fmt)
> +{
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
> +
> +	if (mcbsp_data->configured)
> +		return 0;
> +
> +	memset(regs, 0, sizeof(*regs));
> +	/* Generic McBSP register settings */
> +	regs->spcr2	|= XINTM(3) | FREE;
> +	regs->spcr1	|= RINTM(3);
> +	regs->rcr2	|= RFIG;
> +	regs->xcr2	|= XFIG;
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		/* 1-bit data delay */
> +		regs->rcr2	|= RDATDLY(1);
> +		regs->xcr2	|= XDATDLY(1);
> +		break;
> +	default:
> +		/* Unsupported data format */
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		/* McBSP master. Set FS and bit clocks as outputs */
> +		regs->pcr0	|= FSXM | FSRM |
> +				   CLKXM | CLKRM;
> +		/* Sample rate generator drives the FS */
> +		regs->srgr2	|= FSGM;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		/* McBSP slave */
> +		break;
> +	default:
> +		/* Unsupported master/slave configuration */
> +		return -EINVAL;
> +	}
> +
> +	/* Set bit clock (CLKX/CLKR) and FS polarities */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		/*
> +		 * Normal BCLK + FS.
> +		 * FS active low. TX data driven on falling edge of bit clock
> +		 * and RX data sampled on rising edge of bit clock.
> +		 */
> +		regs->pcr0	|= FSXP | FSRP |
> +				   CLKXP | CLKRP;
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		regs->pcr0	|= CLKXP | CLKRP;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		regs->pcr0	|= FSXP | FSRP;
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
> +				     int div_id, int div)
> +{
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
> +
> +	if (div_id != OMAP_MCBSP_CLKGDV)
> +		return -ENODEV;
> +
> +	regs->srgr1	|= CLKGDV(div - 1);
> +
> +	return 0;
> +}
> +
> +static int omap_mcbsp_dai_set_clks_src(struct omap_mcbsp_data *mcbsp_data,
> +				       int clk_id)
> +{
> +	int sel_bit;
> +	u16 reg;
> +
> +	if (cpu_class_is_omap1()) {
> +		/* OMAP1's can use only external source clock */
> +		if (unlikely(clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK))
> +			return -EINVAL;
> +		else
> +			return 0;
> +	}
> +
> +	switch (mcbsp_data->bus_id) {
> +	case 0:
> +		reg = OMAP2_CONTROL_DEVCONF0;
> +		sel_bit = 2;
> +		break;
> +	case 1:
> +		reg = OMAP2_CONTROL_DEVCONF0;
> +		sel_bit = 6;
> +		break;
> +	/* TODO: Support for ports 3 - 5 in OMAP2430 and OMAP34xx */
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (cpu_class_is_omap2()) {
> +		if (clk_id == OMAP_MCBSP_SYSCLK_CLKS_FCLK) {
> +			omap_ctrl_writel(omap_ctrl_readl(reg) &
> +					 ~(1 << sel_bit), reg);
> +		} else {
> +			omap_ctrl_writel(omap_ctrl_readl(reg) |
> +					 (1 << sel_bit), reg);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
> +					 int clk_id, unsigned int freq,
> +					 int dir)
> +{
> +	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> +	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
> +	int err = 0;
> +
> +	switch (clk_id) {
> +	case OMAP_MCBSP_SYSCLK_CLK:
> +		regs->srgr2	|= CLKSM;
> +		break;
> +	case OMAP_MCBSP_SYSCLK_CLKS_FCLK:
> +	case OMAP_MCBSP_SYSCLK_CLKS_EXT:
> +		err = omap_mcbsp_dai_set_clks_src(mcbsp_data, clk_id);
> +		break;
> +
> +	case OMAP_MCBSP_SYSCLK_CLKX_EXT:
> +		regs->srgr2	|= CLKSM;
> +	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
> +		regs->pcr0	|= SCLKME;
> +		break;
> +	default:
> +		err = -ENODEV;
> +	}
> +
> +	return err;
> +}
> +
> +struct snd_soc_cpu_dai omap_mcbsp_dai[NUM_LINKS] = {
> +{
> +	.name = "omap-mcbsp-dai",
> +	.id = 0,
> +	.type = SND_SOC_DAI_I2S,
> +	.playback = {
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = OMAP_MCBSP_RATES,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +	},
> +	.capture = {
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rates = OMAP_MCBSP_RATES,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +	},
> +	.ops = {
> +		.startup = omap_mcbsp_dai_startup,
> +		.shutdown = omap_mcbsp_dai_shutdown,
> +		.trigger = omap_mcbsp_dai_trigger,
> +		.hw_params = omap_mcbsp_dai_hw_params,
> +	},
> +	.dai_ops = {
> +		.set_fmt = omap_mcbsp_dai_set_dai_fmt,
> +		.set_clkdiv = omap_mcbsp_dai_set_clkdiv,
> +		.set_sysclk = omap_mcbsp_dai_set_dai_sysclk,
> +	},
> +	.private_data = &mcbsp_data[0].bus_id,
> +},
> +};
> +EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
> +
> +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
> +MODULE_DESCRIPTION("OMAP I2S SoC Interface");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
> new file mode 100644
> index 0000000..9965fd4
> --- /dev/null
> +++ b/sound/soc/omap/omap-mcbsp.h
> @@ -0,0 +1,49 @@
> +/*
> + * omap-mcbsp.h
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
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
> +#ifndef __OMAP_I2S_H__
> +#define __OMAP_I2S_H__
> +
> +/* Source clocks for McBSP sample rate generator */
> +enum omap_mcbsp_clksrg_clk {
> +	OMAP_MCBSP_SYSCLK_CLKS_FCLK,	/* Internal FCLK */
> +	OMAP_MCBSP_SYSCLK_CLKS_EXT,	/* External CLKS pin */
> +	OMAP_MCBSP_SYSCLK_CLK,		/* Internal ICLK */
> +	OMAP_MCBSP_SYSCLK_CLKX_EXT,	/* External CLKX pin */
> +	OMAP_MCBSP_SYSCLK_CLKR_EXT,	/* External CLKR pin */
> +};
> +
> +/* McBSP dividers */
> +enum omap_mcbsp_div {
> +	OMAP_MCBSP_CLKGDV,		/* Sample rate generator divider */
> +};
> +
> +/*
> + * REVISIT: Preparation for the ASoC v2. Let the number of available links to
> + * be same than number of McBSP ports found in OMAP(s) we are compiling for.
> + */
> +#define NUM_LINKS	1
> +
> +extern struct snd_soc_cpu_dai omap_mcbsp_dai[NUM_LINKS];
> +
> +#endif
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> new file mode 100644
> index 0000000..6237020
> --- /dev/null
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -0,0 +1,357 @@
> +/*
> + * omap-pcm.c  --  ALSA PCM interface for the OMAP SoC
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
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
> +#include <linux/dma-mapping.h>
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include <asm/arch/dma.h>
> +#include "omap-pcm.h"
> +
> +static const struct snd_pcm_hardware omap_pcm_hardware = {
> +	.info			= SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_INTERLEAVED |
> +				  SNDRV_PCM_INFO_PAUSE |
> +				  SNDRV_PCM_INFO_RESUME,
> +	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
> +	.period_bytes_min	= 32,
> +	.period_bytes_max	= 64 * 1024,
> +	.periods_min		= 2,
> +	.periods_max		= 255,
> +	.buffer_bytes_max	= 128 * 1024,
> +};
> +
> +struct omap_runtime_data {
> +	spinlock_t			lock;
> +	struct omap_pcm_dma_data	*dma_data;
> +	int				dma_ch;
> +	int				period_index;
> +};
> +
> +static void omap_pcm_dma_irq(int ch, u16 stat, void *data)
> +{
> +	struct snd_pcm_substream *substream = data;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct omap_runtime_data *prtd = runtime->private_data;
> +	unsigned long flags;
> +
> +	if (cpu_is_omap1510()) {
> +		/*
> +		 * OMAP1510 doesn't support DMA chaining so have to restart
> +		 * the transfer after all periods are transferred
> +		 */
> +		spin_lock_irqsave(&prtd->lock, flags);
> +		if (prtd->period_index >= 0) {
> +			if (++prtd->period_index == runtime->periods) {
> +				prtd->period_index = 0;
> +				omap_start_dma(prtd->dma_ch);
> +			}
> +		}
> +		spin_unlock_irqrestore(&prtd->lock, flags);
> +	}
> +
> +	snd_pcm_period_elapsed(substream);
> +}
> +
> +/* this may get called several times by oss emulation */
> +static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
> +			      struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct omap_runtime_data *prtd = runtime->private_data;
> +	struct omap_pcm_dma_data *dma_data = rtd->dai->cpu_dai->dma_data;
> +	int err = 0;
> +
> +	if (!dma_data)
> +		return -ENODEV;
> +
> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +	runtime->dma_bytes = params_buffer_bytes(params);
> +
> +	if (prtd->dma_data)
> +		return 0;
> +	prtd->dma_data = dma_data;
> +	err = omap_request_dma(dma_data->dma_req, dma_data->name,
> +			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
> +	if (!cpu_is_omap1510()) {
> +		/*
> +		 * Link channel with itself so DMA doesn't need any
> +		 * reprogramming while looping the buffer
> +		 */
> +		omap_dma_link_lch(prtd->dma_ch, prtd->dma_ch);
> +	}
> +
> +	return err;
> +}
> +
> +static int omap_pcm_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct omap_runtime_data *prtd = runtime->private_data;
> +
> +	if (prtd->dma_data == NULL)
> +		return 0;
> +
> +	if (!cpu_is_omap1510())
> +		omap_dma_unlink_lch(prtd->dma_ch, prtd->dma_ch);
> +	omap_free_dma(prtd->dma_ch);
> +	prtd->dma_data = NULL;
> +
> +	snd_pcm_set_runtime_buffer(substream, NULL);
> +
> +	return 0;
> +}
> +
> +static int omap_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct omap_runtime_data *prtd = runtime->private_data;
> +	struct omap_pcm_dma_data *dma_data = prtd->dma_data;
> +	struct omap_dma_channel_params dma_params;
> +
> +	memset(&dma_params, 0, sizeof(dma_params));
> +	/*
> +	 * Note: Regardless of interface data formats supported by OMAP McBSP
> +	 * or EAC blocks, internal representation is always fixed 16-bit/sample
> +	 */
> +	dma_params.data_type			= OMAP_DMA_DATA_TYPE_S16;
> +	dma_params.trigger			= dma_data->dma_req;
> +	dma_params.sync_mode			= OMAP_DMA_SYNC_ELEMENT;
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		dma_params.src_amode		= OMAP_DMA_AMODE_POST_INC;
> +		dma_params.dst_amode		= OMAP_DMA_AMODE_CONSTANT;
> +		dma_params.src_or_dst_synch	= OMAP_DMA_DST_SYNC;
> +		dma_params.src_start		= runtime->dma_addr;
> +		dma_params.dst_start		= dma_data->port_addr;
> +	} else {
> +		dma_params.src_amode		= OMAP_DMA_AMODE_CONSTANT;
> +		dma_params.dst_amode		= OMAP_DMA_AMODE_POST_INC;
> +		dma_params.src_or_dst_synch	= OMAP_DMA_SRC_SYNC;
> +		dma_params.src_start		= dma_data->port_addr;
> +		dma_params.dst_start		= runtime->dma_addr;
> +	}
> +	/*
> +	 * Set DMA transfer frame size equal to ALSA period size and frame
> +	 * count as no. of ALSA periods. Then with DMA frame interrupt enabled,
> +	 * we can transfer the whole ALSA buffer with single DMA transfer but
> +	 * still can get an interrupt at each period bounary
> +	 */
> +	dma_params.elem_count	= snd_pcm_lib_period_bytes(substream) / 2;
> +	dma_params.frame_count	= runtime->periods;
> +	omap_set_dma_params(prtd->dma_ch, &dma_params);
> +
> +	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
> +
> +	return 0;
> +}
> +
> +static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct omap_runtime_data *prtd = runtime->private_data;
> +	int ret = 0;
> +
> +	spin_lock_irq(&prtd->lock);
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		prtd->period_index = 0;
> +		omap_start_dma(prtd->dma_ch);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		prtd->period_index = -1;
> +		omap_stop_dma(prtd->dma_ch);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	spin_unlock_irq(&prtd->lock);
> +
> +	return ret;
> +}
> +
> +static snd_pcm_uframes_t omap_pcm_pointer(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct omap_runtime_data *prtd = runtime->private_data;
> +	dma_addr_t ptr;
> +	snd_pcm_uframes_t offset;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		ptr = omap_get_dma_src_pos(prtd->dma_ch);
> +	else
> +		ptr = omap_get_dma_dst_pos(prtd->dma_ch);
> +
> +	offset = bytes_to_frames(runtime, ptr - runtime->dma_addr);
> +	if (offset >= runtime->buffer_size)
> +		offset = 0;
> +
> +	return offset;
> +}
> +
> +static int omap_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct omap_runtime_data *prtd;
> +	int ret;
> +
> +	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
> +
> +	/* Ensure that buffer size is a multiple of period size */
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		goto out;
> +
> +	prtd = kzalloc(sizeof(prtd), GFP_KERNEL);
> +	if (prtd == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	spin_lock_init(&prtd->lock);
> +	runtime->private_data = prtd;
> +
> +out:
> +	return ret;
> +}
> +
> +static int omap_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	kfree(runtime->private_data);
> +	return 0;
> +}
> +
> +static int omap_pcm_mmap(struct snd_pcm_substream *substream,
> +	struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +				     runtime->dma_area,
> +				     runtime->dma_addr,
> +				     runtime->dma_bytes);
> +}
> +
> +struct snd_pcm_ops omap_pcm_ops = {
> +	.open		= omap_pcm_open,
> +	.close		= omap_pcm_close,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +	.hw_params	= omap_pcm_hw_params,
> +	.hw_free	= omap_pcm_hw_free,
> +	.prepare	= omap_pcm_prepare,
> +	.trigger	= omap_pcm_trigger,
> +	.pointer	= omap_pcm_pointer,
> +	.mmap		= omap_pcm_mmap,
> +};
> +
> +static u64 omap_pcm_dmamask = DMA_BIT_MASK(32);
> +
> +static int omap_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
> +	int stream)
> +{
> +	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> +	size_t size = omap_pcm_hardware.buffer_bytes_max;
> +
> +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +	buf->dev.dev = pcm->card->dev;
> +	buf->private_data = NULL;
> +	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
> +					   &buf->addr, GFP_KERNEL);
> +	if (!buf->area)
> +		return -ENOMEM;
> +
> +	buf->bytes = size;
> +	return 0;
> +}
> +
> +static void omap_pcm_free_dma_buffers(struct snd_pcm *pcm)
> +{
> +	struct snd_pcm_substream *substream;
> +	struct snd_dma_buffer *buf;
> +	int stream;
> +
> +	for (stream = 0; stream < 2; stream++) {
> +		substream = pcm->streams[stream].substream;
> +		if (!substream)
> +			continue;
> +
> +		buf = &substream->dma_buffer;
> +		if (!buf->area)
> +			continue;
> +
> +		dma_free_writecombine(pcm->card->dev, buf->bytes,
> +				      buf->area, buf->addr);
> +		buf->area = NULL;
> +	}
> +}
> +
> +int omap_pcm_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
> +		 struct snd_pcm *pcm)
> +{
> +	int ret = 0;
> +
> +	if (!card->dev->dma_mask)
> +		card->dev->dma_mask = &omap_pcm_dmamask;
> +	if (!card->dev->coherent_dma_mask)
> +		card->dev->coherent_dma_mask = DMA_32BIT_MASK;
> +
> +	if (dai->playback.channels_min) {
> +		ret = omap_pcm_preallocate_dma_buffer(pcm,
> +			SNDRV_PCM_STREAM_PLAYBACK);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (dai->capture.channels_min) {
> +		ret = omap_pcm_preallocate_dma_buffer(pcm,
> +			SNDRV_PCM_STREAM_CAPTURE);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +struct snd_soc_platform omap_soc_platform = {
> +	.name		= "omap-pcm-audio",
> +	.pcm_ops 	= &omap_pcm_ops,
> +	.pcm_new	= omap_pcm_new,
> +	.pcm_free	= omap_pcm_free_dma_buffers,
> +};
> +EXPORT_SYMBOL_GPL(omap_soc_platform);
> +
> +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
> +MODULE_DESCRIPTION("OMAP PCM DMA module");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
> new file mode 100644
> index 0000000..e4369bd
> --- /dev/null
> +++ b/sound/soc/omap/omap-pcm.h
> @@ -0,0 +1,35 @@
> +/*
> + * omap-pcm.h
> + *
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
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
> +#ifndef __OMAP_PCM_H__
> +#define __OMAP_PCM_H__
> +
> +struct omap_pcm_dma_data {
> +	char		*name;		/* stream identifier */
> +	int		dma_req;	/* DMA request line */
> +	unsigned long	port_addr;	/* transmit/receive register */
> +};
> +
> +extern struct snd_soc_platform omap_soc_platform;
> +
> +#endif
> -- 
> 1.5.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
