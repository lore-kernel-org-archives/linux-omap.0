From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] ARM: architected timers: Mark the clockevent with the
 C3_STOP feature
Date: Wed, 04 Jul 2012 10:56:54 +0100
Message-ID: <4FF41366.4060504@arm.com>
References: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50878 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab2GDJ47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:56:59 -0400
In-Reply-To: <1341395673-29660-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 04/07/12 10:54, Santosh Shilimkar wrote:
> ARM arch timers stop in low power state and hence can not wakeup CPUs in
> deeper idle states when used as cloc event devices. Marking these clock event
> devices with C3_STOP so that during lowpower states, the tick is managed by
> wakeup capable broadcast timer.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Santosh,

I already have queued an identical patch from Lorenzo.
Thanks for reminder anyway!

	M.

> ---
>  arch/arm/kernel/arch_timer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
> index dd58035..df44c8c 100644
> --- a/arch/arm/kernel/arch_timer.c
> +++ b/arch/arm/kernel/arch_timer.c
> @@ -137,7 +137,7 @@ static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
>  	/* Be safe... */
>  	arch_timer_disable();
>  
> -	clk->features = CLOCK_EVT_FEAT_ONESHOT;
> +	clk->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP;
>  	clk->name = "arch_sys_timer";
>  	clk->rating = 450;
>  	clk->set_mode = arch_timer_set_mode;


-- 
Jazz is not dead. It just smells funny...

