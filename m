From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/5] irqchip: kill the GIC routable domain
Date: Sun, 7 Dec 2014 12:03:22 -0600
Message-ID: <20141207180322.GA15688@kahuna>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
 <20141207171646.GA12049@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51085 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbaLGSEG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Dec 2014 13:04:06 -0500
Content-Disposition: inline
In-Reply-To: <20141207171646.GA12049@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, Stefan Agner <stefan@agner.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org

Marc,

On 11:16-20141207, Nishanth Menon wrote:
> On 13:46-20141206, Marc Zyngier wrote:
> > After my series removing the gic_arch_extn hack, I figured that the
> > next step was to expunge the GIC driver of the routable domain horror.
> > 
> > There is a few reasons for this:
> > 
> > - The allocation of interrupts in this domain is fairly similar to
> >   what we do for MSI (see the GICv2m driver), and stacked domains have
> >   proved to be a fitting solution.
> > 
> > - The current description in DT is currently entierely inaccurate, and
> >   as we already broke it for the OMAP WUGEN block, we might as well do
> >   it again for the TI crossbar.
> > 
> > - The way crossbar, WUGEN and GIC interract is quite complex (this is
> >   effectively a stack of three interrupt controllers with interesting
> >   exceptions and braindead routing), and stacked domains are the right
> >   abstraction for that.
> > 
> > - Other platforms (Freescale Vybrid) are starting to come up with the
> >   same type of things, and it'd be good to avoid them following the
> >   same broken model.
> > 
> > - It removes a few lines from the code base so it can't completely be
> >   a bad idea!
> > 
> > So this patch series does exactly that: make the crossbar a stacked
> > interrupt controller that only takes care of setting up the routing,
> > fix the DTs to represent the actual HW, and remove a bit of the
> > craziness from the GIC code.
> > 
> > As for the previous series:
> > 
> > - I haven't been able to test this at all, I don't have access to the
> >   HW. TI people, please test and post fixes, as I expect I introduced
> >   a few bugs.
> > 
> > - This actively *breaks* existing setups. If you boot a new kernel
> >   with an old DT, interrupt routing *will* be broken. Old kernels on a
> >   new DT won't boot either! You've been warned. This really outline
> >   the necessity of actually describing the HW in device trees...
> > 
> > As for the patches, they are on top of 3.18-rc7 + tip/irq/irqdomain-arm +
> > the gic_arch_extn removal series.
> > 
> > I've pushed the code to:
> > git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/die-gic-arch-extn-die-die-die
> > 
> > Comments welcome,
> > 
> > 	 M.
> > 
> > Marc Zyngier (5):
> >   genirq: Add irqchip_set_wake_parent
> >   irqchip: crossbar: convert dra7 crossbar to stacked domains
> >   DT: update ti,irq-crossbar binding
> >   irqchip: GIC: get rid of routable domain
> >   DT: arm,gic: kill arm,routable-irqs
> > 
> >  Documentation/devicetree/bindings/arm/gic.txt      |   6 -
> >  .../devicetree/bindings/arm/omap/crossbar.txt      |  18 +-
> >  arch/arm/boot/dts/dra7.dtsi                        |  10 +-
> >  arch/arm/boot/dts/dra72x.dtsi                      |   3 +-
> >  arch/arm/boot/dts/dra74x.dtsi                      |   5 +-
> >  arch/arm/mach-omap2/omap4-common.c                 |   4 -
> >  drivers/irqchip/irq-crossbar.c                     | 202 ++++++++++++---------
> >  drivers/irqchip/irq-gic.c                          |  59 +-----
> >  include/linux/irq.h                                |   1 +
> >  include/linux/irqchip/arm-gic.h                    |   6 -
> >  include/linux/irqchip/irq-crossbar.h               |  11 --
> >  kernel/irq/chip.c                                  |  16 ++
> >  12 files changed, 153 insertions(+), 188 deletions(-)
> >  delete mode 100644 include/linux/irqchip/irq-crossbar.h
> > 
> > -- 
> > 2.1.3
> > 
> 
> 	Patches are available here:
> 	https://patchwork.kernel.org/patch/5449231/
> 	https://patchwork.kernel.org/patch/5449241/
> 	https://patchwork.kernel.org/patch/5449271/
> 	https://patchwork.kernel.org/patch/5449261/
> 	https://patchwork.kernel.org/patch/5449251/

dra7xx-evm(3.18-rc7):  Boot PASS: http://slexy.org/raw/s2PXWFB47A
dra7xx-evm(irq branch):  Boot FAIL: http://slexy.org/raw/s2xMgD4zkP

Would you want me to debug more - dts changes perhaps?

-- 
Regards,
Nishanth Menon
