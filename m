From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: dts: Fix GPMC Ethernet timings for omap cm-t sbc-t boards for device tree
Date: Wed, 23 Apr 2014 12:03:22 -0700
Message-ID: <1398279803-5655-3-git-send-email-tony@atomide.com>
References: <1398279803-5655-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20667 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932099AbaDWTD2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 15:03:28 -0400
In-Reply-To: <1398279803-5655-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Looks like we have wrong GPMC timings we have for the cm-t and
sbc-t boards. This can cause occasional strange errors with at
least doing an rsync of large files or doing apt-get dist-upgrade.

Let's fix the issue in two phases. First let's simplify cm-t and
sbc-t to use the shared omap-gpmc-smsc911x.dtsi to avoid fixing
the issue in multiple places. Then we can fix the timings in
a single place with a follow-up patch.

Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi | 42 +++--------------------------------
 arch/arm/boot/dts/omap3-sb-t35.dtsi   | 18 ++-------------
 arch/arm/boot/dts/omap3-sbc-t3517.dts | 13 +++++++++++
 3 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index 75e0a1f..25ba083 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -10,18 +10,6 @@
 			cpu0-supply = <&vcc>;
 		};
 	};
-
-	vddvario: regulator-vddvario {
-		compatible = "regulator-fixed";
-		regulator-name = "vddvario";
-		regulator-always-on;
-	};
-
-	vdd33a: regulator-vdd33a {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd33a";
-		regulator-always-on;
-	};
 };
 
 &omap3_pmx_core {
@@ -51,42 +39,18 @@
 	};
 };
 
+#include "omap-gpmc-smsc911x.dtsi"
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x01000000>;
 
-	smsc1: ethernet@5,0 {
+	smsc1: ethernet@gpmc {
 		compatible = "smsc,lan9221", "smsc,lan9115";
 		pinctrl-names = "default";
 		pinctrl-0 = <&smsc1_pins>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		reg = <5 0 0xff>;
-		bank-width = <2>;
-		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <186>;
-		gpmc,cs-wr-off-ns = <186>;
-		gpmc,adv-on-ns = <12>;
-		gpmc,adv-rd-off-ns = <48>;
-		gpmc,adv-wr-off-ns = <48>;
-		gpmc,oe-on-ns = <54>;
-		gpmc,oe-off-ns = <168>;
-		gpmc,we-on-ns = <54>;
-		gpmc,we-off-ns = <168>;
-		gpmc,rd-cycle-ns = <186>;
-		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <114>;
-		gpmc,page-burst-access-ns = <6>;
-		gpmc,bus-turnaround-ns = <12>;
-		gpmc,cycle2cycle-delay-ns = <18>;
-		gpmc,wr-data-mux-bus-ns = <90>;
-		gpmc,wr-access-ns = <186>;
-		gpmc,cycle2cycle-samecsen;
-		gpmc,cycle2cycle-diffcsen;
-		vddvario-supply = <&vddvario>;
-		vdd33a-supply = <&vdd33a>;
-		reg-io-width = <4>;
-		smsc,save-mac-address;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index 7909c51..b3b6e43 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -2,20 +2,6 @@
  * Common support for CompuLab SB-T35 used on SBC-T3530, SBC-T3517 and SBC-T3730
  */
 
-/ {
-	vddvario_sb_t35: regulator-vddvario-sb-t35 {
-		compatible = "regulator-fixed";
-		regulator-name = "vddvario";
-		regulator-always-on;
-	};
-
-	vdd33a_sb_t35: regulator-vdd33a-sb-t35 {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd33a";
-		regulator-always-on;
-	};
-};
-
 &omap3_pmx_core {
 	smsc2_pins: pinmux_smsc2_pins {
 		pinctrl-single,pins = <
@@ -57,8 +43,8 @@
 		gpmc,wr-access-ns = <186>;
 		gpmc,cycle2cycle-samecsen;
 		gpmc,cycle2cycle-diffcsen;
-		vddvario-supply = <&vddvario_sb_t35>;
-		vdd33a-supply = <&vdd33a_sb_t35>;
+		vddvario-supply = <&vddvario>;
+		vdd33a-supply = <&vdd33a>;
 		reg-io-width = <4>;
 		smsc,save-mac-address;
 	};
diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
index 024c9c6..42189b6 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
@@ -8,6 +8,19 @@
 / {
 	model = "CompuLab SBC-T3517 with CM-T3517";
 	compatible = "compulab,omap3-sbc-t3517", "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
+
+	/* Only one GPMC smsc9220 on SBC-T3517, CM-T3517 uses am35x Ethernet */
+	vddvario: regulator-vddvario-sb-t35 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
+	};
+
+	vdd33a: regulator-vdd33a-sb-t35 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33a";
+		regulator-always-on;
+	};
 };
 
 &omap3_pmx_core {
-- 
1.8.1.1

