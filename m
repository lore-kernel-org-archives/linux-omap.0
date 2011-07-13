From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] dt: omap3: add SoC file for handling i2c controllers
Date: Thu, 14 Jul 2011 03:06:12 +0500
Message-ID: <1310592975-25773-2-git-send-email-manjugk@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


Add omap3 SoC file for handling omap3 SoC i2c controllers existing
on l4-core bus.

Out of three i2c controllers, first i2c controller is interfaced with
PMIC on all the boards of OMAP3. The clock for i2c controllers are
controlled through omap hwmod framework hence first i2c controller
device registration through dt is disabled till hwmod dependencies
are resolved.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap3-soc.dtsi |   65 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi

diff --git a/arch/arm/boot/dts/omap3-soc.dtsi b/arch/arm/boot/dts/omap3-soc.dtsi
new file mode 100644
index 0000000..f186a32
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-soc.dtsi
@@ -0,0 +1,65 @@
+/*
+ * Device Tree Source for OMAP3 SoC
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "ti,omap3";
+	compatible = "ti,omap3";
+
+	intc: interrupt-controller@0x48200000 {
+		compatible = "ti,omap3-intc", "arm,intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x48200000 0x1000>;
+	};
+
+	l4-core {
+		compatible = "ti,l4-core";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x48000000 0x1000000>;
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,omap3-i2c";
+			reg = <0x70000 0x100>;
+			interrupts = < 88 >;
+			status = "disabled";
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,omap3-i2c";
+			reg = <0x72000 0x100>;
+			interrupts = < 89 >;
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,omap3-i2c";
+			reg = <0x60000 0x100>;
+			interrupts = < 93 >;
+		};
+	};
+
+	l4-per {
+		compatible = "ti,l4-per";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x49000000 0x100000>;
+	};
+};
-- 
1.7.4.1
