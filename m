From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/5] irqchip: kill the GIC routable domain
Date: Mon, 08 Dec 2014 09:10:57 +0000
Message-ID: <54856B21.6070104@arm.com>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com> <20141207171646.GA12049@kahuna> <20141207180322.GA15688@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:45919 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbaLHJLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Dec 2014 04:11:10 -0500
In-Reply-To: <20141207180322.GA15688@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Agner <stefan@agner.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 07/12/14 18:03, Nishanth Menon wrote:
> Marc,
> 
> On 11:16-20141207, Nishanth Menon wrote:
>> On 13:46-20141206, Marc Zyngier wrote:
>>> After my series removing the gic_arch_extn hack, I figured that the
>>> next step was to expunge the GIC driver of the routable domain horror.
>>>
>>> There is a few reasons for this:
>>>
>>> - The allocation of interrupts in this domain is fairly similar to
>>>   what we do for MSI (see the GICv2m driver), and stacked domains have
>>>   proved to be a fitting solution.
>>>
>>> - The current description in DT is currently entierely inaccurate, and
>>>   as we already broke it for the OMAP WUGEN block, we might as well do
>>>   it again for the TI crossbar.
>>>
>>> - The way crossbar, WUGEN and GIC interract is quite complex (this is
>>>   effectively a stack of three interrupt controllers with interesting
>>>   exceptions and braindead routing), and stacked domains are the right
>>>   abstraction for that.
>>>
>>> - Other platforms (Freescale Vybrid) are starting to come up with the
>>>   same type of things, and it'd be good to avoid them following the
>>>   same broken model.
>>>
>>> - It removes a few lines from the code base so it can't completely be
>>>   a bad idea!
>>>
>>> So this patch series does exactly that: make the crossbar a stacked
>>> interrupt controller that only takes care of setting up the routing,
>>> fix the DTs to represent the actual HW, and remove a bit of the
>>> craziness from the GIC code.
>>>
>>> As for the previous series:
>>>
>>> - I haven't been able to test this at all, I don't have access to the
>>>   HW. TI people, please test and post fixes, as I expect I introduced
>>>   a few bugs.
>>>
>>> - This actively *breaks* existing setups. If you boot a new kernel
>>>   with an old DT, interrupt routing *will* be broken. Old kernels on a
>>>   new DT won't boot either! You've been warned. This really outline
>>>   the necessity of actually describing the HW in device trees...
>>>
>>> As for the patches, they are on top of 3.18-rc7 + tip/irq/irqdomain-arm +
>>> the gic_arch_extn removal series.
>>>
>>> I've pushed the code to:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/die-gic-arch-extn-die-die-die
>>>
>>> Comments welcome,
>>>
>>> 	 M.
>>>
>>> Marc Zyngier (5):
>>>   genirq: Add irqchip_set_wake_parent
>>>   irqchip: crossbar: convert dra7 crossbar to stacked domains
>>>   DT: update ti,irq-crossbar binding
>>>   irqchip: GIC: get rid of routable domain
>>>   DT: arm,gic: kill arm,routable-irqs
>>>
>>>  Documentation/devicetree/bindings/arm/gic.txt      |   6 -
>>>  .../devicetree/bindings/arm/omap/crossbar.txt      |  18 +-
>>>  arch/arm/boot/dts/dra7.dtsi                        |  10 +-
>>>  arch/arm/boot/dts/dra72x.dtsi                      |   3 +-
>>>  arch/arm/boot/dts/dra74x.dtsi                      |   5 +-
>>>  arch/arm/mach-omap2/omap4-common.c                 |   4 -
>>>  drivers/irqchip/irq-crossbar.c                     | 202 ++++++++++++---------
>>>  drivers/irqchip/irq-gic.c                          |  59 +-----
>>>  include/linux/irq.h                                |   1 +
>>>  include/linux/irqchip/arm-gic.h                    |   6 -
>>>  include/linux/irqchip/irq-crossbar.h               |  11 --
>>>  kernel/irq/chip.c                                  |  16 ++
>>>  12 files changed, 153 insertions(+), 188 deletions(-)
>>>  delete mode 100644 include/linux/irqchip/irq-crossbar.h
>>>
>>> -- 
>>> 2.1.3
>>>
>>
>> 	Patches are available here:
>> 	https://patchwork.kernel.org/patch/5449231/
>> 	https://patchwork.kernel.org/patch/5449241/
>> 	https://patchwork.kernel.org/patch/5449271/
>> 	https://patchwork.kernel.org/patch/5449261/
>> 	https://patchwork.kernel.org/patch/5449251/
> 
> dra7xx-evm(3.18-rc7):  Boot PASS: http://slexy.org/raw/s2PXWFB47A
> dra7xx-evm(irq branch):  Boot FAIL: http://slexy.org/raw/s2xMgD4zkP
> 
> Would you want me to debug more - dts changes perhaps?

Yes, it would be useful to find out. One thing that strikes me is that
the kernel boots all the way, so I assume IRQs are actually up and running.

One thing though. The "irq" branch shows this:
[   15.359025] pbias_mmc_omap5: disabling

and the MMC subsystem never initializes. I'm pretty sure this is
related. Config option?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
