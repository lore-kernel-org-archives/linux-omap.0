From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO
Date: Tue, 24 Mar 2015 09:26:48 -0500
Message-ID: <20150324142647.GA9145@kahuna>
References: <1427192359-19168-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41130 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbbCXO0v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 10:26:51 -0400
Content-Disposition: inline
In-Reply-To: <1427192359-19168-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org

On 12:19-20150324, Roger Quadros wrote:
> We need to enable EXTCON_USB_GPIO_USB and not
> EXTCON_GPIO_USB.
> 
> Fixes: c08a54c0ebeb ("ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB")
> 
> Reported-by: Nishant Menon <nm@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/configs/omap2plus_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 04b4c8e..daf9412 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -391,7 +391,7 @@ CONFIG_TI_EDMA=y
>  CONFIG_DMA_OMAP=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXTCON=m
> -CONFIG_EXTCON_GPIO=m
> +CONFIG_EXTCON_USB_GPIO=m
>  CONFIG_EXTCON_PALMAS=m
>  CONFIG_TI_EMIF=m
>  CONFIG_PWM=y
> -- 
> 2.1.0

Yep and it finally works! Yipiee!!
http://pastebin.ubuntu.com/10669565/

Acked-and-Tested-by: Nishanth Menon <nm@ti.com>
> 

-- 
Regards,
Nishanth Menon
