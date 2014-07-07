From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/12] ARM: OMAP2+: Remove non working OMAP HDMI audio
 initialization
Date: Mon, 7 Jul 2014 04:46:25 -0700
Message-ID: <20140707114625.GT28884@atomide.com>
References: <cover.1403807781.git.jsarha@ti.com>
 <b0764a3af8181db55db046d6139119def363e8eb.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42732 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaGGLq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 07:46:26 -0400
Content-Disposition: inline
In-Reply-To: <b0764a3af8181db55db046d6139119def363e8eb.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi

* Jyri Sarha <jsarha@ti.com> [140626 12:26]:
> This code is not working currently and it can be removed. There is a
> conflict in sharing resources with the actual HDMI driver and with
> the ASoC HDMI audio DAI driver.

Is this OK to queue for v3.17 or do we need this for v3.16-rc series?

Regards,

Tony
 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 592ba0a..b6f8f34 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -297,33 +297,6 @@ static void omap_init_audio(void)
>  static inline void omap_init_audio(void) {}
>  #endif
>  
> -#if defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI) || \
> -		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
> -
> -static struct platform_device omap_hdmi_audio = {
> -	.name	= "omap-hdmi-audio",
> -	.id	= -1,
> -};
> -
> -static void __init omap_init_hdmi_audio(void)
> -{
> -	struct omap_hwmod *oh;
> -	struct platform_device *pdev;
> -
> -	oh = omap_hwmod_lookup("dss_hdmi");
> -	if (!oh)
> -		return;
> -
> -	pdev = omap_device_build("omap-hdmi-audio-dai", -1, oh, NULL, 0);
> -	WARN(IS_ERR(pdev),
> -	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
> -
> -	platform_device_register(&omap_hdmi_audio);
> -}
> -#else
> -static inline void omap_init_hdmi_audio(void) {}
> -#endif
> -
>  #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
>  
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> @@ -459,7 +432,6 @@ static int __init omap2_init_devices(void)
>  	 */
>  	omap_init_audio();
>  	omap_init_camera();
> -	omap_init_hdmi_audio();
>  	omap_init_mbox();
>  	/* If dtb is there, the devices will be created dynamically */
>  	if (!of_have_populated_dt()) {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
