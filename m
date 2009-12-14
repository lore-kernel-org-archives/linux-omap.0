From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/4] ARM: L2 : Errata 588369: Clean & Invalidate do
	notinvalidate clean lines
Date: Mon, 14 Dec 2009 10:37:13 +0000
Message-ID: <1260787034.17159.24.camel@pc1117.cambridge.arm.com>
References: <1260384233-2278-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50101 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752379AbZLNKh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 05:37:28 -0500
In-Reply-To: <1260384233-2278-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Wed, 2009-12-09 at 18:43 +0000, Santosh Shilimkar wrote:
> This patch implements the work-around for the errata 588369. The secure API
> is used to alter L2 debug regsiter because of trust-zone.
[...]
> +config PL310_ERRATA_588369
> +       bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
> +       depends on CACHE_L2X0
> +       default n
> +       help
> +          The PL310 L2 cache controller implements three types of Clean &
> +          Invalidate maintenance operations: by Physical Address
> +          (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
> +          They are architecturally defined to behave as the execution of a
> +          clean operation followed immediately by an invalidate operation,
> +          both performing to the same memory location. This functionality
> +          is not correctly implemented in PL310 as clean lines are not
> +          invalidated as a result of these operations
>  endmenu

Could you actually add a comment and a dependence on OMAP4 since this
requires the secure monitor that only TI has.
> 
> +#ifdef CONFIG_PL310_ERRATA_588369
> +       /*
> +        * Disable Write-Back and Cache Linefill (set bits [1:0] of the Debug
> +        * Control Register)
> +        */
> +       __asm__ __volatile__(
> +       "stmfd r13!, {r0-r12, r14}\n"
> +       "mov r0, #3\n"
> +       "ldr r12, =0x100\n"
> +       "dsb\n"
> +       "smc\n"
> +       "ldmfd r13!, {r0-r12, r14}");

Could you actually add a function that gets called with a parameter
rather than having to similar inline asm blocks? You also don't need to
save/restore the registers if you declare them properly or use local
variables for that, the compiler does the work for you.

Is a DSB needed before SMC (I'm not sure)?

-- 
Catalin

