From: Tony Lindgren <tony@atomide.com>
Subject: Re: Questions about masking interrupts when disabling interrupts
Date: Wed, 7 Jan 2009 15:05:06 +0200
Message-ID: <20090107130504.GM27566@atomide.com>
References: <4d34a0a70901051859i792725b3t4563971070f886fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51383 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627AbZAGNFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 08:05:10 -0500
Content-Disposition: inline
In-Reply-To: <4d34a0a70901051859i792725b3t4563971070f886fc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?6rmA6rec7JuQ?= <chammoru@gmail.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?utf-8?B?7ZeI7ISx6rSA?= <sk.heo@samsung.com>

* =EA=B9=80=EA=B7=9C=EC=9B=90 <chammoru@gmail.com> [090106 04:59]:
> Greetings,
>=20
> I'm enabling the Suspend-to-RAM state in our new OMAP3 Board.
> But I had some problems because of USB Interrupt.
>=20
> Although I disabled USB interrupt by disable_irq() function while
> entering the Suspend,
> M_IRQ_92 irq continuously wake up the OMAP3430 Processor.
>=20
> So, I fixed this problem as following patch.
>=20
> My Questions are:
> 1. Could anyone suggest the better solution for this problem?

Maybe suspend the US=CE=92 too? :)

> 2. If there is no better solution, can I be applied this patch to oma=
p-tree?

The patch looks OK to me, assuming the default enable calls unmask?

Regards,

Tony

>=20
> Thank you!
>=20
> commit bbb49321b161e6a9ff2b73326d4012d8eb8bbf23
> Author: Kim Kyuwon <chammoru@gmail.com>
> Date:   Tue Jan 6 10:11:46 2009 +0900
>=20
>     ARM: OMAP3: Mask interrupts when disabling interrupts
>=20
>     By Ingo Molnar, interrupts are not masked by default.
>     (refer to 76d2160147f43f982dfe881404cfde9fd0a9da21)
>=20
>     But if interrupts are not masked, the processor can wake up while=
 in
>     Suspend-to-RAM state by an external interrupt. For example, if an
> OMAP3 board
>     is connected to Host PC by USB and entered to Suspend-to-RAM
> state, it wake up
>     automatically by M_IRQ_92. The disable_irq() function can't disab=
le the
>     interrupt in H/W level, So I modified arch/arm/mach-omap2/irq.c
>=20
>     Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
>=20
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 110acb9..b44dcae 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -123,6 +123,11 @@ static void omap_unmask_irq(unsigned int irq)
>  	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offs=
et);
>  }
>=20
> +static void omap_disable_irq(unsigned int irq)
> +{
> +	omap_mask_irq(irq);
> +}
> +
>  static void omap_mask_ack_irq(unsigned int irq)
>  {
>  	omap_mask_irq(irq);
> @@ -134,6 +139,7 @@ static struct irq_chip omap_irq_chip =3D {
>  	.ack	=3D omap_mask_ack_irq,
>  	.mask	=3D omap_mask_irq,
>  	.unmask	=3D omap_unmask_irq,
> +	.disable =3D omap_disable_irq,
>  };
>=20
>  static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank=
)
> --=20
> Kim Kyuwon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
