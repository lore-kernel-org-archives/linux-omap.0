From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 2/2] arm/dts: Configure pinmuxs for user leds control on Bone
Date: Thu, 5 Jul 2012 14:43:36 +0530
Message-ID: <1341479616-18630-3-git-send-email-anilkumar@ti.com>
References: <1341479616-18630-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53154 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2GEJOB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 05:14:01 -0400
In-Reply-To: <1341479616-18630-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a9af4db..c3810b7 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,3 +18,27 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&am3358_pinmux {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&userled_pins>;
+
+	userled_pins: pinmux_userled_pins {
+		gpmc_a5.gpio1_21 {
+			pinctrl-simple,cells = <0x54 0x7>;	/* OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
+		};
+
+		gpmc_a6.gpio1_22 {
+			pinctrl-simple,cells = <0x58 0x17>;	/* OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
+		};
+
+		gpmc_a7.gpio1_23 {
+			pinctrl-simple,cells = <0x5C 0x7>;	/* OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
+		};
+
+		gpmc_a8.gpio1_24 {
+			pinctrl-simple,cells = <0x60 0x17>;	/* OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
+		};
+	};
+};
-- 
1.7.9.5

