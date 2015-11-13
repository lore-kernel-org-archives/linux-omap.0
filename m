From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 38/39] ARM: dts: omap5-cm-t54: Use OMAP5_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:16 -0300
Message-ID: <1447390457-1158-39-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap5-cm-t54.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 3774b37be6c8..0c03dca9ea04 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -175,7 +175,7 @@
 
 	ads7846_pins: pinmux_ads7846_pins {
 		pinctrl-single,pins = <
-			0x02 (PIN_INPUT_PULLDOWN | MUX_MODE6)  /* llib_wakereqin.gpio1_wk15 */
+			OMAP5_IOPAD(0x0042, PIN_INPUT_PULLDOWN | MUX_MODE6)  /* llib_wakereqin.gpio1_wk15 */
 		>;
 	};
 };
-- 
2.4.3
