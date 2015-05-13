From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH] arm: dts: Enable beaglebone cape-manager
Date: Wed, 13 May 2015 11:04:52 +0300
Message-ID: <1431504292-32132-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Robert Nelson <robertcnelson@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

Enable the cape manager on the beaglebone family of boards.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 236b7db..28d9764 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -375,3 +375,45 @@
 &sham {
 	status = "okay";
 };
+
+/* the cape manager */
+/ {
+	bone_capemgr {
+		compatible = "ti,bone-capemgr";
+		status = "okay";
+
+		eeprom = <&baseboard_data>;
+
+		/* map board revisions to compatible definitions */
+		baseboardmaps {
+			baseboard_beaglebone: board@0 {
+				board-name = "A335BONE";
+				compatible-name = "ti,beaglebone";
+			};
+
+			baseboard_beaglebone_black: board@1 {
+				board-name = "A335BNLT";
+				compatible-name = "ti,beaglebone-black";
+			};
+		};
+
+		/* only 4 slots defined */
+		slots {
+			slot@0 {
+				eeprom = <&cape0_data>;
+			};
+
+			slot@1 {
+				eeprom = <&cape1_data>;
+			};
+
+			slot@2 {
+				eeprom = <&cape2_data>;
+			};
+
+			slot@3 {
+				eeprom = <&cape3_data>;
+			};
+		};
+	};
+};
-- 
1.7.12
