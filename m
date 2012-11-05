From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 05/10] ARM: dts: AM33XX: Add pinmux configuration for user-leds to BONE
Date: Mon, 5 Nov 2012 16:15:45 +0530
Message-ID: <1352112350-13398-6-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57521 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab2KEKqI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 05:46:08 -0500
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add pinmux configurations for gpio based user-keys to am335x-bone.
In this patch, only single named mode/state is added and these pins
are configured during pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 6f9c48e..0bd0355 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -24,6 +24,20 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am33xx_pinmux: pinmux@44e10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&user_leds_s0>;
+
+		user_leds_s0: user_leds_s0 {
+			pinctrl-single,pins = <
+				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
+				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
+				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial@44e09000 {
 			status = "okay";
-- 
1.7.9.5

