From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/3] ARM: dts: omap3-igep: add pinmux node for GPIO LED configuration
Date: Thu, 20 Jun 2013 16:42:30 +0200
Message-ID: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:32831 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757896Ab3FTOmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 10:42:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

IGEP boards have a number of LED connected to OMAP or TWL GPIO
lines. The actual wiring is different on each board so each board
DT has need to configure the mux correctly.

Even though it works with the current DT, the kernel complains with:

[2.305023] leds-gpio leds.18: pins are not configured from the driver

Add an empty pinmux_leds_pins pinctrl child node so boards can
override with the correct mux configuration and not depend on
default values for the GPIO LEDs to work.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index bc48b11..55f9f61 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -68,6 +68,8 @@
 			0x1a2 (PIN_INPUT | MUX_MODE4)		/* mcspi1_cs2.gpio_176 */
 		>;
 	};
+
+	leds_pins: pinmux_leds_pins { };
 };
 
 &i2c1 {
-- 
1.7.7.6

