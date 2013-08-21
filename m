From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 1/5] arm: omap5: dts: fix reg property size
Date: Wed, 21 Aug 2013 20:01:30 +0530
Message-ID: <1377095494-15380-2-git-send-email-kishon@ti.com>
References: <1377095494-15380-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377095494-15380-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, linux@arm.linux.org.uk, javier.martinez@collabora.co.uk, devicetree@vger.kernel.org, kishon@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

USB3 block has a 64KiB space, another 64KiB is
used for the wrapper.

Without this change, resource_size() will get
confused and driver won't probe because size
will be negative.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..5c99f19 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -637,7 +637,7 @@
 		omap_dwc3@4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
-			reg = <0x4a020000 0x1000>;
+			reg = <0x4a020000 0x10000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -645,7 +645,7 @@
 			ranges;
 			dwc3@4a030000 {
 				compatible = "synopsys,dwc3";
-				reg = <0x4a030000 0x1000>;
+				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 				usb-phy = <&usb2_phy>, <&usb3_phy>;
 				tx-fifo-resize;
-- 
1.7.10.4
