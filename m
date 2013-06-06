From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH v2 3/3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line
Date: Thu,  6 Jun 2013 16:27:33 -0700
Message-ID: <1370561253-15523-1-git-send-email-khilman@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49584 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3FFX1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 19:27:37 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so3831243pbc.40
        for <linux-omap@vger.kernel.org>; Thu, 06 Jun 2013 16:27:36 -0700 (PDT)
In-Reply-To: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

On most OMAP3 platforms, the twl4030 IRQ line is connected to the
SYS_NIRQ line on OMAP.  Add another DTS include file
(twl4030_omap3_mux.dtsi) for boards that hook up the twl4030 this way
to include.

This allows RTC wake from off-mode to work again on OMAP3-based
platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
3530/Overo, 3730/Overo-STORM.

Special thanks to Florian Vaussard for suggesting use of preprocessor
feature.

Cc: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
v2: Updated to change board files instead of twl4030 file.

 arch/arm/boot/dts/omap3-beagle-xm.dts    |  1 +
 arch/arm/boot/dts/omap3-beagle.dts       |  1 +
 arch/arm/boot/dts/omap3-devkit8000.dts   |  1 +
 arch/arm/boot/dts/omap3-evm.dts          |  1 +
 arch/arm/boot/dts/omap3-igep.dtsi        |  1 +
 arch/arm/boot/dts/omap3-overo.dtsi       |  1 +
 arch/arm/boot/dts/omap3430-sdp.dts       |  1 +
 arch/arm/boot/dts/twl4030_omap3_mux.dtsi | 17 +++++++++++++++++
 8 files changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/twl4030_omap3_mux.dtsi

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index ad17b6b..1afb563 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -96,6 +96,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3_mux.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index eb7e02a..d5810d7 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -135,6 +135,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3_mux.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 5be71b1..166b90c 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -81,6 +81,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3_mux.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index baa24bb..ad7ab86 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -45,6 +45,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3_mux.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 5224c29..3107dc3 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -87,6 +87,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3_mux.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 144a5a2..bb55907 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -50,6 +50,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3_mux.dtsi"
 
 /* i2c2 pins are used for gpio */
 &i2c2 {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 2a725a0..df3b918 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -29,6 +29,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3_mux.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/twl4030_omap3_mux.dtsi b/arch/arm/boot/dts/twl4030_omap3_mux.dtsi
new file mode 100644
index 0000000..1bd0f9f
--- /dev/null
+++ b/arch/arm/boot/dts/twl4030_omap3_mux.dtsi
@@ -0,0 +1,17 @@
+&twl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&twl4030_pins>;
+};
+
+&omap3_pmx_core {
+	/*
+	 * On most OMAP3 platforms, the twl4030 IRQ line is connected
+         * to the SYS_NIRQ line on OMAP.  Therefore, configure the
+         * defaults for the SYS_NIRQ pin here.
+	 */
+	twl4030_pins: pinmux_twl4030_pins {
+		pinctrl-single,pins = <
+			0x1b0 (PIN_INPUT_PULLUP | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* sys_nirq.sys_nirq */
+		>;
+	};
+};
-- 
1.8.3

