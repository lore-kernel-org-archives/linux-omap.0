From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND v4 2/3] arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
Date: Tue, 28 Aug 2012 13:40:53 +0530
Message-ID: <1346141454-18786-3-git-send-email-anilkumar@ti.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44704 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab2H1ILg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 04:11:36 -0400
In-Reply-To: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a7906cb..58f5042 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,6 +18,20 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am3358_pinmux: pinmux@44E10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&userled_pins>;
+
+		userled_pins: pinmux_userled_pins {
+			pinctrl-single,pins = <
+				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
+				0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
+				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial@44E09000 {
 			status = "okay";
-- 
1.7.9.5

