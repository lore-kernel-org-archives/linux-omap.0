From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH RE-SEND-2] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle
	inside each ARCH Kconfig
Date: Fri, 29 Jan 2010 04:29:45 +0000
Message-ID: <20100129042945.GO9153@trinity.fluff.org>
References: <1264641332-30800-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:37672 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab0A2E3t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jan 2010 23:29:49 -0500
Content-Disposition: inline
In-Reply-To: <1264641332-30800-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jan 28, 2010 at 10:15:32AM +0900, Kukjin Kim wrote:
> This patch adds ARM_L1_CACHE_SHIFT_6 into arch/arm/Kconfig. Basically,
> ARM L1 cache line size is 32Bytes. Therefore, whenever new ARCH which
> has 64Bytes L1 cache line size is added, have to set ARM_L1_CACHE_SHIFT
> to 6. That is, have to add/modify arch/arm/mm/Kconfig.
> This patch is for handle it in each ARCH such as ARCH_OMAP3, ARCH_S5PC1XX,
> and ARCH_S5PV210 which is in review.
> This patch also adds selecting ARM_L1_CACHE_SHIFT_6 into Kconfig of
> ARCH_OMAP3 and ARCH_S5PC1XX.

Note, 'this patch' is pretty much redudant, it is common knowledege and
self-evident that this is a patch.

I think the only problem with this patch is that the description could
do with a re-write, as so:

   Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
   L1 cache lines which are 64bytes to indicate this without having to
   alter the arch/arm/mm/Kconfig entry each time.

   Update the mm Kconfig so that  ARM_L1_CACHE_SHIFT default value
   uses this and change OMAP3 and SPC1XX to select ARM_L1_CACHE_SHIFT_6.

 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig           |    6 ++++++
>  arch/arm/mm/Kconfig        |    2 +-
>  arch/arm/plat-omap/Kconfig |    1 +
>  3 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a5602ec..13c07a6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -161,6 +161,11 @@ config ARCH_MTD_XIP
>  config GENERIC_HARDIRQS_NO__DO_IRQ
>  	def_bool y
>  
> +config ARM_L1_CACHE_SHIFT_6
> +	bool
> +	help
> +	  Setting ARM L1 cache line size to 64 Bytes.
> +
>  if OPROFILE
>  
>  config OPROFILE_ARMV6
> @@ -646,6 +651,7 @@ config ARCH_S5PC1XX
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select CPU_V7
> +	select ARM_L1_CACHE_SHIFT_6
>  	help
>  	  Samsung S5PC1XX series based systems
>  
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 91617f7..8ca9fb7 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -779,5 +779,5 @@ config CACHE_XSC3L2
>  
>  config ARM_L1_CACHE_SHIFT
>  	int
> -	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> +	default 6 if ARM_L1_CACHE_SHIFT_6
>  	default 5
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index e2ea04a..2e3eec6 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -22,6 +22,7 @@ config ARCH_OMAP3
>  	bool "TI OMAP3"
>  	select CPU_V7
>  	select COMMON_CLKDEV
> +	select ARM_L1_CACHE_SHIFT_6
>  
>  config ARCH_OMAP4
>  	bool "TI OMAP4"
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

