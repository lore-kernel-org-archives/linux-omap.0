From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] arm: plat-omap: counter_32k: use IS_ERR() instead of NULL check
Date: Mon, 29 Nov 2010 16:29:22 +0100
Message-ID: <87tyj0ywq5.fsf@deeprootsystems.com>
References: <1290791163-21190-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290791163-21190-1-git-send-email-segoon@openwall.com> (Vasiliy
	Kulikov's message of "Fri, 26 Nov 2010 20:06:02 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Vasiliy Kulikov <segoon@openwall.com> writes:

> clk_get() returns ERR_PTR() on error, not NULL.
>
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  Cannot compile this driver, so it is not tested at all.
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
