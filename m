From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
Date: Mon, 11 Jan 2010 14:37:08 +0000
Message-ID: <1263220628.6305.44.camel@pc1117.cambridge.arm.com>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36681 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752255Ab0AKOhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 09:37:35 -0500
In-Reply-To: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, Woodruff Richard <r-woodruff2@ti.com>

On Mon, 2009-12-21 at 10:09 +0000, Santosh Shilimkar wrote:
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index cb8fc65..5443c0d 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -28,6 +28,24 @@
>  static void __iomem *l2x0_base;
>  static DEFINE_SPINLOCK(l2x0_lock);
> 
> +#ifdef CONFIG_PL310_ERRATA_588369
> +static void debug_writel(unsigned long val)
> +{
> +       register unsigned long r0 asm("r0") = val;
> +       /*
> +        * Texas Instrument secure monitor api to modify the PL310
> +        * Debug Control Register.
> +        */
> +       __asm__ __volatile__(
> +               __asmeq("%0", "r0")
> +               "ldr r12, =0x100\n"
> +               "dsb\n"
> +               "smc\n"
> +               : : "r" (r0)
> +               : "r4", "r5", "r6", "r7", "r8");

Does your secure monitor corrupt r4-r8? Maybe you could add a comment
with a few words on this API.

Do you need to specify "r12" as well? What about "cc", are they
preserved by the secure monitor?

> @@ -139,7 +184,12 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>                         spin_lock_irqsave(&l2x0_lock, flags);
>                 }
>         }
> +#ifdef CONFIG_PL310_ERRATA_588369
> +       cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
> +       cache_wait(base + L2X0_INV_LINE_PA, 1);
> +#else
>         cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> +#endif

I don't think we need to way on two separate registers here. AFAICT, bit
1 of those registers is shared for all the operations.

As a general comment, maybe an inline function called something like
wait_writel(before/after) would be better than a lot of ifdefs in the
code, especially if one has a different workaround other than using TI's
secure monitor.

-- 
Catalin

