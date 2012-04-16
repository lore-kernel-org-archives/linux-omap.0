From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/3] ARM: OMAP2+: dmtimer: cleanup iclk usage
Date: Mon, 16 Apr 2012 15:03:54 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9EE79A@DBDE01.ent.ti.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
 <1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48140 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab2DPPEB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 11:04:01 -0400
In-Reply-To: <1334579125-15566-3-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Mon, Apr 16, 2012 at 17:55:24, DebBarma, Tarun Kanti wrote:
> We do not use iclk anywhere in the dmtimer driver and so removing it.
> Hence removing the timer iclk entries from OMAP4 clkdev table as well.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c      |   11 -----------
>  arch/arm/mach-omap2/timer.c               |    7 -------
>  arch/arm/plat-omap/include/plat/dmtimer.h |    2 +-
>  3 files changed, 1 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index fa6ea65..2172f66 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3355,17 +3355,6 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
>  	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
>  	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt3_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt4_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt5_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt6_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt7_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt8_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt9_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt10_ick",			&dummy_ck,	CK_443X),
> -	CLK(NULL,	"gpt11_ick",			&dummy_ck,	CK_443X),
>  	CLK("omap_i2c.1",	"ick",				&dummy_ck,	CK_443X),
>  	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_443X),
>  	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_443X),
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index c512bac..5d7a0ee 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -169,13 +169,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  	if (IS_ERR(timer->fclk))
>  		return -ENODEV;
>  
> -	sprintf(name, "gpt%d_ick", gptimer_id);
> -	timer->iclk = clk_get(NULL, name);
> -	if (IS_ERR(timer->iclk)) {
> -		clk_put(timer->fclk);
> -		return -ENODEV;
> -	}
> -

Doesn't this impact OMAP3x family?
The interface clocks will be enabled in omap_hwmod_enable(), 
only if you set OCPIF_SWSUP_IDLE flag.

Thanks,
Vaibhav

>  	omap_hwmod_enable(oh);

