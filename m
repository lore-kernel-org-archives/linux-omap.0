From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix compile-time warning
Date: Wed, 20 Aug 2008 15:30:48 +0300
Message-ID: <20080820123047.GK29374@atomide.com>
References: <premi@ti.com> <1219170601-23337-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63946 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYHTMbC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 08:31:02 -0400
Content-Disposition: inline
In-Reply-To: <1219170601-23337-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

* Sanjeev Premi <premi@ti.com> [080819 21:32]:
> Fixes this warning:
>   CC      arch/arm/mach-omap2/board-omap3evm-flash.o
> arch/arm/mach-omap2/board-omap3evm-flash.c:61: warning: initialization from incompatible pointer type

Pushing today.

Tony

> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm-flash.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm-flash.c b/arch/arm/mach-omap2/board-omap3evm-flash.c
> index 0aa8ef2..5f3663d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm-flash.c
> +++ b/arch/arm/mach-omap2/board-omap3evm-flash.c
> @@ -23,7 +23,7 @@
>  #include <mach/gpmc.h>
>  #include <mach/nand.h>
>  
> -static int omap3evm_onenand_setup(void __iomem *);
> +static int omap3evm_onenand_setup(void __iomem *, int freq);
>  
>  static struct mtd_partition omap3evm_onenand_partitions[] = {
>  	{
> @@ -76,8 +76,8 @@ static struct platform_device omap3evm_onenand_device = {
>   *
>   */
>  
> -static int omap3evm_onenand_setup(void __iomem *onenand_base)
> -	{
> +static int omap3evm_onenand_setup(void __iomem *onenand_base, int freq)
> +{
>  	/* nothing is required to be setup for onenand as of now */
>  	return 0;
>  }
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
