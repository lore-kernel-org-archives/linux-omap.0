From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: plat-omap: counter_32k: use IS_ERR() instead of
 NULL check
Date: Mon, 6 Dec 2010 15:51:58 -0800
Message-ID: <20101206235158.GU8345@atomide.com>
References: <1290791163-21190-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1290791163-21190-1-git-send-email-segoon@openwall.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: kernel-janitors@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vasiliy Kulikov <segoon@openwall.com> [101126 08:56]:
> clk_get() returns ERR_PTR() on error, not NULL.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile this driver, so it is not tested at all.

Thanks will merge this.

Tony

> 
>  arch/arm/plat-omap/counter_32k.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index 155fe43..c1e0d00 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -164,7 +164,7 @@ static int __init omap_init_clocksource_32k(void)
>  			return -ENODEV;
>  
>  		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> -		if (sync_32k_ick)
> +		if (!IS_ERR(sync_32k_ick))
>  			clk_enable(sync_32k_ick);
>  
>  		clocksource_32k.mult = clocksource_hz2mult(32768,
> -- 
> 1.7.0.4
> 
