From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND 02/10] ARM: dts: AM33XX: Add matrix keypad device tree data to am335x-evm
Date: Tue, 6 Nov 2012 19:18:30 +0530
Message-ID: <1352209718-5586-3-git-send-email-anilkumar@ti.com>
References: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54745 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab2KFNuC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 08:50:02 -0500
In-Reply-To: <1352209718-5586-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add matrix keypad device tree data to am335x-evm by adding all
the necessary parameters like keymap, row & column gpios and etc.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 9199456..8076e66 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -110,6 +110,26 @@
 		regulator-name = "lis3_reg";
 		regulator-boot-on;
 	};
+
+	matrix_keypad: matrix_keypad@0 {
+		compatible = "gpio-matrix-keypad";
+		debounce-delay-ms = <5>;
+		col-scan-delay-us = <2>;
+
+		row-gpios = <&gpio2 25 0	/* Bank1, pin25 */
+			     &gpio2 26 0	/* Bank1, pin26 */
+			     &gpio2 27 0>;	/* Bank1, pin27 */
+
+		col-gpios = <&gpio2 21 0	/* Bank1, pin21 */
+			     &gpio2 22 0>;	/* Bank1, pin22 */
+
+		linux,keymap = <0x0000008b	/* MENU */
+				0x0100009e	/* BACK */
+				0x02000069	/* LEFT */
+				0x0001006a	/* RIGHT */
+				0x0101001c	/* ENTER */
+				0x0201006c>;	/* DOWN */
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.9.5

