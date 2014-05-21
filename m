From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/6] ARM: dts: omap5-uevm.dts: add tca6424a
Date: Wed, 21 May 2014 15:50:24 +0300
Message-ID: <1400676625-30078-6-git-send-email-tomi.valkeinen@ti.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40158 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbaEUMvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:51:04 -0400
In-Reply-To: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap5-uevm has a tca6424a I/O expander. Add it to the .dts file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3b99ec25b748..76877516f6df 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -434,6 +434,13 @@
 	pinctrl-0 = <&i2c5_pins>;
 
 	clock-frequency = <400000>;
+
+	gpio9: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &mcbsp3 {
-- 
1.9.1

