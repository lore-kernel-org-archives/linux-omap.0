From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: dts: OMAP3: Add support for OMAP3430 SDP board
Date: Fri, 11 Jan 2013 10:39:22 -0600
Message-ID: <1357922362-7641-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab3AKQjc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jan 2013 11:39:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Adds basic device-tree support for OMAP3430 SDP board which has 256MB
of RAM and uses the TWL4030 power management IC.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/omap3430-sdp.dts |   46 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..5d6dff0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -104,6 +104,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-beagle.dtb \
 	omap3-beagle-xm.dtb \
 	omap3-evm.dtb \
+	omap3430-sdp.dtb \
 	omap3-tobi.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
new file mode 100644
index 0000000..be0650d
--- /dev/null
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "omap3.dtsi"
+
+/ {
+	model = "TI OMAP3430 SDP";
+	compatible = "ti,omap3430-sdp", "ti,omap3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl@48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+	};
+};
+
+/include/ "twl4030.dtsi"
+
+&mmc1 {
+	vmmc-supply = <&vmmc1>;
+	vmmc_aux-supply = <&vsim>;
+	bus-width = <8>;
+};
+
+&mmc2 {
+	status = "disabled";
+};
+
+&mmc3 {
+	status = "disabled";
+};
-- 
1.7.10.4

