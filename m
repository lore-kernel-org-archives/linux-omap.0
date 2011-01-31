From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/6] omap4: dpll: Enable all DPLL autoidle at boot
Date: Mon, 31 Jan 2011 16:17:25 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101311614570.16671@utopia.booyaka.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com> <1296212688-21951-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58464 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab1AaXR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 18:17:26 -0500
In-Reply-To: <1296212688-21951-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi guys

On Fri, 28 Jan 2011, Santosh Shilimkar wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Enable all DPLL autoidle at boot on OMAP4.

Is there some reason why we can't do this in the OMAP4 PM code?  At some 
point, I think it would be good to essentially disable all PM at boot, and 
then let the PM code specifically enable autoidle later in the boot 
process, etc.  The idea being that !CONFIG_PM would result in a chip 
programmed for lowest latency, etc.

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index e8cb32f..e5c59a0 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3300,6 +3300,8 @@ int __init omap4xxx_clk_init(void)
>  			clkdev_add(&c->lk);
>  			clk_register(c->lk.clk);
>  			omap2_init_clk_clkdm(c->lk.clk);
> +			if (c->lk.clk->dpll_data)
> +				omap3_dpll_allow_idle(c->lk.clk);
>  		}
>  
>  	recalculate_root_clocks();
> -- 
> 1.6.0.4
> 


- Paul
