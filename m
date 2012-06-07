From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 1/2] arm/dts: OMAP2: Add support for OMAP2420 SDP
Date: Thu, 7 Jun 2012 17:11:05 -0500
Message-ID: <1339107066-10461-2-git-send-email-jon-hunter@ti.com>
References: <1339107066-10461-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41322 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159Ab2FGWLM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 18:11:12 -0400
In-Reply-To: <1339107066-10461-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>

Simple DTS file for OMAP2420 SDP adding memory information to allow device-tree
testing on an OMAP2420 SDP.

Verified that kernel boots with DT using a simple RAMDISK file-system on
OMAP2420 SDP.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap2420-sdp.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap2420-sdp.dts

diff --git a/arch/arm/boot/dts/omap2420-sdp.dts b/arch/arm/boot/dts/omap2420-sdp.dts
new file mode 100644
index 0000000..2c292c9
--- /dev/null
+++ b/arch/arm/boot/dts/omap2420-sdp.dts
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
+/include/ "omap2.dtsi"
+
+/ {
+	model = "TI OMAP2420 SDP board";
+	compatible = "ti,omap2-sdp", "ti,omap2420", "ti,omap2";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x84000000>; /* 64 MB */
+	};
+};
-- 
1.7.9.5

