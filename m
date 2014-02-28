From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Use handle_fasteoi_irq for INTC interrupt
 handling
Date: Fri, 28 Feb 2014 09:11:12 -0800
Message-ID: <20140228171111.GA15399@atomide.com>
References: <1393236556-12361-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38621 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751974AbaB1RLY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 12:11:24 -0500
Content-Disposition: inline
In-Reply-To: <1393236556-12361-1-git-send-email-stefan.sorensen@spectralink.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan =?utf-8?B?U8O4cmVuc2Vu?= <stefan.sorensen@spectralink.com>
Cc: linux-omap@vger.kernel.org

* Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com> [140224 02:12]=
:
> Currently INTC interrupts are handled using handle_level_irq which
> will acknowledge the interrupt before running the handler. If a secon=
d
> interrupt is then asserted and this interrupt is disabled while
> running the first handler, the INTC will be brought into an
> inconsistent state.

Hmm care to explain a bit more here if the second interrupt you're
talking about is the same interrupt or any interrupt in the same
interrupt bank? Is this limited to GPIO interrupts?

The reason I'm asking is because of the issues we've seen earlier
with not flushing posted writes from the interrupt handlers. In
those case the interrupt on the device gets acked too late without
the read back call.

> In this state the INTC will interrupt the CPU but
> the interrupt pending registers will show no pending interrupts
> causing the CPU to take no action. This will repeat until another
> higher priority interrupt triggers, hogging the CPU.
>=20
> handle_fasteoi_irq does not acknowledge the interrupt before after
> running the handler, so using this for handling INTC interrupts avoid
> the above problem. This also brings the handling more in line with th=
e
> sequence described in the TRM.
>=20
> Signed-off-by: Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com>
> ---
>  arch/arm/mach-omap2/irq.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index e022a86..9d09914 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -97,12 +97,6 @@ static void omap_ack_irq(struct irq_data *d)
>  	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
>  }
> =20
> -static void omap_mask_ack_irq(struct irq_data *d)
> -{
> -	irq_gc_mask_disable_reg(d);
> -	omap_ack_irq(d);
> -}
> -
>  static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank=
)
>  {
>  	unsigned long tmp;
> @@ -145,9 +139,9 @@ omap_alloc_gc(void __iomem *base, unsigned int ir=
q_start, unsigned int num)
>  	struct irq_chip_type *ct;
> =20
>  	gc =3D irq_alloc_generic_chip("INTC", 1, irq_start, base,
> -					handle_level_irq);
> +					handle_fasteoi_irq);
>  	ct =3D gc->chip_types;
> -	ct->chip.irq_ack =3D omap_mask_ack_irq;
> +	ct->chip.irq_eoi =3D omap_ack_irq;
>  	ct->chip.irq_mask =3D irq_gc_mask_disable_reg;
>  	ct->chip.irq_unmask =3D irq_gc_unmask_enable_reg;
>  	ct->chip.flags |=3D IRQCHIP_SKIP_SET_WAKE;
> --=20
> 1.8.5.3
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
