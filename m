From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V3] ARM: GIC: Convert GIC library to use the IO relaxed
 operations
Date: Tue, 03 May 2011 11:11:21 +0100
Message-ID: <1304417481.19196.60.camel@e102109-lin.cambridge.arm.com>
References: <1304058131-8375-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:34636 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752152Ab1ECKLa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 06:11:30 -0400
In-Reply-To: <1304058131-8375-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Will Deacon <Will.Deacon@arm.com>

On Fri, 2011-04-29 at 07:22 +0100, Santosh Shilimkar wrote:
> The GIC register accesses today make use of readl()/writel()
> which prove to be very expensive when used along with mandatory
> barriers. This mandatory barriers also introduces an un-necessary
> and expensive l2x0_sync() operation. On Cortex-A9 MP cores, GIC
> IO accesses from CPU are direct and doesn't go through L2X0 write
> buffer.
> 
> A DSB before writel_relaxed() in gic_raise_softirq() is added to be
> compliant with the Barrier Litmus document - the mailbox scenario.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> Rebased on top of Will Deacon's  "ARM: gic: use handle_fasteoi_irq for SPIs"
> patch and boot tested on OMAP4430.
> 
>  arch/arm/common/gic.c |   50 +++++++++++++++++++++++++-----------------------
>  1 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index e9c2ff8..80b3d3c 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -89,7 +89,8 @@ static void gic_mask_irq(struct irq_data *d)
>         u32 mask = 1 << (d->irq % 32);
> 
>         spin_lock(&irq_controller_lock);
> -       writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
> +       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
> +       readl_relaxed(gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);

As I commented on the version 2 of this patch, I don't think we should
even bother with the additional readl_relaxed() here. It's not enough to
prevent spurious interrupts anyway.

> @@ -392,6 +393,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>         unsigned long map = *cpus_addr(*mask);
> 
>         /* this always happens on GIC0 */
> -       writel(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
> +       dsb();
> +       writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);

I would add a comment before the dsb() on why it is needed. Maybe something like:

/*
 * Ensure that stores to Normal memory are visible to the other CPUs before
 * issuing the IPI.
 */


Otherwise the patch looks fine (I'll add my ack after you fix the above).

Thanks.

-- 
Catalin


