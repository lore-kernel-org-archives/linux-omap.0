From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Enable fix for Cortex-A9 erratas
Date: Mon, 8 Apr 2013 16:27:25 -0700
Message-ID: <20130408232725.GF10155@atomide.com>
References: <1363876938-31724-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60842 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935496Ab3DHX13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 19:27:29 -0400
Content-Disposition: inline
In-Reply-To: <1363876938-31724-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com

* Sricharan R <r.sricharan@ti.com> [130321 07:46]:
> This enables the fixes for the below erratas
> applicable for OMAP4 Socs.
> 
> 754322: Faulty MMU translations following ASID switch
> 
> 775420: A data cache maintenance operation which aborts,
>         followed by an ISB, without any DSB in-between,
>         might lead to deadlock
> 
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks applying into omap-for-v3.10/soc.

Tony

> ---
>  arch/arm/mach-omap2/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index c3477e7..c4a3f3f 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -73,6 +73,8 @@ config ARCH_OMAP4
>  	select PM_RUNTIME if CPU_IDLE
>  	select USB_ARCH_HAS_EHCI if USB_SUPPORT
>  	select COMMON_CLK
> +	select ARM_ERRATA_754322
> +	select ARM_ERRATA_775420
>  
>  config SOC_OMAP5
>  	bool "TI OMAP5"
> -- 
> 1.7.9.5
> 
