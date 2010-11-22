From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 09:51:15 -0800
Message-ID: <87y68luu0c.fsf@deeprootsystems.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44112 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756026Ab0KVRvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 12:51:21 -0500
Received: by gyb11 with SMTP id 11so1475482gyb.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 09:51:20 -0800 (PST)
In-Reply-To: <1290422697-2300-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Mon, 22 Nov 2010 11:44:57 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Some bad interaction between the idle and the suspend paths has been
> noticed: the idle code is called during the suspend enter and exit
> sequences. This could cause corruption or lock-up of resources.

> The solution is to move the call to disable_hlt at the very beginning
> of the suspend sequence (in omap3_pm_begin instead of omap3_pm_prepare),
> and the call to enable_hlt at the very end of the suspend sequence
> (in omap3_pm_end instead of omap3_pm_finish).
>
> Tested with RET and OFF on Beagle and OMAP3EVM.

I think the description could have a little more detail.  Something like:

Idle path should be disabled during the entire suspend/resume sequence.
Currently it is disabled in ->prepare() and re-enabled in ->finish(),
but the suspend sequence starts with ->begin() and ends with ->end(),
leaving windows where the suspend/resume sequence is still underway and
idle code could execute.

To fix, move idle disable and enable into ->begin() and ->end()
respectively to ensure idle path is disabled for the entire
suspend/resume sequence.

>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 75c0cd1..022fdff 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -508,7 +508,6 @@ static suspend_state_t suspend_state;
>  
>  static int omap3_pm_prepare(void)
>  {
> -	disable_hlt();
>  	return 0;
>  }
>  
> @@ -576,12 +575,12 @@ static int omap3_pm_enter(suspend_state_t unused)
>  
>  static void omap3_pm_finish(void)
>  {
> -	enable_hlt();
>  }

Might as well remove these empty functions now.

>  /* Hooks to enable / disable UART interrupts during suspend */
>  static int omap3_pm_begin(suspend_state_t state)
>  {
> +	disable_hlt();
>  	suspend_state = state;
>  	omap_uart_enable_irqs(0);
>  	return 0;
> @@ -591,6 +590,7 @@ static void omap3_pm_end(void)
>  {
>  	suspend_state = PM_SUSPEND_ON;
>  	omap_uart_enable_irqs(1);
> +	enable_hlt();
>  	return;
>  }

Kevin
