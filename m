From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Correcting the gpmc prefetch control register
	address
Date: Fri, 2 May 2008 16:29:20 -0700
Message-ID: <20080502232919.GC8981@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB2E7A2591@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65406 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759571AbYEBX3U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 19:29:20 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB2E7A2591@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Gopinath, Thara <thara@ti.com> [080428 04:25]:
> From: Thara Gopinath <thara@ti.com>
> 
> Correcting the GPMC_PREFETCH_CONTROL register address

Pushing today.

Tony


> Signed-off-by: Thara Gopinath <thara@ti.com>
> Index: linux-omap-2.6/arch/arm/mach-omap2/gpmc.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/gpmc.c      2008-04-28 16:07:01.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/gpmc.c   2008-04-28 16:09:06.246933117 +0530
> @@ -41,7 +41,7 @@
>  #define GPMC_STATUS            0x54
>  #define GPMC_PREFETCH_CONFIG1  0x1e0
>  #define GPMC_PREFETCH_CONFIG2  0x1e4
> -#define GPMC_PREFETCH_CONTROL  0x1e8
> +#define GPMC_PREFETCH_CONTROL  0x1ec
>  #define GPMC_PREFETCH_STATUS   0x1f0
>  #define GPMC_ECC_CONFIG                0x1f4
>  #define GPMC_ECC_CONTROL       0x1f8
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
