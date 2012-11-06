From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND 01/10] ARM: dts: AM33XX: Add pinmux configuration for matrix keypad to EVM
Date: Tue, 6 Nov 2012 19:18:29 +0530
Message-ID: <1352209718-5586-2-git-send-email-anilkumar@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52705 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094Ab2KFNuI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 08:50:08 -0500
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add pinmux configurations for gpio matrix keypad. In this patch, only
single named mode/state is added and these pins are configured during
pinctrl driver initialization.

Default mode is nothing but the values required for the module during
active state. With this configurations module is functional as
expected.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 513284f..9199456 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -24,6 +24,21 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am33xx_pinmux: pinmux@44e10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&matrix_keypad_s0>;
+
+		matrix_keypad_s0: matrix_keypad_s0 {
+			pinctrl-single,pins = <
+				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+				0x58 0x7	/* gpmc_a6.gpio1_22, OUTPUT | MODE7 */
+				0x64 0x27	/* gpmc_a9.gpio1_25, INPUT | MODE7 */
+				0x68 0x27	/* gpmc_a10.gpio1_26, INPUT | MODE7 */
+				0x6c 0x27	/* gpmc_a11.gpio1_27, INPUT | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial@44e09000 {
 			status = "okay";
-- 
1.7.9.5

