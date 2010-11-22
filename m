From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: disable idle during the entire suspend/resume sequence
Date: Mon, 22 Nov 2010 14:12:43 -0800
Message-ID: <87pqtxnh2c.fsf@deeprootsystems.com>
References: <1290454603-5513-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65447 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab0KVWMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 17:12:48 -0500
Received: by vws13 with SMTP id 13so3833474vws.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 14:12:47 -0800 (PST)
In-Reply-To: <1290454603-5513-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Mon, 22 Nov 2010 20:36:43 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Idle path should be disabled during the entire suspend/resume sequence.
> Currently it is disabled in ->prepare() and re-enabled in ->finish(),
> but the suspend sequence starts with ->begin() and ends with ->end(),
> leaving windows where the suspend/resume sequence is still underway and
> idle code could execute.
>
> The fix is to move the idle disable (disable_hlt) and enable (enable_hlt)
> into ->begin() and ->end() respectively to ensure that the idle path
> is disabled for the entire suspend/resume sequence.
> Remvoving omap3_pm_prepare and omap3_pm_finish since there are now empty.
>
> Tested with RET and OFF on Beagle and OMAP3EVM.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Comment rework suggested by Kevin.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, 

Unless there are any objections, I'll queue for .38 instead of .37-rc
since this isn't technically a regression.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   15 ++-------------
>  1 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 75c0cd1..2e0621e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -506,12 +506,6 @@ out:
>  #ifdef CONFIG_SUSPEND
>  static suspend_state_t suspend_state;
>  
> -static int omap3_pm_prepare(void)
> -{
> -	disable_hlt();
> -	return 0;
> -}
> -
>  static int omap3_pm_suspend(void)
>  {
>  	struct power_state *pwrst;
> @@ -574,14 +568,10 @@ static int omap3_pm_enter(suspend_state_t unused)
>  	return ret;
>  }
>  
> -static void omap3_pm_finish(void)
> -{
> -	enable_hlt();
> -}
> -
>  /* Hooks to enable / disable UART interrupts during suspend */
>  static int omap3_pm_begin(suspend_state_t state)
>  {
> +	disable_hlt();
>  	suspend_state = state;
>  	omap_uart_enable_irqs(0);
>  	return 0;
> @@ -591,15 +581,14 @@ static void omap3_pm_end(void)
>  {
>  	suspend_state = PM_SUSPEND_ON;
>  	omap_uart_enable_irqs(1);
> +	enable_hlt();
>  	return;
>  }
>  
>  static struct platform_suspend_ops omap_pm_ops = {
>  	.begin		= omap3_pm_begin,
>  	.end		= omap3_pm_end,
> -	.prepare	= omap3_pm_prepare,
>  	.enter		= omap3_pm_enter,
> -	.finish		= omap3_pm_finish,
>  	.valid		= suspend_valid_only_mem,
>  };
>  #endif /* CONFIG_SUSPEND */
