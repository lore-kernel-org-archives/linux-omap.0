From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 07/11] arm/dts: twl4030: Add DTS file for twl4030 PM + Audio IC
Date: Tue, 20 Dec 2011 17:27:20 +0100
Message-ID: <1324398444-23296-8-git-send-email-b-cousson@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33115 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab1LTQ2H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 11:28:07 -0500
In-Reply-To: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

Add a dedicated DTS file for the twl4030/5030 Power + Audio IC.
This chip is a big SoC that will be reused in a lot of various
OMAP3 boards.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/twl4030.dtsi

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
new file mode 100644
index 0000000..8be5223
--- /dev/null
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Integrated Power Management Chip
+ */
+&twl {
+	compatible = "ti,twl4030";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	rtc {
+		compatible = "ti,twl4030-rtc";
+		interrupts = <11>;
+	};
+};
-- 
1.7.0.4

