From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: timer: build with DRA7xx enable but without
 OMAP5
Date: Mon, 30 Sep 2013 14:50:16 +0530
Message-ID: <52494250.6060809@ti.com>
References: <1380532531-21021-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57520 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab3I3JUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Sep 2013 05:20:24 -0400
In-Reply-To: <1380532531-21021-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, OMAP SUPPORT <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

On Monday 30 September 2013 02:45 PM, Sebastian Andrzej Siewior wrote:
> with DRA7xx and without OMAP5 selected we get
> |arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x40): undefined reference to `omap5_realtime_timer_init'
> |make[1]: *** [vmlinux] Error 1
>
> since ARM: DRA7: board-generic: Add basic DT support ("439bf39e").
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: R Sricharan <r.sricharan@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-omap2/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index fa74a06..4fd1816 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -628,7 +628,7 @@ void __init omap4_local_timer_init(void)
>  #endif /* CONFIG_HAVE_ARM_TWD */
>  #endif /* CONFIG_ARCH_OMAP4 */
>  
> -#ifdef CONFIG_SOC_OMAP5
> +#if defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX)
>  void __init omap5_realtime_timer_init(void)
>  {
>  	omap4_sync32k_timer_init();
Yes, this was missing. Thanks for the fix.

Regards,
 Sricharan

