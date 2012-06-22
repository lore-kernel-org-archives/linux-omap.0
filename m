From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/4] arm/dts: Add support for AM335x EVM
Date: Fri, 22 Jun 2012 15:10:49 +0530
Message-ID: <1340358050-29560-4-git-send-email-anilkumar@ti.com>
References: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55472 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761786Ab2FVJlA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 05:41:00 -0400
In-Reply-To: <1340358050-29560-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>

Add AM335X EVM device tree source (am335x-evm.dts) file to
use the am33xx.dtsi SoC file, along with the memory node
information.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
Reviewed-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-evm.dts

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
new file mode 100644
index 0000000..d6a97d9
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "am33xx.dtsi"
+
+/ {
+	model = "TI AM335x EVM";
+	compatible = "ti,am335x-evm", "ti,am33xx";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+};
-- 
1.7.9.5

