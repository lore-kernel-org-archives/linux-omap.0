From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 2/2] arm/dts: Add support for TI AM335x EVM board
Date: Wed, 18 Jan 2012 12:43:59 +0530
Message-ID: <1326870839-19951-2-git-send-email-hvaibhav@ti.com>
References: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38900 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab2ARHO1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 02:14:27 -0500
In-Reply-To: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>

Add AM335x EVM DTS file to use the omap3.dtsi SoC file,
along with memory node and i2c information.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/am335x-evm.dts

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
new file mode 100644
index 0000000..8cc877f
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -0,0 +1,39 @@
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
+	model = "TI AM335x EVM";
+	compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
+
+&intc {
+	/*
+	 * AM33XX family of devices have 128 interrupts
+	 */
+	ti,intc-size = <128>;
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

