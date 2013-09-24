From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] arm: dts: omap5-uevm: Add status parameter for i2c/spi/uart.
Date: Tue, 24 Sep 2013 11:09:25 +0530
Message-ID: <1380001165-19078-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap5 has all devices enable by default.
Disable thosw not required in omap5 uevm board.

Fix the following:
Added status parameter
Simulataneously, fix some tab formatting.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts |   38 +++++++++++++++++++++++++++++++-------
 1 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 65d7b60..78cf0f2 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -450,6 +450,18 @@
 	};
 };
 
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	status = "disabled";
+};
+
+&i2c4 {
+	status = "disabled";
+};
+
 &i2c5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c5_pins>;
@@ -471,7 +483,7 @@
 };
 
 &mcspi1 {
-
+	status = "disabled";
 };
 
 &mcspi2 {
@@ -490,16 +502,28 @@
 };
 
 &uart1 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+};
+
+&uart2 {
+	status = "disabled";
 };
 
 &uart3 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&uart3_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
+
+&uart4 {
+	status = "disabled";
 };
 
 &uart5 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&uart5_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_pins>;
+};
+
+&uart6 {
+	status = "disabled";
 };
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
