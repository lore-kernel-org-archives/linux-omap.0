From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ARM: dts: Remove twl6030 clk32g "regulator"
Date: Tue, 12 Aug 2014 18:49:20 +0100
Message-ID: <1407865760-15448-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60242 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbaHLRtc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2014 13:49:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

The kernel has never supported clk32g as a regulator since it is a clock
and not a regulator. Fortunately nothing actually references this node so
we can just remove it.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm/boot/dts/twl6030.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd3172b23..55eb35f068fb 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -83,10 +83,6 @@
 		regulator-always-on;
 	};
 
-	clk32kg: regulator-clk32kg {
-		compatible = "ti,twl6030-clk32kg";
-	};
-
 	twl_usb_comparator: usb-comparator {
 		compatible = "ti,twl6030-usb";
 		interrupts = <4>, <10>;
-- 
2.0.1

