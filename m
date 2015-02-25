From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap-device: add missed callback for suspend-to-disk
Date: Wed, 25 Feb 2015 07:44:46 -0800
Message-ID: <20150225154445.GO11056@atomide.com>
References: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery5.ore.mailhop.org ([54.148.219.64]:60344 "EHLO
	pmta1.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752625AbbBYPsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 10:48:55 -0500
Received: from smtp4.ore.mailhop.org (172.31.18.134) by pmta1.delivery1.ore.mailhop.org id htnne820r84v for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 15:48:51 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-arm-kernel@lists.infradead.org

* grygorii.strashko@linaro.org <grygorii.strashko@linaro.org> [150225 06:17]:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> 
> Add missed callback needed for supporting suspend-to-disk (hibernation) mode.

Is this needed as a fix for the -rc series or are there still
other missing dependencies?

Regards,

Tony
 
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> ---
>  arch/arm/mach-omap2/omap_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index fcd2c9e..345e18e 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -739,6 +739,9 @@ struct dev_pm_domain omap_device_pm_domain = {
>  		USE_PLATFORM_PM_SLEEP_OPS
>  		.suspend_noirq = _od_suspend_noirq,
>  		.resume_noirq = _od_resume_noirq,
> +		.freeze_noirq = _od_suspend_noirq,
> +		.thaw_noirq = _od_resume_noirq,
> +		.restore_noirq = _od_resume_noirq,
>  	}
>  };
>  
> -- 
> 1.9.1
> 
