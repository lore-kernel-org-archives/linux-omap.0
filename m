From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/6] genirq: irqdomain_hierarchy: fixes
Date: Wed, 12 Aug 2015 20:45:56 +0300
Message-ID: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, tony@atomide.com, marc.zyngier@arm.com
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, jason@lakedaemon.net, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi All,

I've had able to identify and reproduce four issues related to switching on
using IRQ domain hierarchy on TI OMAP DRA7 (dra7-evm). Most of them were
discovered during testing of Suspend to RAM and IRQ wakeup functionality.
In my opinion, most of these issue could also affect on other ARM SoC if
they are using IRQ domain hierarchy.

In case of TI OMAP DRA7 the following IRQ hierarchy is defined:
 ARM GIC <- OMAP wakeupgen <- TI CBAR

Issue 1 - patch 1(new): IRQ re-triggering is not working if IRQ domain
hierarchy used in combination with ARM GIC and irq_chip_retrigger_hierarchy()
is used by child IRQ domain.

Issue 2 - patch 2(new): IRQ wakeup configuration is not propagated properly
through IRQ domains hierarchy if irq_chip_set_wake_parent() is used and
parent IRQ domain don't implement .irq_set_wake(), but has 
IRQCHIP_SKIP_SET_WAKE flag set.

Issue 3 - patches 3-5: ARM GIC IRQ triggering type is not configured
properly when IRQ is routed through IRQ domain hierarchy and
system started using DT. As result, system will start using default
ARM GIC configuration, ignore DT IRQ triggering configuration,
and value of desc->irq_data.state_use_accessors = 0.

/ # cat /proc/interrupts -- before
230:          0          0      CBAR  30 Edge    -00000000  48051000.gpio
263:          0          0      CBAR 116 Edge    -00000000  48053000.gpio
296:        246          0      CBAR  67 Edge    -00000000  OMAP UART0
311:        341          0      CBAR  51 Edge    -00000000  48070000.i2c
312:          3          0      CBAR  52 Edge    -00000000  48072000.i2c
313:          0          0      CBAR  56 Edge    -00000000  48060000.i2c
314:        255          0      CBAR  78 Edge    -00000000  mmc0
315:         40          0      CBAR  81 Edge    -00000000  mmc1
316:         13          0      CBAR  91 Edge    -00000000  mmc2
320:          0          0      CBAR  49 Edge    -00000000  4a140000.sata
324:          0          0      CBAR   1 Edge    -00000000  48078000.elm
325:          0          0      CBAR  15 Edge    -00000000  gpmc
333:          0          0      CBAR 335 Edge    -00000000  48484000.ethernet
334:          0          0      CBAR 336 Edge    -00000000  48484000.ethernet
415:          0          0   pcf857x   2 Edge    -00000000  btnUser1
416:          0          0   pcf857x   3 Edge    -00000000  btnUser2
445:          0          0   pinctrl 992 Edge    -00010000  4806a000.seria

/ # cat /proc/interrupts -- after
230:          0          0      CBAR  30 Level   -00002004  48051000.gpio
263:          0          0      CBAR 116 Level   -00002004  48053000.gpio
296:        567          0      CBAR  67 Level   -00002004  OMAP UART0
311:        363          0      CBAR  51 Level   -00002004  48070000.i2c
312:          3          0      CBAR  52 Level   -00002004  48072000.i2c
313:          0          0      CBAR  56 Level   -00002004  48060000.i2c
314:        197          0      CBAR  78 Level   -00002004  mmc0
315:         40          0      CBAR  81 Level   -00002004  mmc1
316:         13          0      CBAR  91 Level   -00002004  mmc2
320:          0          0      CBAR  49 Level   -00002004  4a140000.sata
324:          0          0      CBAR   1 Level   -00002004  48078000.elm
325:          0          0      CBAR  15 Level   -00002004  gpmc
333:          0          0      CBAR 335 Level   -00002004  48484000.ethernet
334:          0          0      CBAR 336 Level   -00002004  48484000.ethernet
415:          0          0   pcf857x   2 Edge    -00000000  btnUser1
416:          4          2   pcf857x   3 Edge    -00000000  btnUser2
445:          0          0   pinctrl 992 Edge    -00010000  4806a000.serial

-xxxxxxxx are current values of desc->irq_data.state_use_accessors

Issue 4 - patch 5(new): ARM GIC IRQs are not masked during suspend even
if they are not wakeup source. 
	This issue related to IRQCHIP MASK ON SUSPEND flag usage and,
honestly, it's not clear how this flag has to be processed in
case of IRQ domain hierarchy - previously there was one IRQ chip per IRQ
desc and if it has IRQCHIP MASK ON SUSPEND flag set we had to mask IRQ.
But now there are up to three (DRA7) IRQ chip per IRQ desc, and all of them
could have different IRQCHIP MASK ON SUSPEND flag's configuration.
	Here, to fix an issue, I've just added IRQCHIP MASK ON SUSPEND flag
to TI Crossbar which is the last IRQ domain in hierarchy.

IRQ domain hierarchy code was merged in 4.1, so it seems these patches
are material for stable 4.1+.

Tested on:
 TI OMAP DRA7, dra7-evm

Series based on:
 Linux 4.2-rc6

Changes in v2:
- initial patch has been split on three;
- added three more patechs.

Link on v1:
 https://lkml.org/lkml/2015/8/11/179

Grygorii Strashko (6):
  genirq: fix irq_chip_retrigger_hierarchy
  genirq: fix irqchip_set_wake_parent if IRQCHIP_SKIP_SET_WAKE
  genirq: introduce irq_chip_set_type_parent() helper
  irqchip: crossbar: fix arm gic irq type configuration
  ARM: OMAP: wakeupgen: fix arm gic irq type configuration
  irqchip: crossbar: fix irq masking at suspend

 arch/arm/mach-omap2/omap-wakeupgen.c |  1 +
 drivers/irqchip/irq-crossbar.c       |  2 ++
 include/linux/irq.h                  |  1 +
 kernel/irq/chip.c                    | 26 +++++++++++++++++++++++++-
 4 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.5.0
