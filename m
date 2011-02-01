From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2+: remove unused UART base addresses from omap_globals
Date: Tue, 01 Feb 2011 14:24:29 -0800
Message-ID: <87fws7pf4y.fsf@ti.com>
References: <1295649015-26348-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38909 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751613Ab1BAWYc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 17:24:32 -0500
Received: by mail-iw0-f182.google.com with SMTP id 39so7134572iwn.13
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 14:24:31 -0800 (PST)
In-Reply-To: <1295649015-26348-1-git-send-email-khilman@ti.com> (Kevin
	Hilman's message of "Fri, 21 Jan 2011 14:30:15 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Now that omap_hwmod + omap_device is used for OMAP UART device and
> driver code, we no longer need the UART physical addresses in
> omap_globals.
>
> Note that the #defines for the base addresses are still left in
> <plat/serial.h> since they are used by DEBUG_LL and uncompress code.
>
> Build tested for OMAP1 (omap1_defconfig) and OMAP2+ (omap2plus_defconfig)
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies on Tony's for-next branch.

For the benefit of the archives, queuing for 2.6.39 (branch:
for_2.6.39/pm-misc)

Kevin

>  arch/arm/mach-omap2/common.c             |   14 --------------
>  arch/arm/plat-omap/include/plat/common.h |    4 ----
>  2 files changed, 0 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
> index d5eaee3..8044c8a 100644
> --- a/arch/arm/mach-omap2/common.c
> +++ b/arch/arm/mach-omap2/common.c
> @@ -50,9 +50,6 @@ static struct omap_globals omap242x_globals = {
>  	.ctrl	= OMAP242X_CTRL_BASE,
>  	.prm	= OMAP2420_PRM_BASE,
>  	.cm	= OMAP2420_CM_BASE,
> -	.uart1_phys	= OMAP2_UART1_BASE,
> -	.uart2_phys	= OMAP2_UART2_BASE,
> -	.uart3_phys	= OMAP2_UART3_BASE,
>  };
>  
>  void __init omap2_set_globals_242x(void)
> @@ -71,9 +68,6 @@ static struct omap_globals omap243x_globals = {
>  	.ctrl	= OMAP243X_CTRL_BASE,
>  	.prm	= OMAP2430_PRM_BASE,
>  	.cm	= OMAP2430_CM_BASE,
> -	.uart1_phys	= OMAP2_UART1_BASE,
> -	.uart2_phys	= OMAP2_UART2_BASE,
> -	.uart3_phys	= OMAP2_UART3_BASE,
>  };
>  
>  void __init omap2_set_globals_243x(void)
> @@ -92,10 +86,6 @@ static struct omap_globals omap3_globals = {
>  	.ctrl	= OMAP343X_CTRL_BASE,
>  	.prm	= OMAP3430_PRM_BASE,
>  	.cm	= OMAP3430_CM_BASE,
> -	.uart1_phys	= OMAP3_UART1_BASE,
> -	.uart2_phys	= OMAP3_UART2_BASE,
> -	.uart3_phys	= OMAP3_UART3_BASE,
> -	.uart4_phys	= OMAP3_UART4_BASE,	/* Only on 3630 */
>  };
>  
>  void __init omap2_set_globals_3xxx(void)
> @@ -119,10 +109,6 @@ static struct omap_globals omap4_globals = {
>  	.prm	= OMAP4430_PRM_BASE,
>  	.cm	= OMAP4430_CM_BASE,
>  	.cm2	= OMAP4430_CM2_BASE,
> -	.uart1_phys	= OMAP4_UART1_BASE,
> -	.uart2_phys	= OMAP4_UART2_BASE,
> -	.uart3_phys	= OMAP4_UART3_BASE,
> -	.uart4_phys	= OMAP4_UART4_BASE,
>  };
>  
>  void __init omap2_set_globals_443x(void)
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
> index 29b2afb..1b8095b 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -56,10 +56,6 @@ struct omap_globals {
>  	unsigned long   prm;            /* Power and Reset Management */
>  	unsigned long   cm;             /* Clock Management */
>  	unsigned long   cm2;
> -	unsigned long	uart1_phys;
> -	unsigned long	uart2_phys;
> -	unsigned long	uart3_phys;
> -	unsigned long	uart4_phys;
>  };
>  
>  void omap2_set_globals_242x(void);
