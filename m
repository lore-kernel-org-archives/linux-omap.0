From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 18/19] Documentation: dt: OMAP: crossbar: add description for interrupt consumer
Date: Thu, 12 Jun 2014 17:23:26 +0530
Message-ID: <1402574007-13987-19-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com, tglx@linutronix.de, jason@lakedaemon.net
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

The current crossbar description does not include the description
required for the consumer of the crossbar, a.k.a devices whoes events
pass through the crossbar into the GIC interrupt controller.

So, provide documentation for the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/arm/omap/crossbar.txt      |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/crossbar.txt b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
index 6d2e2f5..816d11b 100644
--- a/Documentation/devicetree/bindings/arm/omap/crossbar.txt
+++ b/Documentation/devicetree/bindings/arm/omap/crossbar.txt
@@ -27,3 +27,20 @@ Examples:
 			ti,reg-size = <2>;
 			ti,irqs-reserved = <0 1 2 3 5 6 131 132 139 140>;
 		};
+
+Consumer:
+========
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt and
+Documentation/devicetree/bindings/arm/gic.txt for further details.
+
+An interrupt consumer on an SoC using crossbar will use:
+	interrupts = <GIC_SPI request_number interrupt_level>
+request number shall be between 0 to that described by
+"ti,max-crossbar-sources"
+
+Example:
+	device_x@0x4a023000 {
+		/* Crossbar 8 used */
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		...
+	};
-- 
1.7.9.5
