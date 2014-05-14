From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] ARM: dts: Enable twl4030 off-idle configuration for selected omaps
Date: Tue, 13 May 2014 18:34:10 -0700
Message-ID: <1400031250-29542-8-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44846 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752588AbaENBeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 21:34:24 -0400
In-Reply-To: <1400031250-29542-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

N900 now seems to shut down the external oscillator when hitting
off-idle.

And Beagle XM seems to have OSC_EN pin connected to allow shutting
down the oscillator looking at the schematics. The oscillator
output is cut off in off-idle and you can monitor it from R56 on
the bottom side of the board near the power jack. Note that for
beagle we need to also enable the UART wake-up event, the others
have that enabled in earlier patches.

OMAP37XX EVM (TMDSEVM3730) does not seem to have twl4030 clken
pin connected, so there is no point trying to enable shutting
down of the oscillator on it for the extra latency it adds.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts   | 6 ++++++
 arch/arm/boot/dts/omap3-evm-common.dtsi | 7 +++++++
 arch/arm/boot/dts/omap3-n900.dts        | 5 +++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 447e714..b05814b 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -152,6 +152,11 @@
 			codec {
 			};
 		};
+
+		twl_power: power {
+			compatible = "ti,twl4030-power-beagleboard-xm", "ti,twl4030-power-idle-osc-off";
+			ti,use_poweroff;
+		};
 	};
 };
 
@@ -211,6 +216,7 @@
 };
 
 &uart3 {
+	interrupts-extended = <&intc 74 &omap3_pmx_core OMAP3_UART3_RX>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 };
diff --git a/arch/arm/boot/dts/omap3-evm-common.dtsi b/arch/arm/boot/dts/omap3-evm-common.dtsi
index 3007e79..7e44e29 100644
--- a/arch/arm/boot/dts/omap3-evm-common.dtsi
+++ b/arch/arm/boot/dts/omap3-evm-common.dtsi
@@ -45,6 +45,13 @@
 #include "twl4030.dtsi"
 #include "twl4030_omap3.dtsi"
 
+&twl {
+	twl_power: power {
+		compatible = "ti,twl4030-power-omap3-evm", "ti,twl4030-power-idle";
+		ti,use_poweroff;
+	};
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 869bdd9..09ae615 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -277,6 +277,11 @@
 		compatible = "ti,twl4030-audio";
 		ti,enable-vibra = <1>;
 	};
+
+	twl_power: power {
+		compatible = "ti,twl4030-power-n900", "ti,twl4030-power-idle-osc-off";
+		ti,use_poweroff;
+	};
 };
 
 &twl_gpio {
-- 
1.8.1.1

