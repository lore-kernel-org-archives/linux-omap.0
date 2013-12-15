From: Sebastian Reichel <sre@debian.org>
Subject: [RFCv4 11/11] DTS: ARM: OMAP3-N900: Add SSI protocol support
Date: Mon, 16 Dec 2013 00:28:04 +0100
Message-ID: <1387150085-23173-12-git-send-email-sre@debian.org>
References: <1387150085-23173-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387150085-23173-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, =?UTF-8?q?=D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE=20=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

This adds support for the protocol used to communicate
with its cellular modem.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index c557a77..576a95c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -534,6 +534,7 @@
 	power = <50>;
 };
 
+#include <dt-bindings/hsi/hsi.h>
 &ssi_port1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ssi_pins>;
@@ -543,6 +544,18 @@
 	ssi-char {
 		compatible = "ssi-char";
 	};
+
+	ssi-protocol {
+		compatible = "ssi-protocol";
+
+		hsi,mode = <HSI_MODE_FRAME>;
+		hsi,channels = <4>;
+		hsi,speed = <55000>;
+		hsi,flow = <HSI_FLOW_SYNC>;
+		hsi,arb_mode = <HSI_ARB_RR>;
+
+		nokia,cmt = <&cmt>;
+	};
 };
 
 &ssi_port2 {
-- 
1.8.5.1
