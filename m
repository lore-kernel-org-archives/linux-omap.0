From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH v2 13/13] dt: omap: i2c: dt usage model documentation
Date: Tue, 23 Aug 2011 10:03:41 +0500
Message-ID: <1314074021-25186-14-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.64.96] ([117.192.64.96]:2424 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751502Ab1HWErx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:47:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


Add documentation for using omap i2c controller with device
tree support enabled.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 Documentation/devicetree/bindings/i2c/omap-i2c.txt |   57 ++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/omap-i2c.txt b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
new file mode 100644
index 0000000..f427445
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/omap-i2c.txt
@@ -0,0 +1,57 @@
+* OMAP I2C
+----------
+
+The OMAP SoC's has multiple I2C controllers and each controller can
+have I2C child devices.
+
+Required properties :
+
+ - clock-frequency : desired I2C bus clock frequency in Hz.
+ - compatible : should be "ti,omap-i2c"
+
+Recommended properties :
+
+ - reg : Offset and length of the register set for the device
+ - interrupts : <a b> where a is the interrupt number and b is a
+   field that represents an encoding of the sense and level
+   information for the interrupt.  This should be encoded based on
+   the information in section 2) depending on the type of interrupt
+   controller you have.
+ - interrupt-parent : the phandle for the interrupt controller that
+   services interrupts for this device.
+
+Optional:
+The driver platform data can not be passed through device tree as of
+now hence aux data structure can be used in board files. The aux data
+is temparory solution and plan is to move it to device tree dts file.
+
+Note: Current implementation uses only clock-frequency field from
+device tree blob and all other data will be fetched from omap hwmod
+data base during device registration. Future plan is to migrate hwmod
+data base contents into device tree blob so that, all the required
+data will be used from device tree dts file.
+
+Examples :
+
+	/* OMAP4 based board */
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x48000000 0x1000000>;
+
+	i2c1: i2c@70000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap-i2c", "ti,omap-device";
+		reg = <0x70000 0x100>;
+		interrupts = < 88 >;
+		clock-frequency = <400000>;
+	};
+
+	i2c2: i2c@72000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,omap-i2c", "ti,omap-device";
+		reg = <0x72000 0x100>;
+		interrupts = < 89 >;
+		clock-frequency = <400000>;
+	};
-- 
1.7.4.1

