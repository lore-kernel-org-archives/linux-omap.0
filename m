From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: OMAP5: Update CPU OPP table as per final production Manual
Date: Thu, 5 Jun 2014 20:09:46 -0500
Message-ID: <1402016986-12508-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39436 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbaFFBKQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jun 2014 21:10:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

As per the Final production Data Manual for OMAP5432,
SWPS050F(APRIL 2014)

There are only two OPPs - 1GHz and 1.5GHz. the older OPP_LOW has been
completely descoped. The Nominal voltages are still correct though.
However, expectation for final production configuration is operation
with Adaptive Body Bias (ABB) and Adaptive Voltage Scaling Class 0
operation.

There are no IDcode or version change information encoded to
programmatically detect this and software is supposed to NOT use
OPP_LOW(500MHz) anymore for all devices (legacy and production
samples).

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3bfda16..a4ed549 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -45,7 +45,6 @@
 
 			operating-points = <
 				/* kHz    uV */
-				500000  880000
 				1000000 1060000
 				1500000 1250000
 			>;
-- 
1.7.9.5

