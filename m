From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 6/7] ARM: dts: omap5: Add omap-usb3 and omap-usb2 dt data
Date: Thu, 7 Mar 2013 19:05:19 +0530
Message-ID: <1362663320-23799-7-git-send-email-kishon@ti.com>
References: <1362663320-23799-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1362663320-23799-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, kishon@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add omap-usb3 and omap-usb2 data node in omap5 device tree file.
The information for the node added here is available @
Documentation/devicetree/bindings/usb/usb-phy.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 230b779..bd73257 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -511,6 +511,20 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "ocp2scp1";
+			usb2_phy: usb2phy@4a084000 {
+				compatible = "ti,omap-usb2";
+				reg = <0x4a084000 0x7c>;
+				ctrl-module = <&omap_control_usb>;
+			};
+
+			usb3_phy: usb3phy@4a084400 {
+				compatible = "ti,omap-usb3";
+				reg = <0x4a084400 0x80>,
+				      <0x4a084800 0x64>,
+				      <0x4a084c00 0x40>;
+				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
+				ctrl-module = <&omap_control_usb>;
+			};
 		};
 	};
 };
-- 
1.7.10.4

