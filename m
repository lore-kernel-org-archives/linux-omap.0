From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/7] ARM: dts: overo: Add LIS33DE accelerometer
Date: Tue, 11 Mar 2014 13:20:30 +0100
Message-ID: <1394540435-25401-3-git-send-email-florian.vaussard@epfl.ch>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:54240 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbaCKMU4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:20:56 -0400
In-Reply-To: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The LIS33DE accelerometer is used on several Gumstix expansion boards,
thus add the DT node to omap3-overo-common-peripherals.dtsi.

For the boards that do not have the accelerometer (like Tobi), mark the
status as disabled.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 .../boot/dts/omap3-overo-common-peripherals.dtsi   | 44 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     |  4 ++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi b/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
index bca81ae..5831bcc 100644
--- a/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-peripherals.dtsi
@@ -10,6 +10,22 @@
  * Peripherals common to all Gumstix Overo boards (Tobi, Summit, Palo43,...)
  */
 
+/ {
+	lis33_3v3: lis33-3v3-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "lis33-3v3-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	lis33_1v8: lis33-1v8-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "lis33-1v8-reg";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
 &omap3_pmx_core {
 	i2c3_pins: pinmux_i2c3_pins {
 		pinctrl-single,pins = <
@@ -37,6 +53,34 @@
 		reg = <0x51>;
 		pagesize = <8>;
 	};
+
+	lis33de: lis33de@1d {
+		compatible = "st,lis33de", "st,lis3lv02d";
+		reg = <0x1d>;
+		Vdd-supply = <&lis33_1v8>;
+		Vdd_IO-supply = <&lis33_3v3>;
+
+		st,click-single-x;
+		st,click-single-y;
+		st,click-single-z;
+		st,click-thresh-x = <10>;
+		st,click-thresh-y = <10>;
+		st,click-thresh-z = <10>;
+		st,irq1-click;
+		st,irq2-click;
+		st,wakeup-x-lo;
+		st,wakeup-x-hi;
+		st,wakeup-y-lo;
+		st,wakeup-y-hi;
+		st,wakeup-z-lo;
+		st,wakeup-z-hi;
+		st,min-limit-x = <120>;
+		st,min-limit-y = <120>;
+		st,min-limit-z = <140>;
+		st,max-limit-x = <550>;
+		st,max-limit-y = <550>;
+		st,max-limit-z = <750>;
+	};
 };
 
 &mmc3 {
diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index 060eb77..13df50b 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -35,3 +35,7 @@
 	};
 };
 
+&lis33de {
+	status = "disabled";
+};
+
-- 
1.8.3.2

