From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCHv5 2/2] ASoC: TWL6040: Add twl6040 codec driver
Date: Sat, 13 Mar 2010 05:23:27 -0600
Message-ID: <05b5d6bc0abd41e31334184e66718cec@secure211.sgcpanel.com>
References: <1889FA7136B567478A67D4B0F85B0CCE66173AF7@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34966 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933646Ab0CMLX3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Mar 2010 06:23:29 -0500
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE66173AF7@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

Hi,

On Fri, 12 Mar 2010 19:52:20 -0600, "Olaya, Margarita" <magi.olaya@ti.com>
wrote:
> +/*
> + * twl6040 register cache & default register settings
> + */
> +static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
> +       0x00, /* not used               0x00    */
> +       0x4B, /* TWL6040_ASICID (ro)    0x01    */
> +       0x00, /* TWL6040_ASICREV (ro)   0x02    */
> +       0x00, /* TWL6040_INTID          0x03    */
> +       0x00, /* TWL6040_INTMR          0x04    */
> +       0x00, /* TWL6040_NCPCTRL        0x05    */
> +       0x00, /* TWL6040_LDOCTL         0x06    */
> +       0x00, /* TWL6040_HPPLLCTL       0x07    */
> +       0x00, /* TWL6040_LPPLLCTL       0x08    */
> +       0x00, /* TWL6040_LPPLLDIV       0x09    */
> +       0x00, /* TWL6040_AMICBCTL       0x0A    */
> +       0x00, /* TWL6040_DMICBCTL       0x0B    */
> +       0x18, /* TWL6040_MICLCTL        0x0C    */
> +       0x18, /* TWL6040_MICRCTL        0x0D    */
> +       0x00, /* TWL6040_MICGAIN        0x0E    */
> +       0x1B, /* TWL6040_LINEGAIN       0x0F    */
> +       0x00, /* TWL6040_HSLCTL         0x10    */
> +       0x00, /* TWL6040_HSRCTL         0x11    */
> +       0x00, /* TWL6040_HSGAIN         0x12    */
> +       0x06, /* TWL6040_EARCTL         0x13    */
> +       0x00, /* TWL6040_HFLCTL         0x14    */
> +       0x03, /* TWL6040_HFLGAIN        0x15    */
> +       0x00, /* TWL6040_HFRCTL         0x16    */
> +       0x03, /* TWL6040_HFRGAIN        0x17    */
> +       0x00, /* TWL6040_VIBCTLL        0x18    */
> +       0x00, /* TWL6040_VIBDATL        0x19    */
> +       0x00, /* TWL6040_VIBCTLR        0x1A    */
> +       0x00, /* TWL6040_VIBDATR        0x1B    */
> +       0x00, /* TWL6040_HKCTL1         0x1C    */
> +       0x00, /* TWL6040_HKCTL2         0x1D    */
> +       0x00, /* TWL6040_GPOCTL         0x1E    */
> +       0x00, /* TWL6040_ALB            0x1F    */
> +       0x00, /* TWL6040_DLB            0x20    */
> +       0x00, /* not used               0x21    */
> +       0x00, /* not used               0x22    */
> +       0x00, /* not used               0x23    */
> +       0x00, /* not used               0x24    */
> +       0x00, /* not used               0x25    */
> +       0x00, /* not used               0x26    */
> +       0x00, /* not used               0x27    */
> +       0x00, /* TWL6040_TRIM1          0x28    */
> +       0x00, /* TWL6040_TRIM2          0x29    */
> +       0x00, /* TWL6040_TRIM3          0x2A    */
> +       0x00, /* TWL6040_HSOTRIM        0x2B    */
> +       0x00, /* TWL6040_HFOTRIM        0x2C    */
> +       0x09, /* TWL6040_ACCCTL         0x2D    */
> +       0x00, /* TWL6040_STATUS (ro)    0x2E    */
> +};

a little comment about what the default values are would
be nice.

#ifdef CONFIG_PM

> +static int twl6040_suspend(struct platform_device *pdev, pm_message_t
> state)
> +{
> +       struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +       struct snd_soc_codec *codec = socdev->card->codec;
> +
> +       twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +       return 0;
> +}
> +
> +static int twl6040_resume(struct platform_device *pdev)
> +{
> +       struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +       struct snd_soc_codec *codec = socdev->card->codec;
> +
> +       twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +       twl6040_set_bias_level(codec, codec->suspend_bias_level);
> +
> +       return 0;
> +}

#else
#define twl6040_suspend    NULL
#define twl6040_resume     NULL
#endif

-- 
balbi
