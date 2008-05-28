From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]  ARM: OMAP: beagleboard defconfig: increase FB DMA
	size to 4MB so the 1024x768x24 default fits
Date: Wed, 28 May 2008 16:11:49 -0700
Message-ID: <20080528231149.GA8013@atomide.com>
References: <1212014024-4698-1-git-send-email-k.kooi@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64886 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbYE1XLw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 19:11:52 -0400
Content-Disposition: inline
In-Reply-To: <1212014024-4698-1-git-send-email-k.kooi@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org, Koen Kooi <koen@openembedded.org>

* Koen Kooi <k.kooi@student.utwente.nl> [080528 15:34]:
> From: Koen Kooi <koen@openembedded.org>
> 
> beagleboard defconfig: increase FB DMA size to 4MB so the 1024x768x24 default fits

OK, pushed this too.

Tony

> 
> Signed-off-by: Koen Kooi <koen@openembedded.org>
> ---
>  arch/arm/configs/omap3_beagle_defconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
> index 6aec7b7..cce83e5 100644
> --- a/arch/arm/configs/omap3_beagle_defconfig
> +++ b/arch/arm/configs/omap3_beagle_defconfig
> @@ -703,7 +703,7 @@ CONFIG_FB_CFB_IMAGEBLIT=y
>  CONFIG_FB_OMAP=y
>  # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
>  # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> -CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
> +CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
>  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>  
>  #
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
