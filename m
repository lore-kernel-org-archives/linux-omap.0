From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/2] ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
Date: Mon, 21 Apr 2014 12:41:46 +0200
Message-ID: <1398076907-2901-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38058 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaDUKln (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 06:41:43 -0400
In-Reply-To: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

We need to use set-rate-parent for dpll4_m5 clock path, so use the
ti,fixed-factor-clock version which supports set-rate-parent property.

The set-rate-parent flag itself is set in the following patch, this one
just changes the clock driver to ti,fixed-factor-clock without any other
changes.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap36xx-clocks.dtsi
index 6b5280d..200ae3a 100644
--- a/arch/arm/boot/dts/omap36xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-clocks.dtsi
@@ -83,7 +83,7 @@
 };
 
 &dpll4_m5x2_mul_ck {
-	clock-mult = <1>;
+	ti,clock-mult = <1>;
 };
 
 &dpll4_m6x2_mul_ck {
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index 12be2b3..351f58b 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -453,10 +453,10 @@
 
 	dpll4_m5x2_mul_ck: dpll4_m5x2_mul_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-factor-clock";
+		compatible = "ti,fixed-factor-clock";
 		clocks = <&dpll4_m5_ck>;
-		clock-mult = <2>;
-		clock-div = <1>;
+		ti,clock-mult = <2>;
+		ti,clock-div = <1>;
 	};
 
 	dpll4_m5x2_ck: dpll4_m5x2_ck {
-- 
1.8.3.2

