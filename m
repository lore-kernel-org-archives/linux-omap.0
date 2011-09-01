From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 03/13] documentation/dt: Add OMAP i2c bindings documentation
Date: Thu, 1 Sep 2011 19:21:19 +0200
Message-ID: <1314897689-17791-4-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35302 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab1IARWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 13:22:32 -0400
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>

From: G, Manjunath Kondaiah <manjugk@ti.com>

Add documentation for using omap i2c controller with device
tree support enabled.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
[b-cousson@ti.com: Update the documentaion with hwmods binding]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/omap-i2c.txt b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
new file mode 100644
index 0000000..0dc1de0
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
@@ -0,0 +1,30 @@
+I2C for OMAP platforms
+
+Required properties :
+- compatible : Must be "ti,omap-i2c"
+- hwmods : Must be "i2c<n>", n being the instance number (1-based)
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Recommended properties :
+- clock-frequency : Desired I2C bus clock frequency in Hz. Otherwise
+  the default 100 kHz frequency will be used.
+
+Optional properties:
+- Child nodes conforming to i2c bus binding
+
+Note: Current implementation will fetch base address, irq and dma
+from omap hwmod data base during device registration.
+Future plan is to migrate hwmod data base contents into device tree
+blob so that, all the required data will be used from device tree dts
+file.
+
+Examples :
+
+i2c1: i2c@0 {
+    compatible = "ti,omap-i2c";
+    #address-cells = <1>;
+    #size-cells = <0>;
+    hwmods = "i2c1";
+    clock-frequency = <400000>;
+};
-- 
1.7.0.4

