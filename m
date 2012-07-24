From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 2/2] arm/dts: Configure pinmuxs for user leds control on Bone
Date: Tue, 24 Jul 2012 21:15:19 +0530
Message-ID: <1343144719-26352-3-git-send-email-anilkumar@ti.com>
References: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41278 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab2GXPps (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 11:45:48 -0400
In-Reply-To: <1343144719-26352-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 8fdf43a..b0c98cd 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -46,3 +46,18 @@
 	regulator-boot-on;
 	regulator-always-on;
 };
+
+&am3358_pinmux {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&userled_pins>;
+
+	userled_pins: pinmux_userled_pins {
+		pinctrl-single,pins = <
+			0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+			0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
+			0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
+			0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+		>;
+	};
+};
-- 
1.7.9.5

