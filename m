From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: fix: replace PTR_RET with
 PTR_ERR_OR_ZERO
Date: Fri, 18 Apr 2014 15:49:19 -0700
Message-ID: <20140418224919.GO21823@atomide.com>
References: <1397210608-28318-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35418 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752779AbaDRWt0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2014 18:49:26 -0400
Content-Disposition: inline
In-Reply-To: <1397210608-28318-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Cc: khilman@deeprootsystems.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

* Duan Jiong <duanj.fnst@cn.fujitsu.com> [140411 03:10]:
> PTR_RET is deprecated. Do not recommend its usage anymore.
> Use PTR_ERR_OR_ZERO instead.
> 
> Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> ---
>  arch/arm/mach-omap2/gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index ab43755..6a11bda 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1772,7 +1772,7 @@ static int __init omap_gpmc_init(void)
>  	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0);
>  	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
>  
> -	return PTR_RET(pdev);
> +	return PTR_ERR_OR_ZERO(pdev);
>  }
>  omap_postcore_initcall(omap_gpmc_init);

OK looks like we have #define PTR_RET(p) PTR_ERR_OR_ZERO(p).
But what about the others? How about a single patch to deal
with them all?

$ git grep PTR_RET arch/arm/*omap*
arch/arm/mach-omap2/devices.c:  return PTR_RET(pdev);
arch/arm/mach-omap2/devices.c:  return PTR_RET(pdev);
arch/arm/mach-omap2/fb.c:       return PTR_RET(pdev);
arch/arm/mach-omap2/pmu.c:      return PTR_RET(omap_pmu_dev);

Regards,

Tony
