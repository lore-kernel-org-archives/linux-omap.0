From: yegorslists@googlemail.com
Subject: [PATCH v3 1/3] ARM: dts: AM35x: Add hecc node
Date: Wed, 15 Feb 2017 15:48:43 +0100
Message-ID: <1487170125-10815-2-git-send-email-yegorslists@googlemail.com>
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, tony@atomide.com, mkl@pengutronix.de, andrej.skvortzov@gmail.com, hs@denx.de, anton.a.glukhov@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

HECC node description for am35x SOCs

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 arch/arm/boot/dts/am3517.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 9fe545d..00da3f2 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -13,6 +13,7 @@
 / {
 	aliases {
 		serial3 = &uart4;
+		can = &hecc;
 	};
 
 	ocp@68000000 {
@@ -72,6 +73,17 @@
 			pinctrl-single,register-width = <16>;
 			pinctrl-single,function-mask = <0xff1f>;
 		};
+
+		hecc: can@5c050000 {
+			compatible = "ti,am3517-hecc";
+			status = "disabled";
+			reg = <0x5c050000 0x80>,
+			      <0x5c053000 0x180>,
+			      <0x5c052000 0x200>;
+			reg-names = "hecc", "hecc-ram", "mbx";
+			interrupts = <24>;
+			clocks = <&hecc_ck>;
+		};
 	};
 };
 
-- 
2.1.4

