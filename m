From: karthik@techveda.org
Subject: [PATCH] arm: dts: omap3: Remove interrupt-parent property
Date: Tue, 27 Jun 2017 11:03:10 +0530
Message-ID: <1498541590-4550-1-git-send-email-karthik@techveda.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, sunil.m@techveda.org, Karthik Tummala <karthik@techveda.org>
List-Id: linux-omap@vger.kernel.org

From: Karthik Tummala <karthik@techveda.org>

All nodes inhert "interrupt-parent" property from root
node. So removed that property from usbhsohci, usbhsehci,
ssi_port1, ssi_port2 nodes.

Signed-off-by: Karthik Tummala <karthik@techveda.org>
---
 arch/arm/boot/dts/omap3.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index a3ff493..bdaf30c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -713,14 +713,12 @@
 			usbhsohci: ohci@48064400 {
 				compatible = "ti,ohci-omap3";
 				reg = <0x48064400 0x400>;
-				interrupt-parent = <&intc>;
 				interrupts = <76>;
 			};
 
 			usbhsehci: ehci@48064800 {
 				compatible = "ti,ehci-omap";
 				reg = <0x48064800 0x400>;
-				interrupt-parent = <&intc>;
 				interrupts = <77>;
 			};
 		};
@@ -831,7 +829,6 @@
 				reg-names = "tx",
 					    "rx";
 
-				interrupt-parent = <&intc>;
 				interrupts = <67>,
 					     <68>;
 			};
@@ -844,7 +841,6 @@
 				reg-names = "tx",
 					    "rx";
 
-				interrupt-parent = <&intc>;
 				interrupts = <69>,
 					     <70>;
 			};
-- 
1.9.1
