From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/3] OMAP4: Add L2 Cache support
Date: Fri, 29 Jan 2010 12:16:05 +0000
Message-ID: <1264767365.4242.54.camel@pc1117.cambridge.arm.com>
References: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37479 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753412Ab0A2MQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jan 2010 07:16:25 -0500
In-Reply-To: <1264765589-18353-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, 2010-01-29 at 11:46 +0000, Santosh Shilimkar wrote:
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -28,6 +28,7 @@
>  #include <plat/control.h>
>  #include <plat/timer-gp.h>
>  #include <asm/hardware/gic.h>
> +#include <asm/hardware/cache-l2x0.h>
> 
>  static struct platform_device sdp4430_lcd_device = {
>         .name           = "sdp4430_lcd",
> @@ -49,6 +50,38 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
>  static struct omap_board_config_kernel sdp4430_config[] __initdata = {
>         { OMAP_TAG_LCD,         &sdp4430_lcd_config },
>  };
> +#ifdef CONFIG_CACHE_L2X0
> +static int __init omap_l2_cache_init(void)
> +{
> +       void __iomem *l2cache_base;
> +
> +       /* Static mapping, never released */
> +       l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
> +       BUG_ON(!l2cache_base);
> +
> +       /* Enable L2 Cache using secure api
> +        * r0 contains the value to be modified and "r12" contains
> +        * the monitor API number. This API uses few CPU registers
> +        * internally and hence they need be backed up including
> +        * link register "lr".
> +        */
> +       __asm__ __volatile__(
> +               "stmfd r13!, {r0-r12, r14}\n"
> +               "mov r0, #1\n"
> +               "ldr r12, =0x102\n"
> +               "dsb\n"
> +               "smc\n"
> +               "ldmfd r13!, {r0-r12, r14}");

Same comments as on the cache-l2x0.c changes - can you not let the
compiler choose what to saved by declaring the clobbered register in the
asm directive?

-- 
Catalin

