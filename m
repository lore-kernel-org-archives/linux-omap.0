From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: increase FORCE_MAX_ZONEORDER for TI AM33XX
Date: Mon, 8 Oct 2012 14:38:17 -0700
Message-ID: <20121008213817.GS13011@atomide.com>
References: <1348562644-14447-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44262 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751108Ab2JHViS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 17:38:18 -0400
Content-Disposition: inline
In-Reply-To: <1348562644-14447-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: yegorslists@googlemail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dejan Gacnik <dejan.gacnik@gmail.com>

* yegorslists@googlemail.com <yegorslists@googlemail.com> [120925 01:45]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
> of consistent DMA memory (da8xx frame buffer driver).
> 
> Signed-off-by: Dejan Gacnik <dejan.gacnik@gmail.com>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Thanks for updating this, applying this into omap fixes.

Regards,

Tony

> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2f88d8d..06d489e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1768,6 +1768,7 @@ source "mm/Kconfig"
>  config FORCE_MAX_ZONEORDER
>  	int "Maximum zone order" if ARCH_SHMOBILE
>  	range 11 64 if ARCH_SHMOBILE
> +	default "12" if SOC_AM33XX
>  	default "9" if SA1111
>  	default "11"
>  	help
