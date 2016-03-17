From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 00/15] Add support for Tegra210 AGIC
Date: Thu, 17 Mar 2016 14:19:04 +0000
Message-ID: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

The Tegra210 AGIC interrupt controller is a 2nd level interrupt controller
located in a separate power domain to the main GIC interrupt controller.
It can route interrupts to the main CPU cluster or an Audio DSP slave.
This series only support routing interrupts to the main CPU cluster.

Ideally we would like to re-use the existing ARM GIC driver because the
AGIC is a GIC-400. However, in order to do so this requires adding
runtime power management support for irqchips and several significant
changes to the exisiting GIC driver for power management reasons.

Originally, this series was sent out as an RFC [0] and hopefully, I have
addressed all the comments and issues reported. I was/am tempted to
split this series into two series, one to add runtime-pm support for
irqchips (patches 1-8) and one to add support for the AGIC to the GIC
driver (patches 9-15). If this would be more manageable and easier, I
am happy to do so.

I have included a fix for OMAP (needs testing) that was reported by
Grygorii. I know it may seem odd to include in a series adding an
interrupt controller for Tegra, but oh well ...

This is work well so far on Tegra, but would love to get some more
testing on other platforms.

[0] http://marc.info/?l=linux-kernel&m=145034948920651&w=2

Jon Hunter (15):
  ARM: tegra: Correct interrupt type for ARM TWD
  ARM: OMAP: Correct interrupt type for ARM TWD
  irqchip/gic: Don't unnecessarily write the IRQ configuration
  irqchip/gic: WARN if setting the interrupt type fails
  irqchip: Mask the non-type/sense bits when translating an IRQ
  irqdomain: Ensure type settings match for an existing mapping
  irqdomain: Don't set type when mapping an IRQ
  genirq: Add runtime power management support for IRQ chips
  irqchip/gic: Don't initialise chip if mapping IO space fails
  irqchip/gic: Remove static irq_chip definition for eoimode1
  irqchip/gic: Return an error if GIC initialisation fails
  irqchip/gic: Pass GIC pointer to save/restore functions
  irqchip/gic: Prepare for adding platform driver
  dt-bindings: arm-gic: Drop 'clock-names' from binding document
  irqchip/gic: Add support for tegra AGIC interrupt controller

 .../bindings/interrupt-controller/arm,gic.txt      |  12 +-
 arch/arm/boot/dts/omap4.dtsi                       |   2 +-
 arch/arm/boot/dts/tegra20.dtsi                     |   2 +-
 arch/arm/boot/dts/tegra30.dtsi                     |   2 +-
 drivers/irqchip/Kconfig                            |   1 +
 drivers/irqchip/irq-crossbar.c                     |   2 +-
 drivers/irqchip/irq-gic-common.c                   |  19 +-
 drivers/irqchip/irq-gic-common.h                   |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   6 +-
 drivers/irqchip/irq-gic.c                          | 437 ++++++++++++++++-----
 drivers/irqchip/irq-hip04.c                        |   5 +-
 drivers/irqchip/irq-tegra.c                        |   2 +-
 include/linux/irq.h                                |   5 +
 include/linux/irqdomain.h                          |   3 +
 kernel/irq/chip.c                                  |  52 +++
 kernel/irq/internals.h                             |   1 +
 kernel/irq/irqdomain.c                             |  77 +++-
 kernel/irq/manage.c                                |  21 +-
 kernel/irq/pm.c                                    |   3 +
 19 files changed, 492 insertions(+), 162 deletions(-)

-- 
2.1.4
