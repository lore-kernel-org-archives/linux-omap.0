From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 33/39] ARM: dts: omap4-panda-es: Use OMAP4_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:11 -0300
Message-ID: <1447390457-1158-34-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap4-panda-es.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 2f1dabcc6adf..119f8e657edc 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -34,23 +34,23 @@
 /* PandaboardES has external pullups on SCL & SDA */
 &dss_hdmi_pins {
 	pinctrl-single,pins = <
-		0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
-		0x5c (PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
-		0x5e (PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
+		OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+		OMAP4_IOPAD(0x09c, PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
+		OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
 		>;
 };
 
 &omap4_pmx_core {
 	led_gpio_pins: gpio_led_pmx {
 		pinctrl-single,pins = <
-			0xb6 (PIN_OUTPUT | MUX_MODE3)	/* gpio_110 */
+			OMAP4_IOPAD(0x0f6, PIN_OUTPUT | MUX_MODE3)	/* gpio_110 */
 		>;
 	};
 };
 
 &led_wkgpio_pins {
 	pinctrl-single,pins = <
-		0x1c (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
+		OMAP4_IOPAD(0x05c, PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
 	>;
 };
 
-- 
2.4.3
