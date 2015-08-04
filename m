From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/10] ARM: dts: omap4: Use "syscon-otghs" instead of "ctrl-module" in USB node
Date: Tue, 4 Aug 2015 21:00:33 +0530
Message-ID: <1438702233-8027-11-git-send-email-kishon@ti.com>
References: <1438702233-8027-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438702233-8027-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, tony@atomide.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: balbi@ti.com, bcousson@baylibre.com, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add "syscon-otghs" property and remove the deprecated "ctrl-module"
property from MUSB devicetree node.

Since "omap_control_usbotg" devicetree node is no longer used, remove
it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index b27634d..2fb49a5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -854,12 +854,6 @@
 			};
 		};
 
-		omap_control_usbotg: control-phy@4a00233c {
-			compatible = "ti,control-phy-otghs";
-			reg = <0x4a00233c 0x4>;
-			reg-names = "otghs_control";
-		};
-
 		usb_otg_hs: usb_otg_hs@4a0ab000 {
 			compatible = "ti,omap4-musb";
 			reg = <0x4a0ab000 0x7ff>;
@@ -872,7 +866,7 @@
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
-			ctrl-module = <&omap_control_usbotg>;
+			syscon-otghs = <&scm_conf 0x33c>;
 		};
 
 		aes: aes@4b501000 {
-- 
1.7.9.5
