From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 4/7] ARM: dts: omap4+: Add clocks to USB2 PHY node
Date: Mon, 28 Apr 2014 17:01:24 +0300
Message-ID: <1398693687-13967-5-git-send-email-rogerq@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398693687-13967-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The USB2 PHY driver expects named clocks for wakeup clock
and reference clock. Provide this information for USB2 PHY
nodes in OMAP4 and OMAP5 SoC DTS.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 649b5cd..f866de9 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -642,6 +642,8 @@
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
 				ctrl-module = <&omap_control_usb2phy>;
+				clocks = <&usb_phy_cm_clk32k>;
+				clock-names = "wkupclk";
 				#phy-cells = <0>;
 			};
 		};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index f8c9855..47b714c 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -803,6 +803,8 @@
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
 				ctrl-module = <&omap_control_usb2phy>;
+				clocks = <&usb_phy_cm_clk32k>, <&usb_otg_ss_refclk960m>;
+				clock-names = "wkupclk", "refclk";
 				#phy-cells = <0>;
 			};
 
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
