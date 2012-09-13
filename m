From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH 1/6] ARM: mm: define LoUIS API for cache maintenance
 ops
Date: Thu, 13 Sep 2012 15:02:20 +0100
Message-ID: <20120913140220.GF2470@linaro.org>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913113949.GC2470@linaro.org>
 <20120913130334.GI28448@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57231 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab2IMOCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 10:02:25 -0400
Received: by eekc1 with SMTP id c1so1962082eek.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 07:02:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120913130334.GI28448@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 02:03:34PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 13, 2012 at 12:39:49PM +0100, Dave Martin wrote:
> > We could introduce something like CONFIG_ARM_HAVE_CACHEFLUSH_LOUIS, and
> > do:
> > 
> > <asm/glue-cache.h>
> > #ifndef MULTI_CACHE
> > #ifdef CONFIG_HAVE_ARM_CACHEFLUSH_LOUIS
> > #define __cpuc_flush_kern_cache_louis __glue(_CACHE,_flush_kern_cache_louis)
> > #else
> > #define __cpuc_flush_kern_cache_louis __glue(_CACHE,_flush_kern_all)
> > #endif
> > #endif
> > 
> > <asm/cacheflush.h>
> > #ifdef MULTI_CACHE
> > #define flush_cache_louis()   cpu_cache.flush_kern_cache_louis()
> > #else
> > #define flush_cache_louis()   __cpuc_flush_kern_cache_louis()
> > #endif
> 
> No, this is stupidly complicated and is fragile.  Just alias the
> functions, like we do in cache-v4wt.S:
> 
> 	.globl	v4wt_dma_flush_range
> 	.equ	v4wt_dma_flush_range, v4wt_dma_inv_range
> 
> except, you'll need:
> 
> 	.globl	v4wt_flush_kern_cache_louis
> 	.equ	v4wt_flush_kern_cache_louis, v4wt_flush_kern_cache_all
> 
> You can do it automatically, using the attached sedscript and this bit
> of shell:
> 
> $ for f in $(grep -l define_cache_functions arch/arm/mm/*.S ); do
>     sed -if sedscript $f
>     git add $f
> done
> $ git commit -s
> 
> Do that first, and then go over those which you need to add a real
> flush_kern_cache_louis function to.

Sure, that works better.

I was trying to think of a more localised way to do it, but the result
was admittedly rather ugly (and not that localised once we select
HAVE_ARM_CACHEFLUSH_LOUIS all over the place).

Cheers
---Dave

> 1,/__INITDATA\|define struct cpu_cache_fns/ {
> 	/ENTRY.*flush_kern_cache_all/ {
>         	h
> 	        s/.*(\([^_]*\)_.*/\t.globl\t\1_flush_kern_cache_louis\n\t.equ\t\1_flush_kern_cache_louis, \1_flush_kern_cache_all\n/
>         	x
> 	}
> 	/__INITDATA\|define struct cpu_cache_fns/ {
>         	H
> 	        g
> 	}
> }

