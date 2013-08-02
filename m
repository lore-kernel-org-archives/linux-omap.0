From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1 CPU
 devices
Date: Fri, 2 Aug 2013 15:18:28 +0100
Message-ID: <20130802141828.GC2361@localhost.localdomain>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:49895 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753452Ab3HBOTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 10:19:06 -0400
Content-Disposition: inline
In-Reply-To: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Thu, Aug 01, 2013 at 02:17:13PM -0400, Santosh Shilimkar wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> The generic code is well equipped to differentiate between
> SMP and UP configurations.However, there are some devices which
> use Cortex-A9 MP core IP with 1 CPU as configuration. To let
> these SOCs to co-exist in a CONFIG_SMP=y build by leveraging
> the SMP_ON_UP support, we need to additionally check the
> number the cores in Cortex-A9 MPCore configuration. Without
> such a check in place, the startup code tries to execute
> ALT_SMP() set of instructions which lead to CPU faults.
> 
> The issue was spotted on TI's Aegis device and this patch
> makes now the device work with omap2plus_defconfig which
> enables SMP by default. The change is kept limited to only
> Cortex-A9 MPCore detection code.

Is there a specific reason why this can't happen for other processors
such as A5/7/15?

Cheers
---Dave

> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Acked-by: Sricharan R <r.sricharan@ti.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/kernel/head.S |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 9cf6063..4924b11 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -486,7 +486,23 @@ __fixup_smp:
>  	mrc	p15, 0, r0, c0, c0, 5	@ read MPIDR
>  	and	r0, r0, #0xc0000000	@ multiprocessing extensions and
>  	teq	r0, #0x80000000		@ not part of a uniprocessor system?
> -	moveq	pc, lr			@ yes, assume SMP
> +	bne    __fixup_smp_on_up	@ no, assume UP
> +
> +	@ Core indicates it is SMP.  Check for Aegis SOC where a single
> +	@ Cortex-A9 CPU is present but SMP operations fault.
> +	mov	r4, #0x41000000
> +	orr	r4, r4, #0x0000c000
> +	orr	r4, r4, #0x00000090
> +	teq	r3, r4			@ Check for ARM Cortex-A9
> +	movne	pc, lr			@ Not ARM Cortex-A9,
> +
> +	mrc	p15, 4, r0, c15, c0	@ get SCU base address
> +	teq	r0, #0x0		@ '0' on actual UP A9 hardware
> +	beq	__fixup_smp_on_up	@ So its an A9 UP
> +	ldr	r0, [r0, #4]		@ read SCU Config
> +	and	r0, r0, #0x3		@ number of CPUs
> +	teq	r0, #0x0		@ is 1?
> +	movne	pc, lr
>  
>  __fixup_smp_on_up:
>  	adr	r0, 1f
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
