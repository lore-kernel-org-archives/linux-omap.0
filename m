From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] Disable headset jack detection for SDP3430
Date: Tue, 10 Nov 2009 12:08:36 -0600
Message-ID: <4AF9AC24.2020107@ti.com>
References: <496565EC904933469F292DDA3F1663E602A6A21602@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51900 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbZKJSIb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 13:08:31 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAAI8bfM016491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 12:08:37 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAAI8b1E000725
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 12:08:37 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAAI8blK005498
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2009 12:08:37 -0600 (CST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602A6A21602@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Romero, Felipe" <felipe.romero@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Romero, Felipe had written, on 11/10/2009 11:54 AM, the following:
> From: Felipe Romero <felipe.romero@ti.com>
> 
> This patch Disable headset jack detection for SDP3430 boards,
> to avoid CPU kernel utilization.

please read Documentation/SubmittingPatches
12) Sign your work

> ---
>  sound/soc/omap/sdp3430.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
> index b719e5d..3ef489e 100644
> --- a/sound/soc/omap/sdp3430.c
> +++ b/sound/soc/omap/sdp3430.c
> @@ -196,8 +196,8 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
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
> @@ -217,7 +217,7 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
>  	ret = snd_soc_dapm_sync(codec);
>  	if (ret)
>  		return ret;
> -
> +#if 0
NAK to #if 0s. if you dont need that code, please remove it
>  	/* Headset jack detection */
>  	ret = snd_soc_jack_new(&snd_soc_sdp3430, "Headset Jack",
>  				SND_JACK_HEADSET, &hs_jack);
> @@ -231,7 +231,7 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
>  
>  	ret = snd_soc_jack_add_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
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
NAK to #if 0s. if you dont need that code, please remove it
>  	snd_soc_jack_free_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
>  				hs_jack_gpios);
> -
> +#endif
>  	platform_device_unregister(sdp3430_snd_device);
>  }
>  module_exit(sdp3430_soc_exit);


-- 
Regards,
Nishanth Menon
