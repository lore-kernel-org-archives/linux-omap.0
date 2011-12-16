From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 01:14:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56532 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974Ab1LPIOz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 03:14:55 -0500
In-Reply-To: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: b-cousson@ti.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

Hi

some comments

On Fri, 16 Dec 2011, Ricardo Neri wrote:

> When playing audio through HDMI, the module should be put in
> no-idle mode. This is to prevent the DSS_L3_ICLK to be shut down.
> Once audio playback is stopped, the module is set back to smart-idle
> wakeup-capable.

This is due to a hardware bug/erratum?  If so, the erratum ID should be 
mentioned.  Also, please mention what happens if the module runs in 
smart-idle - some type of audio glitch?

> Also, a omap_hwmod structure is added to hdmi_ip_data to have access
> to idle-mode configuration.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c    |   13 +++++++++++++
>  drivers/video/omap2/dss/ti_hdmi.h |    4 ++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 5c93041..e177338 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -35,6 +35,7 @@
>  #include <video/omapdss.h>
>  #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
>  	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> +#include <plat/omap_hwmod.h>
>  #include <sound/soc.h>
>  #include <sound/pcm_params.h>
>  #include "ti_hdmi_4xxx_ip.h"
> @@ -572,12 +573,16 @@ int hdmi_audio_trigger(struct snd_pcm_substream *substream, int cmd,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		omap_hwmod_set_slave_idlemode(ip_data->oh,
> +			HWMOD_IDLEMODE_NO);

omap_hwmod functions should not be called from device driver code.  Device 
drivers should be completely independent of architecture and 
subarchitecture code.  If you need to do something like this, the way to 
do it is to call an omap_device function through a platform_data function 
pointer.  You may need to create omap_device and/or omap_hwmod functions 
to do what you want to do.

>  		ip_data->ops->audio_enable(ip_data, true);
>  		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		ip_data->ops->audio_enable(ip_data, false);
> +		omap_hwmod_set_slave_idlemode(ip_data->oh,
> +			HWMOD_IDLEMODE_SMART_WKUP);

Same comment as above.

>  		break;
>  	default:
>  		err = -EINVAL;


And then the rest of this patch shouldn't be needed.

> @@ -733,8 +738,16 @@ static int hdmi_audio_startup(struct snd_pcm_substream *substream,
>  
>  static int hdmi_audio_codec_probe(struct snd_soc_codec *codec)
>  {
> +	struct platform_device *pdev = to_platform_device(codec->dev);
>  	struct hdmi_ip_data *priv = &hdmi.ip_data;
>  
> +	priv->oh = omap_hwmod_lookup("dss_hdmi");
> +
> +	if (!priv->oh) {
> +		dev_err(&pdev->dev, "Cannot find omap_hwmod for hdmi\n");
> +		return -ENODEV;
> +	}
> +
>  	snd_soc_codec_set_drvdata(codec, priv);
>  	return 0;
>  }
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
> index 7503f7f..5ef3cb1 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -126,6 +126,10 @@ struct hdmi_ip_data {
>  	const struct ti_hdmi_ip_ops *ops;
>  	struct hdmi_config cfg;
>  	struct hdmi_pll_info pll_data;
> +#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
> +	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
> +	struct omap_hwmod *oh;
> +#endif
>  };
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>  void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
