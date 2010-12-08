From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP2+: disable idle early in the suspend sequence
Date: Wed, 08 Dec 2010 15:01:22 -0800
Message-ID: <87ei9rg98d.fsf@deeprootsystems.com>
References: <1291799364-23154-1-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:36903 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab0LHXB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 18:01:27 -0500
Received: by gwb20 with SMTP id 20so1497845gwb.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 15:01:26 -0800 (PST)
In-Reply-To: <1291799364-23154-1-git-send-email-jean.pihet@newoldbits.com>
	(jean pihet's message of "Wed, 8 Dec 2010 10:09:24 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Some bad interaction between the idle and the suspend paths has been
> noticed: the idle code is called during the suspend enter and exit
> sequences. This could cause corruption or lock-up of resources.
>
> The solution is to move the calls to disable_hlt at the very beginning
> of the suspend sequence (ex. in omap3_pm_begin instead of
> omap3_pm_prepare), and the call to enable_hlt at the very end of
> the suspend sequence (ex. in omap3_pm_end instead of omap3_pm_finish).

In an earlier version, I thought we agreed to just remove the empty
prepare/finish calls.  Can you do that?

Also, can you base this on top of my recently posted patch:

[PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire during suspend

since it touches some of the same code for pm24xx.c

Thanks,

Kevin

> Tested with RET and OFF on Beagle and OMAP3EVM.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> v1: support for OMAP3 only.
>  Tested on board.
>
> v2: Added support for OMAP2 and OMAP4.
>  Compile tested only for OMAP2 and OMAP4.
>  Tested on board for OMAP3.
>
>  arch/arm/mach-omap2/pm24xx.c |   16 ++++++++++++++--
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  arch/arm/mach-omap2/pm44xx.c |    4 ++--
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index c85923e..3820179 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -286,8 +286,6 @@ out:
>  
>  static int omap2_pm_prepare(void)
>  {
> -	/* We cannot sleep in idle until we have resumed */
> -	disable_hlt();
>  	return 0;
>  }
>
> @@ -330,10 +328,24 @@ static int omap2_pm_enter(suspend_state_t state)
>  
>  static void omap2_pm_finish(void)
>  {
> +}
>
> +
> +static int omap2_pm_begin(suspend_state_t state)
> +{
> +	/* We cannot sleep in idle until we have resumed */
> +	disable_hlt();
> +	return 0;
> +}
> +
> +static void omap2_pm_end(void)
> +{
>  	enable_hlt();
> +	return;
>  }
>  
>  static struct platform_suspend_ops omap_pm_ops = {
> +	.begin		= omap2_pm_begin,
> +	.end		= omap2_pm_end,
>  	.prepare	= omap2_pm_prepare,
>  	.enter		= omap2_pm_enter,
>  	.finish		= omap2_pm_finish,
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0ec8a04..ec80d38 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -518,7 +518,6 @@ static suspend_state_t suspend_state;
>  
>  static int omap3_pm_prepare(void)
>  {
> -	disable_hlt();
>  	return 0;
>  }
>  
> @@ -586,12 +585,12 @@ static int omap3_pm_enter(suspend_state_t unused)
>  
>  static void omap3_pm_finish(void)
>  {
> -	enable_hlt();
>  }
>  
>  /* Hooks to enable / disable UART interrupts during suspend */
>  static int omap3_pm_begin(suspend_state_t state)
>  {
> +	disable_hlt();
>  	suspend_state = state;
>  	omap_uart_enable_irqs(0);
>  	return 0;
> @@ -601,6 +600,7 @@ static void omap3_pm_end(void)
>  {
>  	suspend_state = PM_SUSPEND_ON;
>  	omap_uart_enable_irqs(1);
> +	enable_hlt();
>  	return;
>  }
>  
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 54544b4..f4c4fab 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -33,7 +33,6 @@ static LIST_HEAD(pwrst_list);
>  #ifdef CONFIG_SUSPEND
>  static int omap4_pm_prepare(void)
>  {
> -	disable_hlt();
>  	return 0;
>  }
>  
> @@ -61,17 +60,18 @@ static int omap4_pm_enter(suspend_state_t suspend_state)
>  
>  static void omap4_pm_finish(void)
>  {
> -	enable_hlt();
>  	return;
>  }
>  
>  static int omap4_pm_begin(suspend_state_t state)
>  {
> +	disable_hlt();
>  	return 0;
>  }
>  
>  static void omap4_pm_end(void)
>  {
> +	enable_hlt();
>  	return;
>  }
