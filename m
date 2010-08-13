From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/6] omap: Use CONFIG_SMP for test_for_ipi and
 test_for_ltirq
Date: Fri, 13 Aug 2010 14:34:09 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C65D7F8F@dbde02.ent.ti.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
 <20100813080210.18750.68209.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41037 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761379Ab0HMJEQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 05:04:16 -0400
In-Reply-To: <20100813080210.18750.68209.stgit@baageli.muru.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, August 13, 2010 1:32 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 5/6] omap: Use CONFIG_SMP for test_for_ipi and
> test_for_ltirq
> 
> Otherwise we get the following error when enabling CONFIG_SMP
> for omap3_defconfig:
> 
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi
> r0,r6,r5,lr'
> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq
> r0,r6,r5,lr'
> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi
> r0,r6,r5,lr'
> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ltirq
> r0,r6,r5,lr'
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
This is same with omap_4430sdp_defconfig.
With this patch build is working patch now.
 
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

>  arch/arm/mach-omap2/include/mach/entry-macro.S |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S
> b/arch/arm/mach-omap2/include/mach/entry-macro.S
> index 50fd749..06e64e1 100644
> --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> @@ -177,7 +177,10 @@ omap_irq_base:	.word	0
>  		cmpne   \irqnr, \tmp
>  		cmpcs   \irqnr, \irqnr
>  		.endm
> +#endif
> +#endif	/* MULTI_OMAP2 */
> 
> +#ifdef CONFIG_SMP
>  		/* We assume that irqstat (the raw value of the IRQ
> acknowledge
>  		 * register) is preserved from the macro above.
>  		 * If there is an IPI, we immediately signal end of interrupt
> @@ -205,8 +208,7 @@ omap_irq_base:	.word	0
>  		streq	\irqstat, [\base, #GIC_CPU_EOI]
>  		cmp	\tmp, #0
>  		.endm
> -#endif
> -#endif	/* MULTI_OMAP2 */
> +#endif	/* CONFIG_SMP */
> 
>  		.macro	irq_prio_table
>  		.endm
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
