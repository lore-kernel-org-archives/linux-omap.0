From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 30/39] ARM: dts: twl4030: Use OMAP3_CORE1_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:08 -0300
Message-ID: <1447390457-1158-31-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macro to define the register absolute physical
address instead of the offset from the padconf base address. This
makes the DTS easier to read since matches the addresses listed in
the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/twl4030_omap3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/twl4030_omap3.dtsi b/arch/arm/boot/dts/twl4030_omap3.dtsi
index 3537ae5b2146..5288e6dffef7 100644
--- a/arch/arm/boot/dts/twl4030_omap3.dtsi
+++ b/arch/arm/boot/dts/twl4030_omap3.dtsi
@@ -19,7 +19,7 @@
 	 */
 	twl4030_pins: pinmux_twl4030_pins {
 		pinctrl-single,pins = <
-			0x1b0 (PIN_INPUT_PULLUP | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* sys_nirq.sys_nirq */
+			OMAP3_CORE1_IOPAD(0x21e0, PIN_INPUT_PULLUP | PIN_OFF_WAKEUPENABLE | MUX_MODE0) /* sys_nirq.sys_nirq */
 		>;
 	};
 };
-- 
2.4.3
