From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V3 2/3] ARM: dts: omap5: EMIF device tree data for OMAP5 boards
Date: Mon, 5 Nov 2012 18:22:51 +0530
Message-ID: <1352119972-13710-3-git-send-email-lokeshvutla@ti.com>
References: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55927 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432Ab2KEMxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 07:53:08 -0500
In-Reply-To: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, lokeshvutla@ti.com

Adding EMIF device tree data for OMAP5 boards.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index ead74c8..790bb2a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -474,5 +474,27 @@
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
 		};
+
+		emif1: emif@0x4c000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif1";
+			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
+			reg = <0x4c000000 0x400>;
+			interrupts = <0 110 0x4>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
+		emif2: emif@0x4d000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif2";
+			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
+			reg = <0x4d000000 0x400>;
+			interrupts = <0 111 0x4>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
 	};
 };
-- 
1.7.9.5

