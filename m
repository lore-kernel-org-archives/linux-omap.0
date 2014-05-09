From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Fri, 9 May 2014 08:36:14 -0500
Message-ID: <536CD9CE.9040504@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>	<1399299527-10955-4-git-send-email-r.sricharan@ti.com>	<536BD9D8.4080905@ti.com>	<20140508203659.GA5620@kahuna>	<CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>	<536C0DC4.7090309@ti.com>	<CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>	<536C2071.8040502@ti.com> <CAD=GYpbRn=LEthpAUX9LNBGTB4iDs7TGiSSgLJuuS0tSatRRJQ@mail.gmail.com> <536CD01F.2070506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57243 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925AbaEINgl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 09:36:41 -0400
In-Reply-To: <536CD01F.2070506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Joel Fernandes <agnel.joel@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Sricharan R <r.sricharan@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Hi Nishanth,

On 05/09/2014 07:54 AM, Nishanth Menon wrote:
[..]
> Yep - thanks Santosh for clarifying this. Now, we still have the
> issues that I pointed out in [1] - without resolving which, we should
> not enable crossbar for dra74x/72x.
> 
> A. taking example of PMU
> 	interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>
> this wont work. instead the crossbar driver needs some sort of a hint
> to know that it should not map these on crossbar register instead
> assign GIC mapping directly.
> 
> I propose doing the following
> #define GIC_CROSSBAR_PASSTHROUGH(irq_no) ((irq_no) | (0x1 << 31))
> 
> and dts will define the following:
> interrupts = <GIC_SPI GIC_CROSSBAR_PASSTHROUGH(131) IRQ_TYPE_LEVEL_HIGH>

I would pick something smaller like GIC_SKIP_CROSSBAR.

> This will also work for the other cases (B.2, B.3)
> 
> For B.2: L3_APP_IRQ:
> instead of:
> interrupts = <GIC_SPI  5 IRQ_TYPE_LEVEL_HIGH>
> we do:
> interrupts = <GIC_SPI GIC_CROSSBAR_PASSTHROUGH(10) IRQ_TYPE_LEVEL_HIGH>
> 
> For B.3: NMI
> interrupts = <GIC_SPI GIC_CROSSBAR_PASSTHROUGH(133) IRQ_TYPE_LEVEL_HIGH>
> 
> xlate is easy ->
> 
> diff --git a/drivers/irqchip/irq-crossbar.c
> b/drivers/irqchip/irq-crossbar.c
> index de021638..fd09ab4 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -112,6 +112,10 @@ static int crossbar_domain_xlate(struct
> irq_domain *d,
>  {
>         unsigned long ret;
> 
> +       /* Check to see if direct GIC mapping is required */
> +       if (intspec[1] & BIT(31))
> +               return intspec[1] & ~BIT[31];
> +
>         ret = get_prev_map_irq(intspec[1]);
>         if (!IS_ERR_VALUE(ret))

Sounds good, one problem I see here though is once you do the xlate, the
information that the IRQ number is GIC cross bar is lost because you are
0'ing bit 31. Then how will map/unmap decide if it needs to be crossbar
mapped/unmapped or GIC?

Perhaps, the info in bit 31 should be stored somewhere and reused later
during map time, or I am missing something.

thanks,

-Joel

