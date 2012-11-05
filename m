From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 09/10] ARM: dts: AM33XX: Add pinmux configuration for gpio-keys to EVMSK
Date: Mon, 5 Nov 2012 16:15:49 +0530
Message-ID: <1352112350-13398-10-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50358 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab2KEKqH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 05:46:07 -0500
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add pinmux configurations for gpio based keys to am335x-evmsk. In
this patch, only single named mode/state is added and these pins
are configured during pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 7262fa8..0f825dd 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -32,7 +32,7 @@
 
 	am33xx_pinmux: pinmux@44e10800 {
 		pinctrl-names = "default";
-		pinctrl-0 = <&user_leds_s0>;
+		pinctrl-0 = <&user_leds_s0 &gpio_keys_s0>;
 
 		user_leds_s0: user_leds_s0 {
 			pinctrl-single,pins = <
@@ -42,6 +42,15 @@
 				0x1c 0x7	/* gpmc_ad7.gpio1_7, OUTPUT | MODE7 */
 			>;
 		};
+
+		gpio_keys_s0: gpio_keys_s0 {
+			pinctrl-single,pins = <
+				0x94 0x27	/* gpmc_oen_ren.gpio2_3, INPUT | MODE7 */
+				0x90 0x27	/* gpmc_advn_ale.gpio2_2, INPUT | MODE7 */
+				0x70 0x27	/* gpmc_wait0.gpio0_30, INPUT | MODE7 */
+				0x9c 0x27	/* gpmc_ben0_cle.gpio2_5, INPUT | MODE7 */
+			>;
+		};
 	};
 
 	ocp {
-- 
1.7.9.5

