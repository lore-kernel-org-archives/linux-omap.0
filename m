From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] ARM: dts: Fix omap2 specific dtsi files by adding the missing entries
Date: Wed, 13 Nov 2013 18:35:37 -0800
Message-ID: <1384396537-3486-9-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46515 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752609Ab3KNCfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Nov 2013 21:35:51 -0500
In-Reply-To: <1384396537-3486-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org

Looks like we're missing few entries for omap2 and the drivers
have only worked because of the omap hwmod building the devices
for the missing entries.

Let's fix the missing entries so we don't need to rely on hwmod
for the basic data and can then later on remove the duplicate
data from hwmod. Otherwise device tree only drivers will not
work properly.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap2.dtsi    | 96 +++++++++++++++++++++++++++++++++=
++++++++
 arch/arm/boot/dts/omap2420.dtsi | 23 ++++++++++
 arch/arm/boot/dts/omap2430.dtsi | 49 +++++++++++++++++++++
 3 files changed, 168 insertions(+)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dts=
i
index a2bfcde..d0c5b37 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -9,6 +9,7 @@
  */
=20
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/omap.h>
=20
 #include "skeleton.dtsi"
@@ -21,6 +22,8 @@
 		serial0 =3D &uart1;
 		serial1 =3D &uart2;
 		serial2 =3D &uart3;
+		i2c0 =3D &i2c1;
+		i2c1 =3D &i2c2;
 	};
=20
 	cpus {
@@ -53,6 +56,28 @@
 		ranges;
 		ti,hwmods =3D "l3_main";
=20
+		aes: aes@480a6000 {
+			compatible =3D "ti,omap2-aes";
+			ti,hwmods =3D "aes";
+			reg =3D <0x480a6000 0x50>;
+			dmas =3D <&sdma 9 &sdma 10>;
+			dma-names =3D "tx", "rx";
+		};
+
+		hdq1w: 1w@480b2000 {
+			compatible =3D "ti,omap2420-1w";
+			ti,hwmods =3D "hdq1w";
+			reg =3D <0x480b2000 0x1000>;
+			interrupts =3D <58>;
+		};
+
+		mailbox: mailbox@48094000 {
+			compatible =3D "ti,omap2-mailbox";
+			ti,hwmods =3D "mailbox";
+			reg =3D <0x48094000 0x200>;
+			interrupts =3D <26>;
+		};
+
 		intc: interrupt-controller@1 {
 			compatible =3D "ti,omap2-intc";
 			interrupt-controller;
@@ -63,6 +88,7 @@
=20
 		sdma: dma-controller@48056000 {
 			compatible =3D "ti,omap2430-sdma", "ti,omap2420-sdma";
+			ti,hwmods =3D "dma";
 			reg =3D <0x48056000 0x1000>;
 			interrupts =3D <12>,
 				     <13>,
@@ -73,21 +99,91 @@
 			#dma-requests =3D <64>;
 		};
=20
+		i2c1: i2c@48070000 {
+			compatible =3D "ti,omap2-i2c";
+			ti,hwmods =3D "i2c1";
+			reg =3D <0x48070000 0x80>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			interrupts =3D <56>;
+			dmas =3D <&sdma 27 &sdma 28>;
+			dma-names =3D "tx", "rx";
+		};
+
+		i2c2: i2c@48072000 {
+			compatible =3D "ti,omap2-i2c";
+			ti,hwmods =3D "i2c2";
+			reg =3D <0x48072000 0x80>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			interrupts =3D <57>;
+			dmas =3D <&sdma 29 &sdma 30>;
+			dma-names =3D "tx", "rx";
+		};
+
+		mcspi1: mcspi@48098000 {
+			compatible =3D "ti,omap2-mcspi";
+			ti,hwmods =3D "mcspi1";
+			reg =3D <0x48098000 0x100>;
+			interrupts =3D <65>;
+			dmas =3D <&sdma 35 &sdma 36 &sdma 37 &sdma 38
+				&sdma 39 &sdma 40 &sdma 41 &sdma 42>;
+			dma-names =3D "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
+		};
+
+		mcspi2: mcspi@4809a000 {
+			compatible =3D "ti,omap2-mcspi";
+			ti,hwmods =3D "mcspi2";
+			reg =3D <0x4809a000 0x100>;
+			interrupts =3D <66>;
+			dmas =3D <&sdma 43 &sdma 44 &sdma 45 &sdma 46>;
+			dma-names =3D "tx0", "rx0", "tx1", "rx1";
+		};
+
+		rng: rng@480a0000 {
+			compatible =3D "ti,omap2-rng";
+			ti,hwmods =3D "rng";
+			reg =3D <0x480a0000 0x50>;
+			interrupts =3D <36>;
+		};
+
+		sham: sham@480a4000 {
+			compatible =3D "ti,omap2-sham";
+			ti,hwmods =3D "sham";
+			reg =3D <0x480a4000 0x64>;
+			interrupts =3D <51>;
+			dmas =3D <&sdma 13>;
+			dma-names =3D "rx";
+		};
+
 		uart1: serial@4806a000 {
 			compatible =3D "ti,omap2-uart";
 			ti,hwmods =3D "uart1";
+			reg =3D <0x4806a000 0x2000>;
+			interrupts =3D <72>;
+			dmas =3D <&sdma 49 &sdma 50>;
+			dma-names =3D "tx", "rx";
 			clock-frequency =3D <48000000>;
 		};
=20
 		uart2: serial@4806c000 {
 			compatible =3D "ti,omap2-uart";
 			ti,hwmods =3D "uart2";
+			reg =3D <0x4806c000 0x400>;
+			interrupts =3D <73>;
+			dmas =3D <&sdma 51 &sdma 52>;
+			dma-names =3D "tx", "rx";
 			clock-frequency =3D <48000000>;
 		};
=20
 		uart3: serial@4806e000 {
 			compatible =3D "ti,omap2-uart";
 			ti,hwmods =3D "uart3";
+			reg =3D <0x4806e000 0x400>;
+			interrupts =3D <74>;
+			dmas =3D <&sdma 53 &sdma 54>;
+			dma-names =3D "tx", "rx";
 			clock-frequency =3D <48000000>;
 		};
=20
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap24=
20.dtsi
index c8f9c55..60c605d 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -114,6 +114,15 @@
 			dma-names =3D "tx", "rx";
 		};
=20
+		msdi1: mmc@4809c000 {
+			compatible =3D "ti,omap2420-mmc";
+			ti,hwmods =3D "msdi1";
+			reg =3D <0x4809c000 0x80>;
+			interrupts =3D <83>;
+			dmas =3D <&sdma 61 &sdma 62>;
+			dma-names =3D "tx", "rx";
+		};
+
 		timer1: timer@48028000 {
 			compatible =3D "ti,omap2420-timer";
 			reg =3D <0x48028000 0x400>;
@@ -121,5 +130,19 @@
 			ti,hwmods =3D "timer1";
 			ti,timer-alwon;
 		};
+
+		wd_timer2: wdt@48022000 {
+			compatible =3D "ti,omap2-wdt";
+			ti,hwmods =3D "wd_timer2";
+			reg =3D <0x48022000 0x80>;
+		};
 	};
 };
+
+&i2c1 {
+	compatible =3D "ti,omap2420-i2c";
+};
+
+&i2c2 {
+	compatible =3D "ti,omap2420-i2c";
+};
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap24=
30.dtsi
index c535a5a..d624345 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -175,6 +175,25 @@
 			dma-names =3D "tx", "rx";
 		};
=20
+		mmc1: mmc@4809c000 {
+			compatible =3D "ti,omap2-hsmmc";
+			reg =3D <0x4809c000 0x200>;
+			interrupts =3D <83>;
+			ti,hwmods =3D "mmc1";
+			ti,dual-volt;
+			dmas =3D <&sdma 61>, <&sdma 62>;
+			dma-names =3D "tx", "rx";
+		};
+
+		mmc2: mmc@480b4000 {
+			compatible =3D "ti,omap2-hsmmc";
+			reg =3D <0x480b4000 0x200>;
+			interrupts =3D <86>;
+			ti,hwmods =3D "mmc2";
+			dmas =3D <&sdma 47>, <&sdma 48>;
+			dma-names =3D "tx", "rx";
+		};
+
 		timer1: timer@49018000 {
 			compatible =3D "ti,omap2420-timer";
 			reg =3D <0x49018000 0x400>;
@@ -182,5 +201,35 @@
 			ti,hwmods =3D "timer1";
 			ti,timer-alwon;
 		};
+
+		mcspi3: mcspi@480b8000 {
+			compatible =3D "ti,omap2-mcspi";
+			ti,hwmods =3D "mcspi3";
+			reg =3D <0x480b8000 0x100>;
+			interrupts =3D <91>;
+			dmas =3D <&sdma 15 &sdma 16 &sdma 23 &sdma 24>;
+			dma-names =3D "tx0", "rx0", "tx1", "rx1";
+		};
+
+		usb_otg_hs: usb_otg_hs@480ac000 {
+			compatible =3D "ti,omap2-musb";
+			ti,hwmods =3D "usb_otg_hs";
+			reg =3D <0x480ac000 0x1000>;
+			interrupts =3D <93>;
+		};
+
+		wd_timer2: wdt@49016000 {
+			compatible =3D "ti,omap2-wdt";
+			ti,hwmods =3D "wd_timer2";
+			reg =3D <0x49016000 0x80>;
+		};
 	};
 };
+
+&i2c1 {
+	compatible =3D "ti,omap2430-i2c";
+};
+
+&i2c2 {
+	compatible =3D "ti,omap2430-i2c";
+};
--=20
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
