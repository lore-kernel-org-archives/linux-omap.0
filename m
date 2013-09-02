From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 6/7] arm/dts: added dt properties to adapt to the new phy framwork
Date: Mon, 2 Sep 2013 21:13:10 +0530
Message-ID: <1378136591-7463-7-git-send-email-kishon@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378136591-7463-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, kishon@ti.com, balbi@ti.com
Cc: bcousson@baylibre.com, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, linux@arm.linux.org.uk, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 94abef5..9fe71ff 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -651,7 +651,8 @@
 				compatible = "snps,dwc3";
 				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-				usb-phy = <&usb2_phy>, <&usb3_phy>;
+				phys = <&usb2_phy>, <&usb3_phy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				tx-fifo-resize;
 			};
 		};
@@ -667,6 +668,7 @@
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
 				ctrl-module = <&omap_control_usb2phy>;
+				#phy-cells = <0>;
 			};
 
 			usb3_phy: usb3phy@4a084400 {
@@ -676,6 +678,7 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				#phy-cells = <0>;
 			};
 		};
 
-- 
1.7.10.4
