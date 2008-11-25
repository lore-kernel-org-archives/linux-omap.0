From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Typo fix for clock_allow_idle
Date: Tue, 25 Nov 2008 15:12:57 -0800
Message-ID: <20081125231256.GY11997@atomide.com>
References: <1222068189-10663-1-git-send-email-kucheria.amit@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58318 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYKYXM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 18:12:58 -0500
Content-Disposition: inline
In-Reply-To: <1222068189-10663-1-git-send-email-kucheria.amit@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kucheria.amit@gmail.com
Cc: linux-omap@vger.kernel.org, Amit Kucheria <amit.kucheria@verdurent.com>

* kucheria.amit@gmail.com <kucheria.amit@gmail.com> [080922 00:23]:
> From: Amit Kucheria <amit.kucheria@verdurent.com>

Pushing today & adding to omap-fixes queue. Sorry for the delay on this one.

Tony

> Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
> ---
>  arch/arm/plat-omap/include/mach/pm.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
> index e4cf1c5..15c19f0 100644
> --- a/arch/arm/plat-omap/include/mach/pm.h
> +++ b/arch/arm/plat-omap/include/mach/pm.h
> @@ -131,7 +131,7 @@ void clk_deny_idle(struct clk *clk);
>   * clk_allow_idle - Counters previous clk_deny_idle
>   * @clk: clock signal handle
>   */
> -void clk_deny_idle(struct clk *clk);
> +void clk_allow_idle(struct clk *clk);
>  
>  extern void omap_pm_idle(void);
>  extern void omap_pm_suspend(void);
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
