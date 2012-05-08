From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
 address space.
Date: Tue, 8 May 2012 13:41:16 +0100
Message-ID: <20120508124116.GE17798@arm.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45034 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754550Ab2EHMlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 08:41:46 -0400
Content-Disposition: inline
In-Reply-To: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>, Russell King <linux@arm.linux.org.uk>

On Mon, May 07, 2012 at 02:42:29PM +0100, Santosh Shilimkar wrote:
> From: R Sricharan <r.sricharan@ti.com>
> 
> ARM decompressor code setups entire 4GB address space pages.
> Out of the 4GB, about 256MB are setup with normal memory attributes
> for needed DRAM and the rest of the address space as Strongly ordered.
> 
> But since all the sections are mapped in DOMAIN0(Manager), processor
> like Cortex-A15, can speculatively prefetch from non-DRAM read sensitive
> areas even in the presence of XN(Non-executable). This is because XN
> attribute is ignored when domain is Manager.
> 
> This can lead to accesses to non-accessible address regions leading
> to various interconnect violations. The issue is observed on OMAP5.
> 
> This patch tries to fix the issue by ensuring that non-DRAM region
> is marked as a client domain so that XN attribute is effective.
> 
> A better alternative is to not map un-used regions but since the
> decompressor code is generic, there might be many exceptions
> for the devices used like debug console etc.
> 
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/boot/compressed/head.S |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index dc7e8ce..4dc799b 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -578,7 +578,7 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
>  		mov	r9, r0, lsr #18
>  		mov	r9, r9, lsl #18		@ start of RAM
>  		add	r10, r9, #0x10000000	@ a reasonable RAM size
> -		mov	r1, #0x12
> +		mov	r1, #0x32		@ set domain1, XN, valid
>  		orr	r1, r1, #3 << 10
>  		add	r2, r3, #16384
>  1:		cmp	r1, r9			@ if virt > start of RAM
> @@ -587,8 +587,10 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
>  #else
>  		orrhs	r1, r1, #0x0c		@ set cacheable, bufferable
>  #endif
> +		bichs	r1, r1, #0x20		@ set domain0 for DRAM
>  		cmp	r1, r10			@ if virt > end of RAM
>  		bichs	r1, r1, #0x0c		@ clear cacheable, bufferable
> +		orrhs	r1, r1, #0x20		@ set domain1

I would leave the same domain (0, set as client) and rather change the
XN and cacheability bits once we finished with the DRAM. I think it's
cleaner assuming we have two domains and the manager one overrides the
XN bit.

>  		str	r1, [r0], #4		@ 1:1 mapping
>  		add	r1, r1, #1048576
>  		teq	r0, r2
> @@ -658,6 +660,9 @@ __armv7_mmu_cache_on:
>  		movne	r1, #-1
>  		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
>  		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
> +		bic	r1, r1, #0xc
> +		orr	r1, r1, #0x4
> +		mcr	p15, 0, r1, c3, c0, 0   @ set domain1 as cliento

So here just set domain 0 as client.

-- 
Catalin
