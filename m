From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/1] ARM: dts: omap5: Add clocks to USB3 PHY node
Date: Tue, 1 Apr 2014 13:37:27 +0300
Message-ID: <1396348647-11545-2-git-send-email-rogerq@ti.com>
References: <1396348647-11545-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396348647-11545-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: kishon@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The USB3 PHY driver (ti-pipe3) was updated so that the relevant
clock phandles are expected in the DT node.
Provide the necessary clocks.

Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 757f0b9..4df1e7a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -794,6 +794,12 @@
 				      <0x4a084c00 0x40>;
 				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module = <&omap_control_usb3phy>;
+				clocks = <&usb_phy_cm_clk32k>,
+					 <&sys_clkin>,
+					 <&usb_otg_ss_refclk960m>;
+				clock-names =	"wkupclk",
+						"sysclk",
+						"refclk";
 				#phy-cells = <0>;
 			};
 		};
-- 
1.8.3.2
