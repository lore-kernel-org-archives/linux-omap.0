From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] ARM: mm: Flush only CPU local cache instead of all
 cache levels.
Date: Thu, 12 Apr 2012 14:27:29 +0100
Message-ID: <20120412132729.GA27744@e102568-lin.cambridge.arm.com>
References: <1334230187-21553-1-git-send-email-santosh.shilimkar@ti.com>
 <1334230187-21553-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44588 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519Ab2DLN1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 09:27:43 -0400
In-Reply-To: <1334230187-21553-3-git-send-email-santosh.shilimkar@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>

Hi Santosh,

just posted a series whose aim is the same, please have a look and
let's try to merge the two approaches.

On Thu, Apr 12, 2012 at 12:29:47PM +0100, Santosh Shilimkar wrote:
> The ARMv7 processor setup functions clean and invalidates the
> cpu cache before enabling MMU. The intention here is to start
> with clean CPU local cache.
> 
> But on architectures like Cortex-[A15/A8], this code will end
> up flushing the L2 cache as well which undesirable and incorrect.

Undesirable agreed, can you define incorrect please ?

> The setup functions are used in CPU hotplug scenario's too and
> hence flushing all cache levels should be avoided.
> 

Agreed, but this is also true for __cpu_disable() if we consider hotplug into
the picture. The difference is that __cpu_disable is not v7 specific
that's what I tried to address with my series, a more generic (and of course
arguable) approach.

> Fix this code by restricting the cache flush to local cpu
> cache or L1.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/proc-v7.S |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index f1c8486..96cfc31 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -172,7 +172,8 @@ __v7_ca15mp_setup:
>  __v7_setup:
>  	adr	r12, __v7_setup_stack		@ the local stack
>  	stmia	r12, {r0-r5, r7, r9, r11, lr}
> -	bl	v7_flush_dcache_all
> +	mov	r0, #0x1
> +	bl	v7_flush_dcache_by_level

I did not post my patch here that is similar but basically the idea here is
to clean/invalidate up to Level of Unification Inner Shareable.

That hardcoded 0x1 must be explained, it might work for most of the v7 systems
but I think it should be generalized.

Thanks,
Lorenzo

