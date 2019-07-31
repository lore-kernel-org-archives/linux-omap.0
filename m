From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 0/6] Add TI PRUSS Local Interrupt Controller IRQChip driver
Date: Wed, 31 Jul 2019 17:41:43 -0500
Message-ID: <20190731224149.11153-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Rob Herring <robh+dt@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi All,

The following is a v2 version of the series [1] that adds an IRQChip driver for
the local interrupt controller present within a Programmable Real-Time Unit and
Industrial Communication Subsystem (PRU-ICSS) present on a number of TI SoCs 
including OMAP architecture based AM335x, AM437x, AM57xx SoCs, Keystone 2 
architecture based 66AK2G SoCs, Davinci architecture based OMAP-L138/DA850 SoCs
and the latest K3 architecture based AM65x and J721E SoCs. Please see the
v1 cover-letter [1] for details about the features of this interrupt controller.
More details can be found in any of the supported SoC TRMs.
 Eg: Chapter 30.1.6 of AM5728 TRM [2]

Please see the individual patches for exact changes in each patch, following are
the main changes from v1:
 - Dropped the pruss_intc_trigger() API and patch and replaced it with a new
   patch achieving the same through irq_set_irqchip_state() callback (patch 5)
 - Added cleanup logic on INTC mapping fails and reset the mapping registers
   during unmap (patch 4)
 - Minor revisions to the bindings, no new properties introduced (patch 1)

regards
Suman

[1] https://patchwork.kernel.org/cover/11034561/
[2] http://www.ti.com/lit/pdf/spruhz6

Andrew F. Davis (1):
  irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS
    interrupts

David Lechner (1):
  irqchip/irq-pruss-intc: Implement irq_{get,set}_irqchip_state ops

Suman Anna (4):
  dt-bindings: irqchip: Add PRUSS interrupt controller bindings
  irqchip/irq-pruss-intc: Add support for shared and invalid interrupts
  irqchip/irq-pruss-intc: Add helper functions to configure internal
    mapping
  irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs

 .../interrupt-controller/ti,pruss-intc.txt    |  98 +++
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-pruss-intc.c              | 764 ++++++++++++++++++
 include/linux/irqchip/irq-pruss-intc.h        |  36 +
 5 files changed, 909 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.txt
 create mode 100644 drivers/irqchip/irq-pruss-intc.c
 create mode 100644 include/linux/irqchip/irq-pruss-intc.h

-- 
2.22.0
