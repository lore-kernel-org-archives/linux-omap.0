From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH] arm/dts: Add support for TI AM3517/05 EVM board
Date: Wed, 18 Jan 2012 12:29:46 +0530
Message-ID: <1326869986-18517-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab2ARG74 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 01:59:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>

Add AM3517 EVM (AM3517/05) DTS file to use the omap3.dtsi SoC file,
along with memory node and basic i2c information.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am3517-evm.dts |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517-evm.dts

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
new file mode 100644
index 0000000..474f760
--- /dev/null
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
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
+	model = "TI AM3517 EVM (AM3517/05)";
+	compatible = "ti,am3517-evm", "ti,omap3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+};
--
1.7.0.4

