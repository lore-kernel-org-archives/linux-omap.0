From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/9] ARM: OMAP: Fix hsmmc init
Date: Wed, 28 Jan 2009 19:08:02 +0000
Message-ID: <20090128190802.GE23301@n2100.arm.linux.org.uk>
References: <20090128181931.21007.73744.stgit@localhost> <20090128182935.21007.41010.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41947 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbZA1TIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 14:08:13 -0500
Content-Disposition: inline
In-Reply-To: <20090128182935.21007.41010.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 10:29:35AM -0800, Tony Lindgren wrote:
> It accidentally broke while changing the name for the driver
> to not to conflict with the other mmc driver.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/plat-omap/devices.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index ac15c23..d22529c 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -205,9 +205,15 @@ int __init omap_mmc_add(int id, unsigned long base, unsigned long size,
>  {
>  	struct platform_device *pdev;
>  	struct resource res[OMAP_MMC_NR_RES];
> +	char *name;
>  	int ret;
>  
> -	pdev = platform_device_alloc("mmci-omap", id);
> +	if (cpu_class_is_omap1() || cpu_is_omap242x())
> +		name = "mmci-omap";
> +	else
> +		name = "mmci-omap-hs";
> +
> +	pdev = platform_device_alloc(name, id);
>  	if (!pdev)
>  		return -ENOMEM;
>  

This is error prone.  I suggest instead:

int __init omap_mmc_add(const char *name, int id, unsigned long base,
		unsigned long size, unsigned int irq,
		struct omap_mmc_platform_data *data)

and moving that conditional up a level - OMAP1 not having it conditional,
and OMAP2 having the condition there along side the other in
omap2_init_mmc.

And, it's already in error.  Look at these two conditionals closely:

from plat-omap/devices.c:
+	if (cpu_class_is_omap1() || cpu_is_omap242x())
+		name = "mmci-omap";
+	else
+		name = "mmci-omap-hs";

and from mach-omap2/devices.c::omap2_init_mmc():
                if (cpu_is_omap2420())
                        size = OMAP2420_MMC_SIZE;
                else
                        size = HSMMC_SIZE;

These disagree about which CPUs have HSMMC and which don't.
