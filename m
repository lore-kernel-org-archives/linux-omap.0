From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/8] ARM: dts: set 'ti,set-rate-parent' for dpll4_m4 path
Date: Thu, 13 Feb 2014 12:04:05 +0200
Message-ID: <1392285846-13199-8-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60621 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbaBMKFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 05:05:03 -0500
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Set 'ti,set-rate-parent' property for clocks in the dpll4_m4 clock
path, which is used for DSS functional clock. This fixes DSS driver's
clock rate configuration, which needs the rate to be propagated properly
to the divider node (dpll4_m4_ck).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3xxx-clocks.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index df3c699a1893..12be2b35dae9 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -429,6 +429,7 @@
 		clocks = <&dpll4_m4_ck>;
 		ti,clock-mult = <2>;
 		ti,clock-div = <1>;
+		ti,set-rate-parent;
 	};
 
 	dpll4_m4x2_ck: dpll4_m4x2_ck {
@@ -438,6 +439,7 @@
 		ti,bit-shift = <0x1d>;
 		reg = <0x0d00>;
 		ti,set-bit-to-disable;
+		ti,set-rate-parent;
 	};
 
 	dpll4_m5_ck: dpll4_m5_ck {
-- 
1.8.3.2

