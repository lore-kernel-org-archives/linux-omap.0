From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 05/39] ARM: dts: am335x-bonegreen: Use AM33XX_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:53:43 -0300
Message-ID: <1447390457-1158-6-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-bonegreen.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bonegreen.dts b/arch/arm/boot/dts/am335x-bonegreen.dts
index 0f65bdaaa583..dce3c8657e04 100644
--- a/arch/arm/boot/dts/am335x-bonegreen.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen.dts
@@ -36,8 +36,8 @@
 &am33xx_pinmux {
 	uart2_pins: uart2_pins {
 		pinctrl-single,pins = <
-			0x150 (PIN_INPUT | MUX_MODE1)	/* spi0_sclk.uart2_rxd */
-			0x154 (PIN_OUTPUT | MUX_MODE1)	/* spi0_d0.uart2_txd */
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)	/* spi0_sclk.uart2_rxd */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)	/* spi0_d0.uart2_txd */
 		>;
 	};
 };
-- 
2.4.3
