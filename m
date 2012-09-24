From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI
 AM33XX
Date: Mon, 24 Sep 2012 10:18:58 -0700
Message-ID: <20120924171858.GG28835@atomide.com>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:10770 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752835Ab2IXRTD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 13:19:03 -0400
Content-Disposition: inline
In-Reply-To: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dejan Gacnik <dejan.gacnik@gmail.com>

* yegorslists@googlemail.com <yegorslists@googlemail.com> [120703 07:26]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
> of consistent DMA memory (da8xx frame buffer driver).

Sorry for the delay on this one, looks like this one is
still valid. I'll apply it.

Regards,

Tony
 
> Signed-off-by: Dejan Gacnik <dejan.gacnik@gmail.com>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  arch/arm/Kconfig |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e876819..ff14c1e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1725,8 +1725,9 @@ config HW_PERF_EVENTS
>  source "mm/Kconfig"
>  
>  config FORCE_MAX_ZONEORDER
> -	int "Maximum zone order" if ARCH_SHMOBILE
> -	range 11 64 if ARCH_SHMOBILE
> +	int "Maximum zone order"
> +	depends on ARCH_SHMOBILE || SOC_AM33XX
> +	range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
>  	default "9" if SA1111
>  	default "11"
>  	help
> -- 
> 1.7.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
