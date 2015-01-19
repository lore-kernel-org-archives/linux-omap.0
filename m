From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 00/21] irqchip: gic: killing gic_arch_extn and co, slowly
Date: Mon, 19 Jan 2015 09:43:54 +0000
Message-ID: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:37232 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbASJoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 04:44:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

The gic_arch_extn hack that a number of platform use has been nagging
me for too long. It is only there for the benefit of a few platform,
and yet it impacts all GIC users. Moreover, it gives people the wrong
idea ("let's use it to put some new custom hack in there"...).

But now that stacked irq domains have been merged into 3.19, the time
has come for gic_arch_extn to meet the Big Bit Bucket.

This patch series takes several steps towards the elimination of
gic_arch_extn:

- moves Tegra's legacy interrupt controller support to
  drivers/irqchip, implementing a stacked domain on top of the
  standard GIC.

- OMAP, imx6 and exynos are also converted to stacked domains, but
  their implementation is left in place (the code is far too
  intricately mixed with other details of the platform for me to even
  try to move it). Some OMAP variants get a special treatment as we
  also kill the crossbar horror (more on that below).

- shmobile, ux500 and zynq are only slightly modified.

- The GIC itself is cleaned up, and some other bits and bobs are
  adjusted for a good measure.

About the TI crossbar:

- The allocation of interrupts in this domain is fairly similar to
  what we do for MSI (see the GICv2m driver), and stacked domains have
  proved to be a fitting solution.

- The current description in DT is currently entierely inaccurate, and
  as we're already breaking it for the WUGEN block, we might as well
  do it again for the crossbar.

- The way crossbar, WUGEN and GIC interract is quite complex (this is
  effectively a stack of three interrupt controllers with interesting
  exceptions and braindead routing), and stacked domains are the right
  abstraction for that.

- Other platforms (Freescale Vybrid) are starting to come up with the
  same type of things, and it'd be good to avoid them following the
  same broken model.

- It removes a few lines from the code base so it can't completely be
  a bad idea!

So this patch series does exactly that: make the crossbar a stacked
interrupt controller that only takes care of setting up the routing,
fix the DTs to represent the actual HW, and remove a bit of the
craziness from the GIC code.

It is worth realizing that:

- I haven't been able to test this as much as I would have wanted to
  (it's only been tested on tegra2, omap4 and omap5).

- I've created DT bindings when needed, updated existing ones, but I
  haven't created a binding for platforms that already used an
  undocumented one (imx6, I'm looking at you).

- I've relaxed quite a bit of the locking in the GIC code. I believe
  this is safe, but someone else should give it a long hard look.

- This actively *breaks* existing setups. Once you boot a new kernel
  with an old DT, suspend/resume *will* be broken. Old kernels on a
  new DT won't even boot! You've been warned. This really outline the
  necessity of actually describing the HW in device trees...

As for the patches, they are on top of 3.19-rc3 + the patch posted
here [4].

I've pushed the code to:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/die-gic-arch-extn-die-die-die

I'm still targetting 3.20 for this, but obviously things are getting
quite tight. I'd very much like to hear from the maintainers about
their views concerning this series.

Thanks,

	 M.

* From v4 [3]:
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

[4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317286.html
[3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315385.html
[2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314041.html
[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307338.html

Marc Zyngier (21):
  ARM: tegra: irq: nuke leftovers from non-DT support
  irqchip: tegra: add DT-based support for legacy interrupt controller
  ARM: tegra: skip gic_arch_extn setup if DT has a LIC node
  ARM: tegra: update DTs to expose legacy interrupt controller
  DT: tegra: add binding for the legacy interrupt controller
  ARM: tegra: remove old LIC support
  genirq: Add irqchip_set_wake_parent
  irqchip: crossbar: convert dra7 crossbar to stacked domains
  DT: update ti,irq-crossbar binding
  irqchip: GIC: get rid of routable domain
  DT: arm,gic: kill arm,routable-irqs
  DT: omap4/5: add binding for the wake-up generator
  ARM: omap: convert wakeupgen to stacked domains
  ARM: imx6: convert GPC to stacked domains
  ARM: exynos4/5: convert pmu wakeup to stacked domains
  DT: exynos: update PMU binding
  irqchip: gic: add an entry point to set up irqchip flags
  ARM: shmobile: remove use of gic_arch_extn.irq_set_wake
  ARM: ux500: switch from gic_arch_extn to gic_set_irqchip_flags
  ARM: zynq: switch from gic_arch_extn to gic_set_irqchip_flags
  irqchip: gic: Drop support for gic_arch_extn

 Documentation/devicetree/bindings/arm/gic.txt      |   6 -
 .../devicetree/bindings/arm/omap/crossbar.txt      |  18 +-
 .../devicetree/bindings/arm/samsung/pmu.txt        |  13 +
 .../interrupt-controller/nvidia,tegra-ictlr.txt    |  43 +++
 .../interrupt-controller/ti,omap4-wugen-mpu        |  33 ++
 arch/arm/boot/dts/am4372.dtsi                      |  11 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   1 -
 arch/arm/boot/dts/am437x-sk-evm.dts                |   1 -
 arch/arm/boot/dts/am43x-epos-evm.dts               |   1 -
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   3 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   2 +-
 arch/arm/boot/dts/dra7.dtsi                        |  43 ++-
 arch/arm/boot/dts/dra72-evm.dts                    |   1 -
 arch/arm/boot/dts/dra72x.dtsi                      |   3 +-
 arch/arm/boot/dts/dra74x.dtsi                      |   5 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   4 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   4 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   4 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   7 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   6 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   6 +-
 arch/arm/boot/dts/omap4-duovero.dtsi               |   2 -
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   8 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |   8 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 -
 arch/arm/boot/dts/omap4.dtsi                       |  18 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   1 -
 arch/arm/boot/dts/omap5-uevm.dts                   |   2 -
 arch/arm/boot/dts/omap5.dtsi                       |  26 +-
 arch/arm/boot/dts/tegra114.dtsi                    |  16 +-
 arch/arm/boot/dts/tegra124.dtsi                    |  16 +-
 arch/arm/boot/dts/tegra20.dtsi                     |  15 +-
 arch/arm/boot/dts/tegra30.dtsi                     |  16 +-
 arch/arm/mach-exynos/exynos.c                      |  14 +-
 arch/arm/mach-exynos/suspend.c                     | 122 ++++++-
 arch/arm/mach-imx/common.h                         |   1 -
 arch/arm/mach-imx/gpc.c                            | 127 +++++--
 arch/arm/mach-imx/mach-imx6q.c                     |   1 -
 arch/arm/mach-imx/mach-imx6sl.c                    |   1 -
 arch/arm/mach-imx/mach-imx6sx.c                    |   1 -
 arch/arm/mach-omap2/omap-wakeupgen.c               | 125 +++++--
 arch/arm/mach-omap2/omap-wakeupgen.h               |   1 -
 arch/arm/mach-omap2/omap4-common.c                 |  21 +-
 arch/arm/mach-shmobile/intc-sh73a0.c               |   7 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |   7 +-
 arch/arm/mach-tegra/iomap.h                        |  15 -
 arch/arm/mach-tegra/irq.c                          | 209 +-----------
 arch/arm/mach-tegra/irq.h                          |   6 -
 arch/arm/mach-tegra/tegra.c                        |   1 -
 arch/arm/mach-ux500/cpu.c                          |   2 +-
 arch/arm/mach-zynq/common.c                        |   2 +-
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-crossbar.c                     | 207 +++++++-----
 drivers/irqchip/irq-gic.c                          | 112 +------
 drivers/irqchip/irq-tegra.c                        | 368 +++++++++++++++++++++
 include/linux/irq.h                                |   1 +
 include/linux/irqchip/arm-gic.h                    |   9 +-
 include/linux/irqchip/irq-crossbar.h               |  11 -
 kernel/irq/chip.c                                  |  16 +
 59 files changed, 1111 insertions(+), 622 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nvidia,tegra-ictlr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
 create mode 100644 drivers/irqchip/irq-tegra.c
 delete mode 100644 include/linux/irqchip/irq-crossbar.h

-- 
2.1.4

