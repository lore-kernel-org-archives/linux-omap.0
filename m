From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v6 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
Date: Wed, 11 Mar 2015 15:43:42 +0000
Message-ID: <1426088629-15377-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46322 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbbCKPnz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 11:43:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This series is extracted from [4], which is trying to remove all
traces of gic_arch_extn from the tree. As some maintainers are more
responsive than others (understatement of the year...), I've decided
to split it per sub-arch, and get it moving, at least partially.

This series addresses OMAP{4,5} by converting the WUGEN to stacked
domains. The DRA7 crossbar gets the same treatment.

It is worth realizing that:

- I haven't been able to test this as much as I would have wanted to
  (it's only been tested on omap4 and omap5).

- This actively *breaks* existing setups. Once you boot a new kernel
  with an old DT, suspend/resume *will* be broken. Old kernels on a
  new DT won't even boot! You've been warned. This really outline the
  necessity of actually describing the HW in device trees...

Based on 4.0-rc1.

* From v5: [5]
- Allow interrupt affinity to be changed

* From v4: [4]
- Extracted from the full series
- Rebased on 4.0-rc1

* From v3 [3]:
- Rebased on top of the patch working around hardcoded IRQ on OMAP4/5 [4]
- Fixed more iMX6 DTs (Stephan)
- Fixed Exynos4/5 DTs

* From v2 [2]:
- Addressed numerous comments from Thierry
- Merged bug fixes from Nishanth
- Merged bug fix from Stefan

* From v1 [1]:
- Rebased on 3.19-rc3
- Fixed a number of additional platforms
- Added crossbar conversion to stacked domains
- Merged bug fixes from Nishanth

[5]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325178.html
[4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317531.html
[3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315385.html
[2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314041.html
[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307338.html

Marc Zyngier (7):
  genirq: Add irqchip_set_wake_parent
  irqchip: crossbar: convert dra7 crossbar to stacked domains
  DT: update ti,irq-crossbar binding
  irqchip: GIC: get rid of routable domain
  DT: arm,gic: kill arm,routable-irqs
  DT: omap4/5: add binding for the wake-up generator
  ARM: omap: convert wakeupgen to stacked domains

 Documentation/devicetree/bindings/arm/gic.txt      |   6 -
 .../devicetree/bindings/arm/omap/crossbar.txt      |  18 +-
 .../interrupt-controller/ti,omap4-wugen-mpu        |  33 ++++
 arch/arm/boot/dts/am4372.dtsi                      |  11 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   1 -
 arch/arm/boot/dts/am437x-sk-evm.dts                |   1 -
 arch/arm/boot/dts/am43x-epos-evm.dts               |   1 -
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   2 +-
 arch/arm/boot/dts/dra7.dtsi                        |  43 +++--
 arch/arm/boot/dts/dra72-evm.dts                    |   1 -
 arch/arm/boot/dts/dra72x.dtsi                      |   3 +-
 arch/arm/boot/dts/dra74x.dtsi                      |   5 +-
 arch/arm/boot/dts/omap4-duovero.dtsi               |   2 -
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   8 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 -
 arch/arm/boot/dts/omap4.dtsi                       |  18 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   1 -
 arch/arm/boot/dts/omap5-uevm.dts                   |   2 -
 arch/arm/boot/dts/omap5.dtsi                       |  26 ++-
 arch/arm/mach-omap2/omap-wakeupgen.c               | 128 ++++++++++---
 arch/arm/mach-omap2/omap-wakeupgen.h               |   1 -
 arch/arm/mach-omap2/omap4-common.c                 |  27 +--
 drivers/irqchip/irq-crossbar.c                     | 210 ++++++++++++---------
 drivers/irqchip/irq-gic.c                          |  59 +-----
 include/linux/irq.h                                |   1 +
 include/linux/irqchip/arm-gic.h                    |   6 -
 include/linux/irqchip/irq-crossbar.h               |  11 --
 kernel/irq/chip.c                                  |  16 ++
 30 files changed, 376 insertions(+), 278 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
 delete mode 100644 include/linux/irqchip/irq-crossbar.h

-- 
2.1.4

