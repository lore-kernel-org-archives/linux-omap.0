From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 2/7] arm/dts: Add initial device tree support for OMAP4 SoC
Date: Wed, 24 Aug 2011 12:17:15 +0200
Message-ID: <1314181040-22807-3-git-send-email-b-cousson@ti.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58825 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1HXKTF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 06:19:05 -0400
In-Reply-To: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

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
 arch/arm/boot/dts/omap4.dtsi |   80 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4.dtsi

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
new file mode 100644
index 0000000..97a3ea7
--- /dev/null
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -0,0 +1,80 @@
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
+	model = "TI OMAP4430";
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
+			compatible = "ti,omap4-gic", "arm,gic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x48241000 0x1000>,
+			      <0x48240100 0x0200>;
+		};
+	};
+};
-- 
1.7.0.4

