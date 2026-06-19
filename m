Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B62D738A;
	Fri, 19 Jun 2026 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781845998; cv=pass; b=ZdFHcRDDuwj+NUoteo9UAEfb4NFn9YjFmdelmthh0lIbnd3DIBCsseHAitDmVgVranYmPtY/2gusrN8GtRb1nQR/1LFyIpmW9aqgBGNMaaKTcHAdTT8UaS0+Ly1uiajtT2lsglD6Nu87S8/vHHGj2qinaJ9zQFaVY3yVmnynxC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781845998; c=relaxed/simple;
	bh=8psor1VANbyrVHyf6CquvuFooTzwQ79/eZ/HJ5vj/T0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g4Fu3WESFP2F6DLRrWaOJL5zZaKFRmK3B0uzlWs7wUDCWm85xYAx3jpvPBWpbiJEBqX2sJzSmDBz32F95f8vR7+mONAgRr+nIoRkt3FD2976SEFMtfSH8bFXh9tuiVuDVVYVWJtc/96CHSx4X7GuIkSL+noP8xV2PZRcVJOiKwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Nqjw5ED1; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=I9WKDZM4; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Nqjw5ED1";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="I9WKDZM4"
ARC-Seal: i=1; a=rsa-sha256; t=1781845984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eETk043ZD+RkargpckIfWbpOfvQ9bMbNZ5/B07oVKj05KN2tegtoIWw5MftWv0Qv2O
    F/MHRsCl3AgIAZdj70eMmE7SgNZFh2qBwCCaXqZks42y9p14iCEyNH31isVFiyj+Npgi
    FTqLXUbENlqS7n6s5jw+Ge9g62YsBj81YxAkhOl+LkoCgJbPl1IVNdeau5jEIElBuvpo
    AmJRvayXI5i9AWqttAGnflm+l4a4zKJi7kDGMj0n5ySy1XPVp1BV+2fQfC+GuskFd3zl
    tWet7H5VQyuoehwb+MAgFqWkvXPBcu3uATWomI9ooplEij+9UOLBfnI17yGz/zYYGsev
    nk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781845984;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2jk90AWS3nemNlJWGlO/vATHfLoPKDJ1rY2ELxgc4Jw=;
    b=bkJZlUXDTrHqIF6Vs7CeqZx4m/lnqmyAjc5nuMcwE7HmzzZGIoi79SFr7KWU9H+YVB
    jDxw4iL4OWRVqdF5Mga7b1qKcsCZ//DcMRhBx+mbwVA9syQxZjshoMO1cCN8YVZubcoj
    MKLVFxPQ5UKirSDBKvCamYJLeNHn/ChDEzQrn+LdHfNxr1DKQgmjN7TM6G8elI9O//vU
    JCD9rQK+l180tCQN7INF1nx6PVoS5vtzr4PPZl6g7qna52UXVyPo9neA2gX1/0ZnZV5l
    +hsDBuOLy57Jx6fslggXZ062pNxKgsSfxlAPj0j2MXUlW83lXO2uAHF4EWBvPymKRMiL
    BHrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781845984;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2jk90AWS3nemNlJWGlO/vATHfLoPKDJ1rY2ELxgc4Jw=;
    b=Nqjw5ED1+DWZ7rjSBRtjyF3ykTgBPd6sml2sUHF10dQQxxCZrfHzr4lTO9ot7M7iQF
    jlcQLWFhSaoqOIATaE/ypM5z92Io+InGmWBPqcwnm6SMNjjq5R7wWz7SnKEikycoWmB6
    KEFbPF31brP4VhPSXZMPntq+nCHlxZve1WW+QPUCIPKOHs/AHPMPx4E4AuCDihwuARc3
    32QePzV1Nu+3yehRK3/yVU2kH/5YPkoueaQvZ1dVvApDcrZCmDKwH4wqQJQQSdXsp410
    O4M/znHqx/bR3Gl1CJEUku097y6i28aKwjgDKYiesYuewJn35fPWqMP1ffXsNb/h0nqo
    TbRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781845984;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=2jk90AWS3nemNlJWGlO/vATHfLoPKDJ1rY2ELxgc4Jw=;
    b=I9WKDZM4ADmDxSVGard/IiKDknejLld8LsweTFyRL6z9QVOfx5sjsyxE5xGCIop/qb
    fAXrgwREZ4k7xvzXPkBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ2ppZzsiNc/fOFMhUadUzANaCP/08tKGRQWc="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Qcf97c25J5D3gnf
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 19 Jun 2026 07:13:03 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.6\))
Subject: Re: [PATCH 2/4] ASoC: ti: omap3pandora: remove
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
Date: Fri, 19 Jun 2026 07:12:52 +0200
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 Andreas Kemnade <akemnade@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <042F910C-3008-441A-8B34-686AB328AEFE@goldelico.com>
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
 <20260603-asoc-remove-mach-types-h-v1-2-2b9446dff0c1@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: Apple Mail (2.3826.700.81.1.6)

I found out that the already applied patch

=
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?h=3Dnext-20260618&id=3D45efb8fbdae303539e7fb5562e147583d4ed63ad

has the same effect of removing the machine_is_omap3_pandora() =
dependency with less harm to the code base.

For all others: a modernized rework of the openpandora sound driver =
based on the existing code is currently being worked on.


> Am 03.06.2026 um 14:09 schrieb Sascha Hauer <s.hauer@pengutronix.de>:
>=20
> The omap3pandora driver entirely depends on().
> Pandora has been converted to device tree:
>=20
> 7fcf7e061edd3 ("ARM: OMAP2+: Remove legacy booting support for =
Pandora")
>=20
> Since then machine_is_omap3_pandora() always expands to 0. Remove the
> long unused driver.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> sound/soc/ti/Kconfig        |   9 --
> sound/soc/ti/Makefile       |   2 -
> sound/soc/ti/omap3pandora.c | 290 =
--------------------------------------------
> 3 files changed, 301 deletions(-)
>=20
> diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
> index 3323cf96e3095..e5b165e0fc6cc 100644
> --- a/sound/soc/ti/Kconfig
> +++ b/sound/soc/ti/Kconfig
> @@ -83,15 +83,6 @@ config SND_SOC_NOKIA_RX51
>  Say Y or M if you want to add support for SoC audio on Nokia RX-51
>  hardware. This is also known as Nokia N900 product.
>=20
> -config SND_SOC_OMAP3_PANDORA
> - tristate "SoC Audio support for OMAP3 Pandora"
> - depends on ARCH_OMAP3
> - depends on TWL4030_CORE
> - select SND_SOC_OMAP_MCBSP
> - select SND_SOC_TWL4030
> - help
> -  Say Y or M if you want to add support for SoC audio on the OMAP3 =
Pandora.
> -
> config SND_SOC_OMAP3_TWL4030
> tristate "SoC Audio support for OMAP3 based boards with twl4030 codec"
> depends on ARCH_OMAP3 || COMPILE_TEST && COMMON_CLK
> diff --git a/sound/soc/ti/Makefile b/sound/soc/ti/Makefile
> index 421e13bc04dbb..a5f5b284c0e28 100644
> --- a/sound/soc/ti/Makefile
> +++ b/sound/soc/ti/Makefile
> @@ -26,7 +26,6 @@ obj-$(CONFIG_SND_SOC_OMAP_MCPDM) +=3D =
snd-soc-omap-mcpdm.o
> snd-soc-davinci-evm-y :=3D davinci-evm.o
> snd-soc-n810-y :=3D n810.o
> snd-soc-rx51-y :=3D rx51.o
> -snd-soc-omap3pandora-y :=3D omap3pandora.o
> snd-soc-omap-twl4030-y :=3D omap-twl4030.o
> snd-soc-omap-abe-twl6040-y :=3D omap-abe-twl6040.o
> snd-soc-ams-delta-y :=3D ams-delta.o
> @@ -37,7 +36,6 @@ snd-soc-j721e-evm-y :=3D j721e-evm.o
> obj-$(CONFIG_SND_SOC_DAVINCI_EVM) +=3D snd-soc-davinci-evm.o
> obj-$(CONFIG_SND_SOC_NOKIA_N810) +=3D snd-soc-n810.o
> obj-$(CONFIG_SND_SOC_NOKIA_RX51) +=3D snd-soc-rx51.o
> -obj-$(CONFIG_SND_SOC_OMAP3_PANDORA) +=3D snd-soc-omap3pandora.o
> obj-$(CONFIG_SND_SOC_OMAP3_TWL4030) +=3D snd-soc-omap-twl4030.o
> obj-$(CONFIG_SND_SOC_OMAP_ABE_TWL6040) +=3D snd-soc-omap-abe-twl6040.o
> obj-$(CONFIG_SND_SOC_OMAP_AMS_DELTA) +=3D snd-soc-ams-delta.o
> diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
> deleted file mode 100644
> index f11b1d8a1306c..0000000000000
> --- a/sound/soc/ti/omap3pandora.c
> +++ /dev/null
> @@ -1,290 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * omap3pandora.c  --  SoC audio for Pandora Handheld Console
> - *
> - * Author: Gra=C5=BEvydas Ignotas <notasas@gmail.com>
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/platform_device.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/delay.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/module.h>
> -
> -#include <sound/core.h>
> -#include <sound/pcm.h>
> -#include <sound/soc.h>
> -
> -#include <asm/mach-types.h>
> -#include <linux/platform_data/asoc-ti-mcbsp.h>
> -
> -#include "omap-mcbsp.h"
> -
> -#define PREFIX "ASoC omap3pandora: "
> -
> -static struct regulator *omap3pandora_dac_reg;
> -static struct gpio_desc *dac_power_gpio;
> -static struct gpio_desc *amp_power_gpio;
> -
> -static int omap3pandora_hw_params(struct snd_pcm_substream =
*substream,
> - struct snd_pcm_hw_params *params)
> -{
> - struct snd_soc_pcm_runtime *rtd =3D =
snd_soc_substream_to_rtd(substream);
> - struct snd_soc_dai *codec_dai =3D snd_soc_rtd_to_codec(rtd, 0);
> - struct snd_soc_dai *cpu_dai =3D snd_soc_rtd_to_cpu(rtd, 0);
> - int ret;
> -
> - /* Set the codec system clock for DAC and ADC */
> - ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
> -    SND_SOC_CLOCK_IN);
> - if (ret < 0) {
> - pr_err(PREFIX "can't set codec system clock\n");
> - return ret;
> - }
> -
> - /* Set McBSP clock to external */
> - ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT,
> -     256 * params_rate(params),
> -     SND_SOC_CLOCK_IN);
> - if (ret < 0) {
> - pr_err(PREFIX "can't set cpu system clock\n");
> - return ret;
> - }
> -
> - ret =3D snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 8);
> - if (ret < 0) {
> - pr_err(PREFIX "can't set SRG clock divider\n");
> - return ret;
> - }
> -
> - return 0;
> -}
> -
> -static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
> - struct snd_kcontrol *k, int event)
> -{
> - int ret;
> -
> - /*
> - * The PCM1773 DAC datasheet requires 1ms delay between switching
> - * VCC power on/off and /PD pin high/low
> - */
> - if (SND_SOC_DAPM_EVENT_ON(event)) {
> - struct device *dev =3D snd_soc_dapm_to_dev(w->dapm);
> -
> - ret =3D regulator_enable(omap3pandora_dac_reg);
> - if (ret) {
> - dev_err(dev, "Failed to power DAC: %d\n", ret);
> - return ret;
> - }
> - mdelay(1);
> - gpiod_set_value(dac_power_gpio, 1);
> - } else {
> - gpiod_set_value(dac_power_gpio, 0);
> - mdelay(1);
> - regulator_disable(omap3pandora_dac_reg);
> - }
> -
> - return 0;
> -}
> -
> -static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
> - struct snd_kcontrol *k, int event)
> -{
> - if (SND_SOC_DAPM_EVENT_ON(event))
> - gpiod_set_value(amp_power_gpio, 1);
> - else
> - gpiod_set_value(amp_power_gpio, 0);
> -
> - return 0;
> -}
> -
> -/*
> - * Audio paths on Pandora board:
> - *
> - *  |O| ---> PCM DAC +-> AMP -> Headphone Jack
> - *  |M|         A    +--------> Line Out
> - *  |A| <~~clk~~+
> - *  |P| <--- TWL4030 <--------- Line In and MICs
> - */
> -static const struct snd_soc_dapm_widget omap3pandora_dapm_widgets[] =3D=
 {
> - SND_SOC_DAPM_DAC_E("PCM DAC", "HiFi Playback", SND_SOC_NOPM,
> -   0, 0, omap3pandora_dac_event,
> -   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> - SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
> -   0, 0, NULL, 0, omap3pandora_hp_event,
> -   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> - SND_SOC_DAPM_HP("Headphone Jack", NULL),
> - SND_SOC_DAPM_LINE("Line Out", NULL),
> -
> - SND_SOC_DAPM_MIC("Mic (internal)", NULL),
> - SND_SOC_DAPM_MIC("Mic (external)", NULL),
> - SND_SOC_DAPM_LINE("Line In", NULL),
> -};
> -
> -static const struct snd_soc_dapm_route omap3pandora_map[] =3D {
> - {"PCM DAC", NULL, "APLL Enable"},
> - {"Headphone Amplifier", NULL, "PCM DAC"},
> - {"Line Out", NULL, "PCM DAC"},
> - {"Headphone Jack", NULL, "Headphone Amplifier"},
> -
> - {"AUXL", NULL, "Line In"},
> - {"AUXR", NULL, "Line In"},
> -
> - {"MAINMIC", NULL, "Mic (internal)"},
> - {"Mic (internal)", NULL, "Mic Bias 1"},
> -
> - {"SUBMIC", NULL, "Mic (external)"},
> - {"Mic (external)", NULL, "Mic Bias 2"},
> -};
> -
> -static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
> -{
> - struct snd_soc_dapm_context *dapm =3D =
snd_soc_card_to_dapm(rtd->card);
> -
> - /* All TWL4030 output pins are floating */
> - snd_soc_dapm_disable_pin(dapm, "EARPIECE");
> - snd_soc_dapm_disable_pin(dapm, "PREDRIVEL");
> - snd_soc_dapm_disable_pin(dapm, "PREDRIVER");
> - snd_soc_dapm_disable_pin(dapm, "HSOL");
> - snd_soc_dapm_disable_pin(dapm, "HSOR");
> - snd_soc_dapm_disable_pin(dapm, "CARKITL");
> - snd_soc_dapm_disable_pin(dapm, "CARKITR");
> - snd_soc_dapm_disable_pin(dapm, "HFL");
> - snd_soc_dapm_disable_pin(dapm, "HFR");
> - snd_soc_dapm_disable_pin(dapm, "VIBRA");
> -
> - return 0;
> -}
> -
> -static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
> -{
> - struct snd_soc_dapm_context *dapm =3D =
snd_soc_card_to_dapm(rtd->card);
> -
> - /* Not comnnected */
> - snd_soc_dapm_disable_pin(dapm, "HSMIC");
> - snd_soc_dapm_disable_pin(dapm, "CARKITMIC");
> - snd_soc_dapm_disable_pin(dapm, "DIGIMIC0");
> - snd_soc_dapm_disable_pin(dapm, "DIGIMIC1");
> -
> - return 0;
> -}
> -
> -static const struct snd_soc_ops omap3pandora_ops =3D {
> - .hw_params =3D omap3pandora_hw_params,
> -};
> -
> -/* Digital audio interface glue - connects codec <--> CPU */
> -SND_SOC_DAILINK_DEFS(out,
> - DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
> - DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
> - DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
> -
> -SND_SOC_DAILINK_DEFS(in,
> - DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.4")),
> - DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
> - DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.4")));
> -
> -static struct snd_soc_dai_link omap3pandora_dai[] =3D {
> - {
> - .name =3D "PCM1773",
> - .stream_name =3D "HiFi Out",
> - .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> -   SND_SOC_DAIFMT_CBC_CFC,
> - .ops =3D &omap3pandora_ops,
> - .init =3D omap3pandora_out_init,
> - SND_SOC_DAILINK_REG(out),
> - }, {
> - .name =3D "TWL4030",
> - .stream_name =3D "Line/Mic In",
> - .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> -   SND_SOC_DAIFMT_CBC_CFC,
> - .ops =3D &omap3pandora_ops,
> - .init =3D omap3pandora_in_init,
> - SND_SOC_DAILINK_REG(in),
> - }
> -};
> -
> -/* SoC card */
> -static struct snd_soc_card snd_soc_card_omap3pandora =3D {
> - .name =3D "omap3pandora",
> - .owner =3D THIS_MODULE,
> - .dai_link =3D omap3pandora_dai,
> - .num_links =3D ARRAY_SIZE(omap3pandora_dai),
> -
> - .dapm_widgets =3D omap3pandora_dapm_widgets,
> - .num_dapm_widgets =3D ARRAY_SIZE(omap3pandora_dapm_widgets),
> - .dapm_routes =3D omap3pandora_map,
> - .num_dapm_routes =3D ARRAY_SIZE(omap3pandora_map),
> -};
> -
> -static struct platform_device *omap3pandora_snd_device;
> -
> -static int __init omap3pandora_soc_init(void)
> -{
> - int ret;
> -
> - if (!machine_is_omap3_pandora())
> - return -ENODEV;
> -
> - pr_info("OMAP3 Pandora SoC init\n");
> -
> - omap3pandora_snd_device =3D platform_device_alloc("soc-audio", -1);
> - if (omap3pandora_snd_device =3D=3D NULL) {
> - pr_err(PREFIX "Platform device allocation failed\n");
> - return -ENOMEM;
> - }
> -
> - platform_set_drvdata(omap3pandora_snd_device, =
&snd_soc_card_omap3pandora);
> -
> - ret =3D platform_device_add(omap3pandora_snd_device);
> - if (ret) {
> - pr_err(PREFIX "Unable to add platform device\n");
> - goto fail2;
> - }
> -
> - dac_power_gpio =3D devm_gpiod_get(&omap3pandora_snd_device->dev,
> - "dac", GPIOD_OUT_LOW);
> - if (IS_ERR(dac_power_gpio)) {
> - ret =3D PTR_ERR(dac_power_gpio);
> - goto fail3;
> - }
> -
> - amp_power_gpio =3D devm_gpiod_get(&omap3pandora_snd_device->dev,
> - "amp", GPIOD_OUT_LOW);
> - if (IS_ERR(amp_power_gpio)) {
> - ret =3D PTR_ERR(amp_power_gpio);
> - goto fail3;
> - }
> -
> - omap3pandora_dac_reg =3D =
regulator_get(&omap3pandora_snd_device->dev, "vcc");
> - if (IS_ERR(omap3pandora_dac_reg)) {
> - pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
> - dev_name(&omap3pandora_snd_device->dev),
> - PTR_ERR(omap3pandora_dac_reg));
> - ret =3D PTR_ERR(omap3pandora_dac_reg);
> - goto fail3;
> - }
> -
> - return 0;
> -
> -fail3:
> - platform_device_del(omap3pandora_snd_device);
> -fail2:
> - platform_device_put(omap3pandora_snd_device);
> -
> - return ret;
> -}
> -module_init(omap3pandora_soc_init);
> -
> -static void __exit omap3pandora_soc_exit(void)
> -{
> - regulator_put(omap3pandora_dac_reg);
> - platform_device_unregister(omap3pandora_snd_device);
> -}
> -module_exit(omap3pandora_soc_exit);
> -
> -MODULE_AUTHOR("Grazvydas Ignotas <notasas@gmail.com>");
> -MODULE_DESCRIPTION("ALSA SoC OMAP3 Pandora");
> -MODULE_LICENSE("GPL");
>=20
> --=20
> 2.47.3
>=20
>=20

