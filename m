From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 6/6] arm/dts: added dt properties to adapt to the new phy framwork
Date: Mon, 3 Mar 2014 17:08:15 +0530
Message-ID: <1393846695-14644-7-git-send-email-kishon@ti.com>
References: <1393846695-14644-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393846695-14644-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, balbi@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, george.cherian@ti.com, heikki.krogerus@linux.intel.com, rogerq@ti.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, tony@atomide.com, linux@arm.linux.org.uk, kishon@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Added device tree bindings for dwc3, usb2 and usb3 PHYs. The documentation
of these can be found at Documentation/devicetree/bindings/phy/phy-bindings.txt
and Documentation/devicetree/bindings/phy/ti-phy.txt.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index a72813a..1c68558 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -732,7 +732,8 @@
 				compatible = "snps,dwc3";
 				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-				usb-phy = <&usb2_phy>, <&usb3_phy>;
+				phys = <&usb2_phy>, <&usb3_phy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				dr_mode = "peripheral";
 				tx-fifo-resize;
 			};
@@ -749,6 +750,7 @@
 				compatible = "ti,omap-usb2";
 				reg = <0x4a084000 0x7c>;
 				ctrl-module = <&omap_control_usb2phy>;
+				#phy-cells = <0>;
 			};
 
 			usb3_phy: usb3phy@4a084400 {
@@ -758,6 +760,7 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				#phy-cells = <0>;
 			};
 		};
 
-- 
1.7.9.5
