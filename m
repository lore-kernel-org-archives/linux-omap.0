From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 3/5] ARM: dts: dra7: Add named interrupt property for dwc3
Date: Wed, 8 Jul 2015 13:42:32 +0300
Message-ID: <1436352154-28966-4-git-send-email-rogerq@ti.com>
References: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436352154-28966-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add interrupt names so that the same can be used for OTG easily.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi   | 21 ++++++++++++++++++---
 arch/arm/boot/dts/dra74x.dtsi |  7 ++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25b..6596baf 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1295,7 +1295,12 @@
 			usb1: usb@48890000 {
 				compatible = "snps,dwc3";
 				reg = <0x48890000 0x17000>;
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy1>, <&usb3_phy1>;
 				phy-names = "usb2-phy", "usb3-phy";
 				tx-fifo-resize;
@@ -1318,7 +1323,12 @@
 			usb2: usb@488d0000 {
 				compatible = "snps,dwc3";
 				reg = <0x488d0000 0x17000>;
-				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy2>;
 				phy-names = "usb2-phy";
 				tx-fifo-resize;
@@ -1343,7 +1353,12 @@
 			usb3: usb@48910000 {
 				compatible = "snps,dwc3";
 				reg = <0x48910000 0x17000>;
-				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index fa995d0..feea98e 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -65,7 +65,12 @@
 			usb4: usb@48950000 {
 				compatible = "snps,dwc3";
 				reg = <0x48950000 0x17000>;
-				interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				tx-fifo-resize;
 				maximum-speed = "high-speed";
 				dr_mode = "otg";
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
