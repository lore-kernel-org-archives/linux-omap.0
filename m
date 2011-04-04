From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] ARM: GIC: Convert GIC library to use the IO relaxed
 operations
Date: Mon, 04 Apr 2011 16:29:08 +0100
Message-ID: <1301930948.15819.52.camel@e102109-lin.cambridge.arm.com>
References: <1301650321-28652-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:46607 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754698Ab1DDP3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Apr 2011 11:29:19 -0400
In-Reply-To: <1301650321-28652-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Will Deacon <Will.Deacon@arm.com>

On Fri, 2011-04-01 at 10:32 +0100, Santosh Shilimkar wrote:
> The GIC register accesses today make use of readl()/writel()
> which prove to be very expensive when used along with mandatory
> barriers. This mandatory barriers also introduces an un-necessary
> and expensive l2x0_sync() operation. On Cortex-A9 MP cores, GIC
> IO accesses from CPU are direct and doesn't go through L2X0 write
> buffer.
> 
> Also since a DSB does not guarantee that the device state has
> been changed, a read back from the device is introduced wherever
> necessary.
...
> @@ -98,7 +98,8 @@ static void gic_mask_irq(struct irq_data *d)
>         u32 mask = 1 << (d->irq % 32);
> 
>         spin_lock(&irq_controller_lock);
> -       writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
> +       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
> +       readl_relaxed(gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>         if (gic_arch_extn.irq_mask)
>                 gic_arch_extn.irq_mask(d);
>         spin_unlock(&irq_controller_lock);
> 

Talking to the hardware people, a readl back would guarantee that the
GIC state has changed but you can still get spurious interrupts because
of the signal propagation from the GIC to the CPU. That's difficult to
reliably sort out in software as we don't know the hardware delays, so
we'll have to cope with spurious interrupts (unlikely though).

A better sequence would be something like below (but still no
guarantees):

	STR	[Device]
	LDR	[Device]
	DSB
	ISB

(the ISB is needed in case some instructions already in the pipeline
sampled the state of the interrupt signal)

But I'm more in favour of not even bothering with an additional
readl_relaxed, we simply cope with a very rare spurious interrupt. In a
virtualised environment accesses to the GIC distributor are trapped
making things slower.

-- 
Catalin


