From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH v3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line
Date: Fri,  7 Jun 2013 11:31:26 -0700
Message-ID: <1370629886-14170-1-git-send-email-khilman@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:61873 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab3FGSba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 14:31:30 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so5177454pdj.28
        for <linux-omap@vger.kernel.org>; Fri, 07 Jun 2013 11:31:30 -0700 (PDT)
In-Reply-To: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>, Nishanth Menon <nm@ti.com>

On most OMAP3 platforms, the twl4030 IRQ line is connected to the
SYS_NIRQ line on OMAP.  Add another DTS include file
(twl4030_omap3.dtsi) for boards that hook up the twl4030 this way
to include.

This allows RTC wake from off-mode to work again on OMAP3-based
platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
3530/Overo, 3730/Overo-STORM.

Special thanks to Florian Vaussard for suggesting use of preprocessor
feature.

Cc: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
v3: renamed to twl4030_omap3 (suggested by Nishanth), add GPL, fix whitespace
v2: Updated to change board files instead of twl4030 file.

 arch/arm/boot/dts/omap3-beagle-xm.dts  |  1 +
 arch/arm/boot/dts/omap3-beagle.dts     |  1 +
 arch/arm/boot/dts/omap3-devkit8000.dts |  1 +
 arch/arm/boot/dts/omap3-evm.dts        |  1 +
 arch/arm/boot/dts/omap3-igep.dtsi      |  1 +
 arch/arm/boot/dts/omap3-overo.dtsi     |  1 +
 arch/arm/boot/dts/omap3430-sdp.dts     |  1 +
 arch/arm/boot/dts/twl4030_omap3.dtsi   | 25 +++++++++++++++++++++++++
 8 files changed, 32 insertions(+)
 create mode 100644 arch/arm/boot/dts/twl4030_omap3.dtsi

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index ad17b6b..afdb164 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -96,6 +96,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index eb7e02a..dfd8310 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -135,6 +135,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 5be71b1..af32eff 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -81,6 +81,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index baa24bb..7d4329d 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -45,6 +45,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 5224c29..bc48b11 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -87,6 +87,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 144a5a2..4bc78896 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -50,6 +50,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 /* i2c2 pins are used for gpio */
 &i2c2 {
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 2a725a0..c4a1c0a 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -29,6 +29,7 @@
 };
 
 #include "twl4030.dtsi"
+#include "twl4030_omap3.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/twl4030_omap3.dtsi b/arch/arm/boot/dts/twl4030_omap3.dtsi
new file mode 100644
index 0000000..c353ef0
--- /dev/null
+++ b/arch/arm/boot/dts/twl4030_omap3.dtsi
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2013 Linaro, Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&twl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&twl4030_pins>;
+};
+
+&omap3_pmx_core {
+	/*
+	 * On most OMAP3 platforms, the twl4030 IRQ line is connected
+	 * to the SYS_NIRQ line on OMAP.  Therefore, configure the
+	 * defaults for the SYS_NIRQ pin here.
+	 */
+	twl4030_pins: pinmux_twl4030_pins {
+		pinctrl-single,pins = <
+			0x1b0 (PIN_INPUT_PULLUP | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* sys_nirq.sys_nirq */
+		>;
+	};
+};
-- 
1.8.3

