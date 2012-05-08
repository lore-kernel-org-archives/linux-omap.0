From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
 address space.
Date: Tue, 8 May 2012 15:16:31 +0100
Message-ID: <20120508141631.GG17798@arm.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com>
 <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46863 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755024Ab2EHORG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 10:17:06 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>, Russell King <linux@arm.linux.org.uk>

On Tue, May 08, 2012 at 03:01:57PM +0100, Shilimkar, Santosh wrote:
> From b906ef372f0e2dfa7e1fbc3c87406b1c303d8975 Mon Sep 17 00:00:00 2001
> From: R Sricharan <r.sricharan@ti.com>
> Date: Mon, 7 May 2012 15:11:58 +0530
> Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address
>  space.
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
> This patch tries to fix the issue by ensuring that all regions
> are marked as a client domain so that XN attribute is effective.
> 
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/boot/compressed/head.S |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index dc7e8ce..a2602b8 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -578,10 +578,12 @@ __setup_mmu:	sub	r3, r4, #16384		@ Page directory size
>  		mov	r9, r0, lsr #18
>  		mov	r9, r9, lsl #18		@ start of RAM
>  		add	r10, r9, #0x10000000	@ a reasonable RAM size
> -		mov	r1, #0x12
> +		mov	r1, #0x02		@ Default executable section

I think it is simpler if you leave the original code here (with XN)

>  		orr	r1, r1, #3 << 10
>  		add	r2, r3, #16384
>  1:		cmp	r1, r9			@ if virt > start of RAM
> +		orrlo	r1, r1, #0x10		@ Mark XN for non DRAM
> +		bichs	r1, r1, #0x10		@ clear XN for DRAM

and just do the bichs above.

-- 
Catalin
