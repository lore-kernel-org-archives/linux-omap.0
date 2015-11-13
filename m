From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 36/39] ARM: dts: twl6030: Use OMAP4_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:14 -0300
Message-ID: <1447390457-1158-37-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macros to define the register as an offset from
the padconf physical address instead of the offset from padconf base.
This makes the DTS easier to read since matches the addresses listed
in the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/twl6030_omap4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/twl6030_omap4.dtsi b/arch/arm/boot/dts/twl6030_omap4.dtsi
index a4fa5703c42b..e373f59cea9c 100644
--- a/arch/arm/boot/dts/twl6030_omap4.dtsi
+++ b/arch/arm/boot/dts/twl6030_omap4.dtsi
@@ -24,7 +24,7 @@
 &omap4_pmx_wkup {
 	twl6030_wkup_pins: pinmux_twl6030_wkup_pins {
 		pinctrl-single,pins = <
-			0x14 (PIN_OUTPUT | MUX_MODE2)		/* fref_clk0_out.sys_drm_msecure */
+			OMAP4_IOPAD(0x054, PIN_OUTPUT | MUX_MODE2)		/* fref_clk0_out.sys_drm_msecure */
 		>;
 	};
 };
@@ -32,7 +32,7 @@
 &omap4_pmx_core {
 	twl6030_pins: pinmux_twl6030_pins {
 		pinctrl-single,pins = <
-			0x15e (WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE0)	/* sys_nirq1.sys_nirq1 */
+			OMAP4_IOPAD(0x19e, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE0)	/* sys_nirq1.sys_nirq1 */
 		>;
 	};
 };
-- 
2.4.3
