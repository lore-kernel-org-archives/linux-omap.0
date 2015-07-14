From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 7/7] ARM: dts: dra7: workaround UART module disable errata
Date: Tue, 14 Jul 2015 13:32:09 +0530
Message-ID: <6655d460d8e312a439b001547a1a7642d791672b.1436855647.git.nsekhar@ti.com>
References: <cover.1436855646.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1436855646.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add "ti,dra742-uart" to the compatible list so the driver
workaround for UART module disable errata is enabled.

This does not break backward compatibility as existing DTBs
should continue to work with newer kernels albeit without the
capability to idle the UART module when DMA is used.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
v2:
- no change.

 arch/arm/boot/dts/dra7.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25bcecbd..49940e516f0f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -397,7 +397,7 @@
 		};
 
 		uart1: serial@4806a000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
 			interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
@@ -408,7 +408,7 @@
 		};
 
 		uart2: serial@4806c000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
@@ -419,7 +419,7 @@
 		};
 
 		uart3: serial@48020000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
@@ -430,7 +430,7 @@
 		};
 
 		uart4: serial@4806e000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
@@ -441,7 +441,7 @@
 		};
 
 		uart5: serial@48066000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x48066000 0x100>;
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart5";
@@ -452,7 +452,7 @@
 		};
 
 		uart6: serial@48068000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x48068000 0x100>;
 			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart6";
@@ -463,7 +463,7 @@
 		};
 
 		uart7: serial@48420000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x48420000 0x100>;
 			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart7";
@@ -472,7 +472,7 @@
 		};
 
 		uart8: serial@48422000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x48422000 0x100>;
 			interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart8";
@@ -481,7 +481,7 @@
 		};
 
 		uart9: serial@48424000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x48424000 0x100>;
 			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart9";
@@ -490,7 +490,7 @@
 		};
 
 		uart10: serial@4ae2b000 {
-			compatible = "ti,omap4-uart";
+			compatible = "ti,dra742-uart", "ti,omap4-uart";
 			reg = <0x4ae2b000 0x100>;
 			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart10";
-- 
2.4.4.408.g16da57c

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
