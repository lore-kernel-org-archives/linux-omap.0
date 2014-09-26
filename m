From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: dts: dra7-evm: Fix interrupt line of pcf@i2c1:0x21
Date: Fri, 26 Sep 2014 16:02:36 +0300
Message-ID: <1411736556-4538-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58778 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbaIZNCl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2014 09:02:41 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s8QD2eLv000923
	for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2014 08:02:40 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s8QD2ech023677
	for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2014 08:02:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nsekhar@ti.com
Cc: george.cherian@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The interrupt line of pcf I/O expander chip @i2c1:0x21
is tied to gpio6_11 and not gpio6_14. Fix that.

Without this USB_ID detection will not work and I2C3 bus activity
will cause spurious interrupts for the I/O expander chip.

Fixes: 87991e7b4dd4 (ARM: dts: dra7-evm: Add extcon nodes for USB)

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 8ddd012..53b6fba 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -606,7 +606,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
-- 
1.8.3.2

