From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/6] Add TI PRUSS Local Interrupt Controller IRQChip driver
Date: Sun, 7 Jul 2019 22:52:37 -0500
Message-ID: <20190708035243.12170-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Tony Lindgren <tony@atomide.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi All,

The following series adds an IRQChip driver for the local interrupt controller
present within a Programmable Real-Time Unit and Industrial Communication
Subsystem (PRU-ICSS) present on a number of TI SoCs including OMAP architecture
based AM335x, AM437x, AM57xx SoCs, Keystone 2 architecture based 66AK2G SoCs,
Davinci architecture based OMAP-L138/DA850 SoCs and the latest K3 architecture
based AM65x and J721E SoCs. This series splits out the INTC portions into a
separate stand-alone series from the previous PRUSS support patch series [1]
as requested by various maintainers. Patches are on top of latest master.

The PRUSS local INTC is a unique interrupt controller designed to map a number
of SoC-level device or internal PRUSS interrupt sources into a smaller set of
output interrupt lines that are connected to various SoC-level processors like
the host ARM, PRU cores themselves and optionally to some DSPs, other PRUSS,
DMA controllers etc. The following are some of the features:
 - Capture of 64 (160 on K3) System Events/input interrupt sources
 - Multiplexing of these system events onto 10 (20 on K3) output interrupt
   channels in a many-to-one fashion
 - Multiplexing of the output interrupt channels onto 10 (20 on K3) host
   interrupts split between multiple processors. Typical integration connects
   the first 2 host interrupts to PRU cores, and the next 8 host interrupts
   to ARM cores.
 - Independent enable and disable of system events and their mapping onto
   a channel
 - Independent enable and disable of host events and the mapping to host
   events per interrupt channel. 
 - Inherent hardward prioritization of events and channels (lower number
   indicates higher priority).
 - Additional input interrupt sources multiplexing using either a SoC-level
   CFG MMR or PRUSS CFG MMR (support will be added through PRU rproc client
   bindings).

More details can be found in any of the supported SoC TRMs.
Eg: Chapter 30.1.6 of AM5728 TRM [2]

Changes from previous series include:
 - Update bindings to move away from SoC-specific compatibles
 - Use new DT properties to add support for shared and exclusive ARM GIC
   interrupt lines 
 - Include support for Davinci OMAP-L138 and K3 AM65x & J721E SoCs
 - Split up the driver patch into granular incremental support patches

regards
Suman

[1] https://patchwork.kernel.org/cover/10795721/
[2] http://www.ti.com/lit/pdf/spruhz6


Andrew F. Davis (2):
  irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS
    interrupts
  irqchip/irq-pruss-intc: Add API to trigger a PRU sysevent

Suman Anna (4):
  dt-bindings: irqchip: Add PRUSS interrupt controller bindings
  irqchip/irq-pruss-intc: Add support for shared and invalid interrupts
  irqchip/irq-pruss-intc: Add helper functions to configure internal
    mapping
  irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs

 .../interrupt-controller/ti,pruss-intc.txt    |  92 +++
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-pruss-intc.c              | 749 ++++++++++++++++++
 include/linux/irqchip/irq-pruss-intc.h        |  33 +
 include/linux/pruss_intc.h                    |  26 +
 6 files changed, 911 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.txt
 create mode 100644 drivers/irqchip/irq-pruss-intc.c
 create mode 100644 include/linux/irqchip/irq-pruss-intc.h
 create mode 100644 include/linux/pruss_intc.h

-- 
2.22.0
