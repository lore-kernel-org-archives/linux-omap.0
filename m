From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: Fix crash due to wrong arg to
 __omap_dm_timer_read_counter
Date: Thu, 26 Jan 2012 15:30:01 -0800
Message-ID: <20120126233001.GB29812@atomide.com>
References: <1327301294-18458-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29042 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab2AZXaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 18:30:04 -0500
Content-Disposition: inline
In-Reply-To: <1327301294-18458-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120122 22:17]:
> In dmtimer_read_sched_clock(), wrong argument was getting passed to
> __omap_dm_timer_read_counter() function call; instead of "&clksrc",
> we were passing "clksrc.io_base", which results into kernel crash.
> 
> To reproduce kernel crash, just disable the CONFIG_OMAP_32K_TIMER config
> option (and DEBUG_LL) and build/boot the kernel.
> This will use dmtimer as a kernel clocksource and lead to kernel
> crash during boot  -
> 
> [    0.000000] OMAP clocksource: GPTIMER2 at 26000000 Hz
> [    0.000000] sched_clock: 32 bits at 26MHz, resolution 38ns, wraps every
> 165191ms
> [    0.000000] Unable to handle kernel paging request at virtual address
> 00030ef1
> [    0.000000] pgd = c0004000
> [    0.000000] [00030ef1] *pgd=00000000
> [    0.000000] Internal error: Oops: 5 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0    Not tainted  (3.3.0-rc1-11574-g0c76665-dirty #3)
> [    0.000000] PC is at dmtimer_read_sched_clock+0x18/0x4c
> [    0.000000] LR is at update_sched_clock+0x10/0x84
> [    0.000000] pc : [<c00243b8>]    lr : [<c0018684>]    psr: 200001d3
> [    0.000000] sp : c0641f38  ip : c0641e18  fp : 0000000a
> [    0.000000] r10: 151c3303  r9 : 00000026  r8 : 76276259
> [    0.000000] r7 : 00028547  r6 : c065ac80  r5 : 431bde82  r4 : c0655968
> [    0.000000] r3 : 00030ef1  r2 : fb032000  r1 : 00000028  r0 : 00000001

Thanks, applying into fixes.

Tony
 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/timer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 18f7614..5f2873e 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -270,7 +270,7 @@ static struct clocksource clocksource_gpt = {
>  static u32 notrace dmtimer_read_sched_clock(void)
>  {
>  	if (clksrc.reserved)
> -		return __omap_dm_timer_read_counter(clksrc.io_base, 1);
> +		return __omap_dm_timer_read_counter(&clksrc, 1);
> 
>  	return 0;
>  }
> --
> 1.7.0.4
> 
