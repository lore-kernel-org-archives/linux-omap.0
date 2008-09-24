From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 06:51:37 +0300 (EEST)
Message-ID: <20080924.065137.142952786.Hiroshi.DOYU@nokia.com>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43664 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbYIXDwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 23:52:21 -0400
In-Reply-To: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arunks@mistralsolutions.com, Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org

Hi,

How about introducing a new typedef in order to accommodate the
different size of enable_regs without ifdefs?

I think that this is apparently the case categorized into (a) in
'CodyingStyle'.

     Hiroshi DOYU

From: "ext Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Tue, 23 Sep 2008 20:53:09 +0530

> This patch is a temporary fix for a kernel panic causing at omap1_clk_init
> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  arch/arm/plat-omap/include/mach/clock.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/clock.h
> b/arch/arm/plat-omap/include/mach/clock.h
> index f26ad8c..b9c471e 100644
> --- a/arch/arm/plat-omap/include/mach/clock.h
> +++ b/arch/arm/plat-omap/include/mach/clock.h
> @@ -67,7 +67,11 @@ struct clk {
>  	struct clk		*parent;
>  	unsigned long		rate;
>  	__u32			flags;
> +#if defined(CONFIG_ARCH_OMAP1)
> +	void __iomem            *enable_reg;
> +#elif
>  	u16			enable_reg;
> +#endif
>  	__u8			enable_bit;
>  	__s8			usecount;
>  	u8			idlest_bit;
> -- 
> 1.5.3.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
