From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 02/11] arm/dts: Add initial device tree support for OMAP4 SoC
Date: Fri, 23 Sep 2011 22:23:10 +0200
Message-ID: <1316809399-19579-3-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49636 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061Ab1IWUY2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 16:24:28 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

Add initial device-tree support for OMAP4 SoC.

This is based on the original panda board patch done by Manju:
http://permalink.gmane.org/gmane.linux.ports.arm.omap/60393

Add the generic GIC interrupt-controller from ARM.

Add an empty "soc" node to contain non memory mapped IPs
(DSP, MPU, IPU...).

Note: Since reg, irq and dma are provided by hwmod for the
moment, these attributes will not be present at all in DTS
to highlight the gap. They will be added as soon as dma bindings
will be there and drivers will be adapted.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   79 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4.dtsi

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
new file mode 100644
index 0000000..d4131e3
--- /dev/null
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Carveout for multimedia usecases
+ * It should be the last 48MB of the first 512MB memory part
+ * In theory, it should not even exist. That zone should be reserved
+ * dynamically during the .reserve callback.
+ */
+/memreserve/ 0x9d000000 0x03000000;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "ti,omap4430", "ti,omap4";
+	interrupt-parent = <&gic>;
+
+	aliases {
+	};
+
+	/*
+	 * The soc node represents the soc top level view. It is uses for IPs
+	 * that are not memory mapped in the MPU view or for the MPU itself.
+	 */
+	soc {
+		compatible = "ti,omap-infra";
+	};
+
+	/*
+	 * XXX: Use a flat representation of the OMAP4 interconnect.
+	 * The real OMAP interconnect network is quite complex.
+	 *
+	 * MPU -+-- MPU_PRIVATE - GIC, L2
+	 *      |
+	 *      +----------------+----------+
+	 *      |                |          |
+	 *      +            +- EMIF - DDR  |
+	 *      |            |              |
+	 *      |            +     +--------+
+	 *      |            |     |
+	 *      |            +- L4_ABE - AESS, MCBSP, TIMERs...
+	 *      |            |
+	 *      +- L3_MAIN --+- L4_CORE - IPs...
+	 *                   |
+	 *                   +- L4_PER - IPs...
+	 *                   |
+	 *                   +- L4_CFG -+- L4_WKUP - IPs...
+	 *                   |          |
+	 *                   |          +- IPs...
+	 *                   +- IPU ----+
+	 *                   |          |
+	 *                   +- DSP ----+
+	 *                   |          |
+	 *                   +- DSS ----+
+	 *
+	 * Since that will not bring real advantage to represent that in DT for
+	 * the moment, just use a fake OCP bus entry to represent the whole bus
+	 * hierarchy.
+	 */
+	ocp {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gic: interrupt-controller@48241000 {
+			compatible = "arm,cortex-a9-gic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x48241000 0x1000>,
+			      <0x48240100 0x0100>;
+		};
+	};
+};
-- 
1.7.0.4

