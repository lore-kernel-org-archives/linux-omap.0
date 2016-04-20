From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 00/14] Add support for Tegra210 AGIC
Date: Wed, 20 Apr 2016 12:03:43 +0100
Message-ID: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
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

Changes since V1:
- Updated GIC to only WARN and not return an error if configuring a PPI
  fails but will still return an error if an SPI fails (per discussion
  with Marc).
- Dropped change to mask sense bits for GIC-v3 (as this is not
  necessary)
- Split patch to avoid setting interrupt type when mapping the IRQ into
  two patches per TGLX's feedback.
- Changed name of irqchip device structure to "parent_device"
- Moved call to irq_chip_pm_get() outside of chip_bus_lock().
- Dropped patch to remove clock names from GIC DT documentation and
  added AGIC clock names.
- Update GIC platform driver to look-up clocks names from static list.

Jon Hunter (14):
  irqchip/gic: Don't unnecessarily write the IRQ configuration
  irqchip/gic: WARN if setting the interrupt type for a PPI fails
  irqchip: Mask the non-type/sense bits when translating an IRQ
  irqdomain: Fix handling of type settings for existing mappings
  genirq: Look-up trigger type if not specified by caller
  irqdomain: Don't set type when mapping an IRQ
  genirq: Add runtime power management support for IRQ chips
  irqchip/gic: Don't initialise chip if mapping IO space fails
  irqchip/gic: Remove static irq_chip definition for eoimode1
  irqchip/gic: Return an error if GIC initialisation fails
  irqchip/gic: Pass GIC pointer to save/restore functions
  irqchip/gic: Prepare for adding platform driver
  dt-bindings: arm-gic: Add documentation for Tegra210 AGIC
  irqchip/gic: Add support for tegra AGIC interrupt controller

 .../bindings/interrupt-controller/arm,gic.txt      |   2 +
 drivers/irqchip/Kconfig                            |   1 +
 drivers/irqchip/irq-crossbar.c                     |   2 +-
 drivers/irqchip/irq-gic-common.c                   |  19 +-
 drivers/irqchip/irq-gic.c                          | 440 ++++++++++++++++-----
 drivers/irqchip/irq-tegra.c                        |   2 +-
 include/linux/irq.h                                |   4 +
 include/linux/irqdomain.h                          |   3 +
 kernel/irq/chip.c                                  |  35 ++
 kernel/irq/internals.h                             |   1 +
 kernel/irq/irqdomain.c                             |  55 ++-
 kernel/irq/manage.c                                |  40 +-
 12 files changed, 481 insertions(+), 123 deletions(-)

-- 
2.1.4
