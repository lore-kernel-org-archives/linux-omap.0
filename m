From: Arun Bharadwaj <arun@gumstix.com>
Subject: [PATCH 2/3] ARM: dts: configure regulators for Gumstix Pepper
Date: Thu,  4 Jun 2015 11:08:18 -0700
Message-ID: <1433441299-18887-3-git-send-email-arun@gumstix.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433441299-18887-1-git-send-email-arun@gumstix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Adam YH Lee <adam.yh.lee@gmail.com>, Ash Charles <ashcharles@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Adam YH Lee <adam.yh.lee@gmail.com>

Boot process is halting in midway because some of the necessary voltage
regulators are deemed unused and subsequently powered off, leading to
a completely unresponsive system.

Most of the device nodes had correct voltage regulator attachments.
Yet these nodes had to set stricter enforcement on them through
'regulator-boot-on' and 'regulator-always-on' to function correctly.

Signed-off-by: Ash Charles <ashcharles@gmail.com>
---
 arch/arm/boot/dts/am335x-pepper.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 473d8ee..99f855d 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -415,6 +415,7 @@
 
 &v3v3c_reg {
 	regulator-name = "v3v3c_reg";
+	regulator-boot-on;
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
 	vin-supply = <&vbat>;
@@ -439,6 +440,8 @@
 	regulators {
 		dcdc1_reg: regulator@0 {
 			/* VDD_1V8 system supply */
+			regulator-name = "vdds_dpr";
+			regulator-always-on;
 		};
 
 		dcdc2_reg: regulator@1 {
@@ -447,6 +450,7 @@
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1325000>;
 			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		dcdc3_reg: regulator@2 {
@@ -455,25 +459,34 @@
 			regulator-min-microvolt = <925000>;
 			regulator-max-microvolt = <1150000>;
 			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		ldo1_reg: regulator@3 {
 			/* VRTC 1.8V always-on supply */
+			regulator-name = "vrtc,vdds";
 			regulator-always-on;
 		};
 
 		ldo2_reg: regulator@4 {
 			/* 3.3V rail */
+			regulator-name = "vdd_3v3aux";
+			regulator-always-on;
 		};
 
 		ldo3_reg: regulator@5 {
 			/* VDD_3V3A 3.3V rail */
+			regulator-name = "vdd_3v3a";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		ldo4_reg: regulator@6 {
 			/* VDD_3V3B 3.3V rail */
+			regulator-name = "vdd_3v3b";
+			regulator-always-on;
 		};
 	};
 };
-- 
2.1.4
