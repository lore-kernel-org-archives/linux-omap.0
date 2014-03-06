From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: INTC: Acknowledge stuck active interrupts
Date: Thu, 6 Mar 2014 10:32:35 -0800
Message-ID: <20140306183235.GB1381@atomide.com>
References: <1394119635-24194-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37464 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbaCFSck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Mar 2014 13:32:40 -0500
Content-Disposition: inline
In-Reply-To: <1394119635-24194-1-git-send-email-stefan.sorensen@spectralink.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan =?utf-8?B?U8O4cmVuc2Vu?= <stefan.sorensen@spectralink.com>
Cc: linux-omap@vger.kernel.org

* Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com> [140306 07:30]=
:
> When an interrupt has become active on the INTC it will stay active
> until it is acked, even if masked or de-asserted. The
> INTC_PENDING_IRQn registers are however updated and since these are
> used by omap_intc_handle_irq to determine which interrupt to handle,
> it will never see the active interrupt. This will result in a storm o=
f
> useless interrupts that is only stopped when another higher priority
> interrupt is asserted.
>=20
> Fix by sending the INTC an acknowledge if we find no interrupts to
> handle.

OK this makes more sense to me.

While playing with this, you may want to also do one more test and
forward port these two patches adding checks for spurious interrupts:

6ccc4c0d ARM: OMAP3: Warn about spurious interrupts
846c29f1 ARM: OMAP3: Clean up spurious interrupt check logic

Those got removed in commit:

667a11fa arm: omap2/3: Use generic irq chip

If you get warnings with those checks about spurious interrupts there's
also something else wrong or we're not understanding the problem fully.
So it might be good to check before we apply this patch.

Regards,

Tony
=20
> Signed-off-by: Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com>
> ---
>  arch/arm/mach-omap2/irq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index e022a86..6037a9a 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -222,6 +222,7 @@ void __init ti81xx_init_irq(void)
>  static inline void omap_intc_handle_irq(void __iomem *base_addr, str=
uct pt_regs *regs)
>  {
>  	u32 irqnr;
> +	int handled_irq =3D 0;
> =20
>  	do {
>  		irqnr =3D readl_relaxed(base_addr + 0x98);
> @@ -249,8 +250,15 @@ out:
>  		if (irqnr) {
>  			irqnr =3D irq_find_mapping(domain, irqnr);
>  			handle_IRQ(irqnr, regs);
> +			handled_irq =3D 1;
>  		}
>  	} while (irqnr);
> +
> +	/* If an irq is masked or deasserted while active, we will
> +	 * keep ending up here with no irq handled. So remove it from
> +	 * the INTC with an ack.*/
> +	if (!handled_irq)
> +		omap_ack_irq(NULL);
>  }
> =20
>  asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct p=
t_regs *regs)
> --=20
> 1.8.5.3
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
