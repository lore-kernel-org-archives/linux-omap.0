From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH v2 2/5] ARM: mm: rename jump labels in
 v7_flush_dcache_all function
Date: Wed, 19 Sep 2012 14:51:56 +0100
Message-ID: <20120919135155.GB2111@linaro.org>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55584 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab2ISNwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 09:52:01 -0400
Received: by bkwj10 with SMTP id j10so535209bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 06:52:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347986135-17979-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Tue, Sep 18, 2012 at 05:35:32PM +0100, Lorenzo Pieralisi wrote:
> This patch renames jump labels in v7_flush_dcache_all in order to define
> a specific flush cache levels entry point.
> 
> TODO: factor out the level flushing loop if considered worthwhile and
>       define the input registers requirements.

In the context of this series, this patch seems to do nothing at all (?)

Maybe it would make sense to defer this patch until you post something
that uses it.

Given that I have a fair expectation that you will build something useful
on top of this in the near future, I don't have a strong feeling about
it, though.

Cheers
---Dave

> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/mm/cache-v7.S | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index d1fa2f6..140b294 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -48,7 +48,7 @@ ENTRY(v7_flush_dcache_louis)
>  	mov	r3, r3, lsr #20			@ r3 = LoUIS * 2
>  	moveq	pc, lr				@ return if level == 0
>  	mov	r10, #0				@ r10 (starting level) = 0
> -	b	loop1				@ start flushing cache levels
> +	b	flush_levels			@ start flushing cache levels
>  ENDPROC(v7_flush_dcache_louis)
>  
>  /*
> @@ -67,7 +67,7 @@ ENTRY(v7_flush_dcache_all)
>  	mov	r3, r3, lsr #23			@ left align loc bit field
>  	beq	finished			@ if loc is 0, then no need to clean
>  	mov	r10, #0				@ start clean at cache level 0
> -loop1:
> +flush_levels:
>  	add	r2, r10, r10, lsr #1		@ work out 3x current cache level
>  	mov	r1, r0, lsr r2			@ extract cache type bits from clidr
>  	and	r1, r1, #7			@ mask of the bits for current cache only
> @@ -89,9 +89,9 @@ loop1:
>  	clz	r5, r4				@ find bit position of way size increment
>  	ldr	r7, =0x7fff
>  	ands	r7, r7, r1, lsr #13		@ extract max number of the index size
> -loop2:
> +loop1:
>  	mov	r9, r4				@ create working copy of max way size
> -loop3:
> +loop2:
>   ARM(	orr	r11, r10, r9, lsl r5	)	@ factor way and cache number into r11
>   THUMB(	lsl	r6, r9, r5		)
>   THUMB(	orr	r11, r10, r6		)	@ factor way and cache number into r11
> @@ -100,13 +100,13 @@ loop3:
>   THUMB(	orr	r11, r11, r6		)	@ factor index number into r11
>  	mcr	p15, 0, r11, c7, c14, 2		@ clean & invalidate by set/way
>  	subs	r9, r9, #1			@ decrement the way
> -	bge	loop3
> -	subs	r7, r7, #1			@ decrement the index
>  	bge	loop2
> +	subs	r7, r7, #1			@ decrement the index
> +	bge	loop1
>  skip:
>  	add	r10, r10, #2			@ increment cache number
>  	cmp	r3, r10
> -	bgt	loop1
> +	bgt	flush_levels
>  finished:
>  	mov	r10, #0				@ swith back to cache level 0
>  	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
> -- 
> 1.7.12
> 
> 
