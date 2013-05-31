From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH 3/3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line
Date: Fri, 31 May 2013 15:45:57 -0700
Message-ID: <1370040357-25794-4-git-send-email-khilman@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50034 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab3EaWqI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 18:46:08 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2920220pdj.1
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 15:46:08 -0700 (PDT)
In-Reply-To: <1370040357-25794-1-git-send-email-khilman@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

On most OMAP3 platforms, the twl4030 IRQ line is connected to the
SYS_NIRQ line on OMAP.  Therefore, configure the defaults for the
SYS_NIRQ pin in the twl4030 DTS file.

Boards that hook up the twl4030 differently can easily override this
in their board-specific DTS file.

This allows RTC wake from off-mode to work again on OMAP3-based
platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
3530/Overo, 3730/Overo-STORM.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/boot/dts/twl4030.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index b3034da..c7fe9f6 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -13,6 +13,8 @@
 	compatible = "ti,twl4030";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&twl4030_pins>;
 
 	rtc {
 		compatible = "ti,twl4030-rtc";
@@ -92,3 +94,18 @@
 		#pwm-cells = <2>;
 	};
 };
+
+&omap3_pmx_core {
+	/*
+	 * On most OMAP3 platforms, the twl4030 IRQ line is connected
+         * to the SYS_NIRQ line on OMAP.  Therefore, configure the
+         * defaults for the SYS_NIRQ pin here.  Boards that hook up
+         * the twl4030 differently can easily override this in their
+         * board-specific DTS file.
+	 */
+	twl4030_pins: pinmux_twl4030_pins {
+		pinctrl-single,pins = <
+			0x1b0 0x4118 /*	sys_nirq.sys_nirq WAKEUP | INPUT_PULLUP | MODE 0 */
+		>;
+	};
+};
-- 
1.8.2

