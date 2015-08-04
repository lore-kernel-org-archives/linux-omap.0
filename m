From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/10] ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible string for USB2 PHY2
Date: Tue, 4 Aug 2015 21:00:27 +0530
Message-ID: <1438702233-8027-5-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438702233-8027-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: balbi@ti.com, bcousson@baylibre.com, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

The USB2 PHY2 has a different register map compared to USB2 PHY1
to power on/off the PHY. In order to handle it, use the new compatible
string "ti,dra7x-usb2-phy2" for the second instance of USB2 PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 0ebb808..dfefd17 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1234,7 +1234,7 @@
 			};
 
 			usb2_phy2: phy@4a085000 {
-				compatible = "ti,omap-usb2";
+				compatible = "ti,dra7x-usb2-phy2", "ti,omap-usb2";
 				reg = <0x4a085000 0x400>;
 				ctrl-module = <&omap_control_usb2phy2>;
 				clocks = <&usb_phy2_always_on_clk32k>,
-- 
1.7.9.5
