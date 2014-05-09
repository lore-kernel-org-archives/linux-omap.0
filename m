From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Fri, 9 May 2014 09:27:26 -0400
Message-ID: <536CD7BE.5020407@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>	<1399299527-10955-4-git-send-email-r.sricharan@ti.com>	<536BD9D8.4080905@ti.com>	<20140508203659.GA5620@kahuna>	<CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>	<536C0DC4.7090309@ti.com>	<CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>	<536C2071.8040502@ti.com> <CAD=GYpbRn=LEthpAUX9LNBGTB4iDs7TGiSSgLJuuS0tSatRRJQ@mail.gmail.com> <536CD01F.2070506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52384 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbaEIN1y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 09:27:54 -0400
In-Reply-To: <536CD01F.2070506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Joel Fernandes <agnel.joel@gmail.com>
Cc: Joel Fernandes <joelf@ti.com>, "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Sricharan R <r.sricharan@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Friday 09 May 2014 08:54 AM, Nishanth Menon wrote:
> On 05/08/2014 11:22 PM, Joel Fernandes wrote:
>> On Thu, May 8, 2014 at 7:25 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
> [...]
>> Ok, thanks for pointing to the post.
>>
> 
> 
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
> 
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
We can't do add a flag to generic interrupt controller flags since its
very specific to cross-bar.

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
>                 goto found;
> 
> But then, crossbar_domain_map and crossbar_domain_unmap need hints as
> well to know that there is no corresponding crossbar registers.
> Have'nt thought through that yet. Looking to hear about opinions here.
> 
> 
May be we need additional property like reserved to take care of 1:1
map.

ti,irqs-direct-map = <131 132>;

