From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 1/5] ARM: dts: am4372: Add named interrupt property for dwc3
Date: Wed, 8 Jul 2015 13:42:30 +0300
Message-ID: <1436352154-28966-2-git-send-email-rogerq@ti.com>
References: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436352154-28966-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

Add interrupt names so that the same can be used for OTG easily.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c80a3e2..3f68b27 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -859,7 +859,12 @@
 			usb1: usb@48390000 {
 				compatible = "synopsys,dwc3";
 				reg = <0x48390000 0x10000>;
-				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy1>;
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
@@ -883,7 +888,12 @@
 			usb2: usb@483d0000 {
 				compatible = "synopsys,dwc3";
 				reg = <0x483d0000 0x10000>;
-				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy2>;
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
-- 
2.1.4
