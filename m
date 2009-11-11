From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Disable headset jack detection for SDP3430
Date: Wed, 11 Nov 2009 20:06:16 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE447FEB@dbde02.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602A6A21602@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35542 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069AbZKKOgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 09:36:16 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABEaJbM002501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 08:36:21 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nABEaIfC013499
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 20:06:19 +0530 (IST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602A6A21602@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Romero, Felipe" <felipe.romero@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Romero, Felipe
> Sent: Tuesday, November 10, 2009 11:24 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] Disable headset jack detection for SDP3430
> 
> From: Felipe Romero <felipe.romero@ti.com>
> 
> This patch Disable headset jack detection for SDP3430 boards,
> to avoid CPU kernel utilization.

[sp] I was wondering if you have measured savings in the
     cpu utilization.

Best regards,
Sanjeev

> ---
>  sound/soc/omap/sdp3430.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
> index b719e5d..3ef489e 100644
> --- a/sound/soc/omap/sdp3430.c
> +++ b/sound/soc/omap/sdp3430.c
> @@ -196,8 +196,8 @@ static int sdp3430_twl4030_init(struct 
> snd_soc_codec *codec)
>  	/* SDP3430 connected pins */
>  	snd_soc_dapm_enable_pin(codec, "Ext Mic");
>  	snd_soc_dapm_enable_pin(codec, "Ext Spk");
> -	snd_soc_dapm_disable_pin(codec, "Headset Mic");
> -	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
> +	snd_soc_dapm_enable_pin(codec, "Headset Mic");
> +	snd_soc_dapm_enable_pin(codec, "Headset Stereophone");
>  
>  	/* TWL4030 not connected pins */
>  	snd_soc_dapm_nc_pin(codec, "AUXL");
> @@ -217,7 +217,7 @@ static int sdp3430_twl4030_init(struct 
> snd_soc_codec *codec)
>  	ret = snd_soc_dapm_sync(codec);
>  	if (ret)
>  		return ret;
> -
> +#if 0
>  	/* Headset jack detection */
>  	ret = snd_soc_jack_new(&snd_soc_sdp3430, "Headset Jack",
>  				SND_JACK_HEADSET, &hs_jack);
> @@ -231,7 +231,7 @@ static int sdp3430_twl4030_init(struct 
> snd_soc_codec *codec)
>  
>  	ret = snd_soc_jack_add_gpios(&hs_jack, 
> ARRAY_SIZE(hs_jack_gpios),
>  				hs_jack_gpios);
> -
> +#endif
>  	return ret;
>  }
>  
> @@ -328,9 +328,10 @@ module_init(sdp3430_soc_init);
>  
>  static void __exit sdp3430_soc_exit(void)
>  {
> +#if 0
>  	snd_soc_jack_free_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
>  				hs_jack_gpios);
> -
> +#endif
>  	platform_device_unregister(sdp3430_snd_device);
>  }
>  module_exit(sdp3430_soc_exit);
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 