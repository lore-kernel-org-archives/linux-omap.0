From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix section mismatch warning on OSK
Date: Tue, 11 Nov 2008 16:29:24 -0800
Message-ID: <20081112002923.GS3984@atomide.com>
References: <deb0f030811111618q5e70e18doeea15271bdb7e2e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64202 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbYKLA31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 19:29:27 -0500
Content-Disposition: inline
In-Reply-To: <deb0f030811111618q5e70e18doeea15271bdb7e2e8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suresh Rajashekara <suresh@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

* Suresh Rajashekara <suresh@mistralsolutions.com> [081111 16:18]:
> Section mismatch warnings when compiling latest git for MACH_OMAP_OSK.
> Missing __initdata on the omap1_clk_functions.
> 
> Signed-off-by: Suresh Rajashekara <suresh@mistralsolutions.com>
> ---
>  arch/arm/mach-omap1/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index 4d0c444..aab7ab1 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -636,7 +636,7 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
>  #define omap1_clk_disable_unused NULL
>  #endif
> 
> -static struct clk_functions omap1_clk_functions = {
> +static struct clk_functions omap1_clk_functions __initdata = {
>   .clk_enable = omap1_clk_enable,
>   .clk_disable = omap1_clk_disable,
>   .clk_round_rate = omap1_clk_round_rate,

This struct cannot be __initdata, it is used by plat-omap/clock.c as
arch_clock.

Tony
