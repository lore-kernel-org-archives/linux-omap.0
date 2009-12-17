From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4 v2] ARM: L2 : Errata 588369: Clean & Invalidate do
	not invalidate clean lines
Date: Thu, 17 Dec 2009 13:35:08 +0000
Message-ID: <20091217133508.GA5813@n2100.arm.linux.org.uk>
References: <1261054832-14995-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34096 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935415AbZLQNfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 08:35:33 -0500
Content-Disposition: inline
In-Reply-To: <1261054832-14995-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux-omap@vger.kernel.org, Woodruff Richard <r-woodruff2@ti.com>, Catalin Marinas <catalin.marinas@arm.com>

On Thu, Dec 17, 2009 at 06:30:32PM +0530, Santosh Shilimkar wrote:
> +config PL310_ERRATA_588369
> +	bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
> +	depends on CACHE_L2X0 && ARCH_OMAP4
> +	default n

default n is the default anyway, so its redundant to specify it.

> +#ifdef CONFIG_PL310_ERRATA_588369
> +static void debug_writel(unsigned long val)
> +{
> +	/*
> +	 * Texas Instrument secure monitor api to modify the PL310
> +	 * Debug Control Register. R0 = val
> +	 */
> +	__asm__ __volatile__(
> +	"stmfd r13!, {r4-r8}\n"
> +	"ldr r12, =0x100\n"
> +	"dsb\n"
> +	"smc\n"
> +	"ldmfd r13!, {r4-r8}");

Just tell the compiler that r4 to r8 are clobbered - then it'll save and
restore them itself.  Also, you can't guarantee that r0 will contain the
value unless you explicitly pass it in.  IOW:

	register unsigned long r0 asm("r0") = val;

	asm volatile(
	__asmeq(%0, r0)
	"..."
	: : "r" (r0)
	: "r4", "r5", "r6", "r7", "r8");

The use of asmeq will also ensure that '%0' is indeed r0 - some gcc
versions are buggy.

As I've said before, your patch is fine for the current version, but
not for the other cache-l2x0 changes.
