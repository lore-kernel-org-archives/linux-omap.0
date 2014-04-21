From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 2/2] ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path
Date: Mon, 21 Apr 2014 12:41:47 +0200
Message-ID: <1398076907-2901-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38059 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaDUKlo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 06:41:44 -0400
In-Reply-To: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Set 'ti,set-rate-parent' property for the dpll4_m5x2_mul_ck clock, which
is used for the ISP functional clock. This fixes the OMAP3 ISP driver's
clock rate configuration, which needs the rate to be propagated properly
to the divider node (dpll4_m5_ck).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/omap3xxx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index 351f58b..e47ff69 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -457,6 +457,7 @@
 		clocks = <&dpll4_m5_ck>;
 		ti,clock-mult = <2>;
 		ti,clock-div = <1>;
+		ti,set-rate-parent;
 	};
 
 	dpll4_m5x2_ck: dpll4_m5x2_ck {
-- 
1.8.3.2

