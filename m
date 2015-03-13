From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked
 domains
Date: Fri, 13 Mar 2015 08:40:39 -0700
Message-ID: <20150313154039.GL5264@atomide.com>
References: <1426088629-15377-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:36976 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbbCMPpi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2015 11:45:38 -0400
Content-Disposition: inline
In-Reply-To: <1426088629-15377-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [150311 08:44]:
> This series is extracted from [4], which is trying to remove all
> traces of gic_arch_extn from the tree. As some maintainers are more
> responsive than others (understatement of the year...), I've decided
> to split it per sub-arch, and get it moving, at least partially.
> 
> This series addresses OMAP{4,5} by converting the WUGEN to stacked
> domains. The DRA7 crossbar gets the same treatment.
...
> 
>  Documentation/devicetree/bindings/arm/gic.txt      |   6 -
>  .../devicetree/bindings/arm/omap/crossbar.txt      |  18 +-
>  .../interrupt-controller/ti,omap4-wugen-mpu        |  33 ++++
>  arch/arm/boot/dts/am4372.dtsi                      |  11 +-
>  arch/arm/boot/dts/am437x-gp-evm.dts                |   1 -
>  arch/arm/boot/dts/am437x-sk-evm.dts                |   1 -
>  arch/arm/boot/dts/am43x-epos-evm.dts               |   1 -
>  arch/arm/boot/dts/am57xx-beagle-x15.dts            |   3 +-
>  arch/arm/boot/dts/dra7-evm.dts                     |   2 +-
>  arch/arm/boot/dts/dra7.dtsi                        |  43 +++--
>  arch/arm/boot/dts/dra72-evm.dts                    |   1 -
>  arch/arm/boot/dts/dra72x.dtsi                      |   3 +-
>  arch/arm/boot/dts/dra74x.dtsi                      |   5 +-
>  arch/arm/boot/dts/omap4-duovero.dtsi               |   2 -
>  arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
>  arch/arm/boot/dts/omap4-sdp.dts                    |   8 +-
>  arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 -
>  arch/arm/boot/dts/omap4.dtsi                       |  18 +-
>  arch/arm/boot/dts/omap5-cm-t54.dts                 |   1 -
>  arch/arm/boot/dts/omap5-uevm.dts                   |   2 -
>  arch/arm/boot/dts/omap5.dtsi                       |  26 ++-
>  arch/arm/mach-omap2/omap-wakeupgen.c               | 128 ++++++++++---
>  arch/arm/mach-omap2/omap-wakeupgen.h               |   1 -
>  arch/arm/mach-omap2/omap4-common.c                 |  27 +--
>  drivers/irqchip/irq-crossbar.c                     | 210 ++++++++++++---------
>  drivers/irqchip/irq-gic.c                          |  59 +-----
>  include/linux/irq.h                                |   1 +
>  include/linux/irqchip/arm-gic.h                    |   6 -
>  include/linux/irqchip/irq-crossbar.h               |  11 --
>  kernel/irq/chip.c                                  |  16 ++
>  30 files changed, 376 insertions(+), 278 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
>  delete mode 100644 include/linux/irqchip/irq-crossbar.h

For merging this, how about Marc sets up an immutable branch against
v4.0-rc1 that both Jason and I can merge it in? Then Jason can
send the pull request I can sort out the merge conflict issues.

Regards,

Tony
