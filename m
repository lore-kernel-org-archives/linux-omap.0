From: yegorslists@googlemail.com
Subject: [PATCH v2 1/3] ARM: dts: AM35x: Add hecc node
Date: Wed, 11 Jan 2017 15:05:19 +0100
Message-ID: <1484143521-4898-2-git-send-email-yegorslists@googlemail.com>
References: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1484143521-4898-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, jean-michel.hautbois@vodalys.com, andrej.skvortzov@gmail.com, hs@denx.de, Anton Glukhov <anton.a.glukhov@gmail.com>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Anton Glukhov <anton.a.glukhov@gmail.com>

HECC node description for am35x SOCs

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
Changes v1 -> v2:
	change compatible to "ti,am3505"

 arch/arm/boot/dts/am3517.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 9fe545d..3bb8687 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -13,6 +13,7 @@
 / {
 	aliases {
 		serial3 = &uart4;
+		can = &hecc;
 	};
 
 	ocp@68000000 {
@@ -72,6 +73,18 @@
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0xff1f>;
 		};
+
+		hecc: can@5c050000 {
+			compatible = "ti,am3505";
+			status = "disabled";
+			reg = <0x5c050000 0x4000>;
+			interrupts = <24>;
+			clocks = <&hecc_ck>;
+			ti,scc-ram-offset = <0x3000>;
+			ti,hecc-ram-offset = <0x3000>;
+			ti,mbx-offset = <0x2000>;
+			ti,int-line = <0>;
+		};
 	};
 };
 
-- 
2.1.4

