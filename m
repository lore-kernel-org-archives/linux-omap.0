From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Fix LEDs for igepv5
Date: Sun, 11 Sep 2016 13:50:57 -0700
Message-ID: <20160911205057.21333-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The LEDs on igepv5 are on the GPIO expander unlike on omap5-uevm.

Configuration copied from git.isee.biz git tree except fixed for
red and blue mapping.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 10 ----------
 arch/arm/boot/dts/omap5-igep0050.dts      | 19 +++++++++++++++++++
 arch/arm/boot/dts/omap5-uevm.dts          | 10 ++++++++++
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -77,16 +77,6 @@
 		reset-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>; /* gpio3_79 ETH_NRESET */
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		led1 {
-			label = "omap5:blue:usr1";
-			gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>; /* gpio5_153 D1 LED */
-			linux,default-trigger = "heartbeat";
-			default-state = "off";
-		};
-	};
-
 	tpd12s015: encoder {
 		compatible = "ti,tpd12s015";
 
diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -30,6 +30,25 @@
 			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led@1 {
+			label = "board:green:usr0";
+			gpios = <&tca6416 1 0>;
+			default-state = "off";
+		};
+		led@2 {
+			label = "board:red:usr1";
+			gpios = <&tca6416 2 0>;
+			default-state = "off";
+		};
+		led@3 {
+			label = "board:blue:usr1";
+			gpios = <&tca6416 3 0>;
+			default-state = "off";
+		};
+	};
 };
 
 &hdmi {
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -17,6 +17,16 @@
 		device_type = "memory";
 		reg = <0 0x80000000 0 0x7f000000>; /* 2032 MB */
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "omap5:blue:usr1";
+			gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>; /* gpio5_153 D1 LED */
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
 };
 
 &hdmi {
-- 
2.9.3
