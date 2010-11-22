From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 16:23:39 +0530
Message-ID: <21f7524db02d0a4c2a9f71587937d200@mail.gmail.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:48264 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753715Ab0KVKxl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 05:53:41 -0500
Received: by mail-qy0-f173.google.com with SMTP id 1so656181qyk.4
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 02:53:40 -0800 (PST)
In-Reply-To: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org
Cc: Jean Pihet-XID <j-pihet@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jean Pihet
> Sent: Monday, November 22, 2010 4:15 PM
> To: linux-omap@vger.kernel.org
> Cc: Jean Pihet; Kevin Hilman
> Subject: [PATCH] OMAP3: disable idle early in the suspend sequence
>
> Some bad interaction between the idle and the suspend paths has been
> noticed: the idle code is called during the suspend enter and exit
> sequences. This could cause corruption or lock-up of resources.

Can you elaborate more on what kind of issues were seen?

>
> The solution is to move the call to disable_hlt at the very beginning
> of the suspend sequence (in omap3_pm_begin instead of omap3_pm_prepare),
> and the call to enable_hlt at the very end of the suspend sequence
> (in omap3_pm_end instead of omap3_pm_finish).
>
> Tested with RET and OFF on Beagle and OMAP3EVM.
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
>
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
>
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
