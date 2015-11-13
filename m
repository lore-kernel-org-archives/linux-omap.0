From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 39/39] ARM: dts: omap5-uevm.dts: Use OMAP5_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:17 -0300
Message-ID: <1447390457-1158-40-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap5-uevm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 05b1c1ebded8..60b3fbb3bf07 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -40,8 +40,8 @@
 &omap5_pmx_core {
 	i2c5_pins: pinmux_i2c5_pins {
 		pinctrl-single,pins = <
-			0x186 (PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
-			0x188 (PIN_INPUT | MUX_MODE0)		/* i2c5_sda */
+			OMAP5_IOPAD(0x1c6, PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
+			OMAP5_IOPAD(0x1c8, PIN_INPUT | MUX_MODE0)		/* i2c5_sda */
 		>;
 	};
 };
-- 
2.4.3
