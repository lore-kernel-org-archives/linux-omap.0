From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 06/11] arm/dts: twl6030: Add DTS file for twl6030 PMIC
Date: Tue, 20 Dec 2011 17:27:19 +0100
Message-ID: <1324398444-23296-7-git-send-email-b-cousson@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53416 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab1LTQ2M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 11:28:12 -0500
In-Reply-To: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

Add a dedicated DTS file for the twl6030 Power IC.
This chip is a big SoC that will be reused in a lot of various
OMAP4+ boards.

Note: This file is supposed to be included in a board DTS that will
create the twl node in order to allow the &twl reference to work.

Exmaple:
...
&i2c1 {
    twl: twl@48 {
        reg = <0x48>;
        interrupts = <0 7 4>;
        interrupt-controller;
        interrupt-parent = <&gic>;
    };
};

/include/ "twl6030.dtsi"
...

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/twl6030.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/twl6030.dtsi

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
new file mode 100644
index 0000000..b7b4e5e
--- /dev/null
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -0,0 +1,22 @@
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
+ * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+ */
+&twl {
+	compatible = "ti,twl6030";
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

