From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
Date: Fri, 16 Dec 2011 12:35:53 +0530
Message-ID: <1324019153-13316-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53430 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab1LPHGK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 02:06:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

Add OMAP3 EVM (OMAP3530, AM/DM37x) DTS file to use the omap3.dtsi SoC file,
along with memory node information.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
Boot tested it on AM/DM37x EVM, kernel parses the info correctly.

 arch/arm/boot/dts/omap3-evm.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-evm.dts

diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
new file mode 100644
index 0000000..2eee16e
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -0,0 +1,20 @@
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
+	model = "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
+	compatible = "ti,omap3-evm", "ti,omap3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
--
1.7.0.4

