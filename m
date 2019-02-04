From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 03/14] dt-binding: irqchip: Add pruss-intc-irq driver for PRUSS interrupts
Date: Mon, 4 Feb 2019 16:22:36 +0200
Message-ID: <1549290167-876-4-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com, "Andrew F. Davis" <afd@ti.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

The Programmable Real-Time Unit Subsystem (PRUSS) contains an
interrupt controller (INTC) that can handle various system input
events and post interrupts back to the device-level initiators.
The INTC can support upto 64 input events with individual control
configuration and hardware prioritization. These events are mapped
onto 10 interrupt signals through two levels of many-to-one mapping
support. Different interrupt signals are routed to the individual
PRU cores or to the host CPU.

The PRUSS INTC platform driver manages this PRUSS interrupt
controller and implements an irqchip driver to provide a Linux
standard way for the PRU client users to enable/disable/ack/
re-trigger a PRUSS system event. The system events to interrupt
channels and host interrupts relies on the mapping configuration
provided through a firmware resource table for now. This will be
revisited and enhanced in the future for a better interface. The
mappings will currently be programmed during the boot/shutdown
of the PRU.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../interrupt-controller/ti,pruss-intc-irq.txt     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
new file mode 100644
index 0000000..c70221c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc-irq.txt
@@ -0,0 +1,51 @@
+PRU ICSS INTC on TI SoCs
+========================
+
+Each PRUSS has a single interrupt controller instance that is common to both
+the PRU cores. Each interrupt controller can detect 64 input events which are
+then mapped to 10 possible output interrupts through two levels of mapping. The
+input events can be triggered by either the PRUs and/or various other PRUSS
+internal and external peripherals. The first 2 output interrupts are fed
+exclusively to the internal PRU cores, with the remaining 8 connected to
+external interrupt controllers including the MPU.
+
+Required Properties:
+--------------------
+- compatible           : should be one of,
+                             "ti,am3356-pruss-intc" for AM335x family of SoCs
+                             "ti,am4376-pruss-intc" for AM437x family of SoCs
+                             "ti,am5728-pruss-intc" for AM57xx family of SoCs
+                             "ti,k2g-pruss-intc" for 66AK2G family of SoCs
+- reg                  : base address and size for the PRUSS INTC sub-module
+- reg-names            : should contain the string "intc"
+- interrupts     : all the interrupts generated towards the main host
+                   processor in the SoC. The format depends on the
+                   interrupt specifier for the particular SoC's MPU
+                   parent interrupt controller
+- interrupt-names: should use one of the following names for each interrupt,
+                   the name should match the corresponding host interrupt
+                   number,
+                       "host2", "host3", "host4", "host5", "host6",
+                       "host7", "host8" or "host9"
+                   NOTE: AM437x and 66AK2G SoCs do not have "host7" interrupt
+                         connected to MPU
+- interrupt-controller : mark this node as an interrupt controller
+- #interrupt-cells     : should be 1. Client users shall use the PRU System
+                         event number (the interrupt source that the client
+                         is interested in) as the value of the interrupts
+                         property in their node
+
+Example:
+--------
+		pruss_intc: intc@20000 {
+			compatible = "ti,am3356-pruss-intc";
+			reg = <0x20000 0x2000>;
+			reg-names = "intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <20 21 22 23 24 25 26 27>;
+			interrupt-names = "host2", "host3", "host4",
+					  "host5", "host6", "host7",
+					  "host8", "host9";
+		};
+
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
