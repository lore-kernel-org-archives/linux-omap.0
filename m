From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 01:43:40 +0300
Message-ID: <20080923224339.GI10156@frodo>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42198 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYIWWnr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 18:43:47 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Sep 23, 2008 at 08:53:09PM +0530, Arun KS wrote:
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

Did you try removing those (void __iomem *) casts from
arch/arm/mach-omap1/clock.h ??

with vim you can fix it by:

:%s/(void\ __iomem\ \*)//g

-- 
balbi
