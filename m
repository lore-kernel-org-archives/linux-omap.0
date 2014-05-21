From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/2] ARM: dts: omap5-clocks.dtsi: add ti,set-rate-parent to dss_dss_clk
Date: Wed, 21 May 2014 15:16:10 +0300
Message-ID: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46817 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbaEUMRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 08:17:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add ti,set-rate-parent to dss_dss_clk so that the DSS driver can
set the rate.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index d487fdab3921..d44bdaa8fe68 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -851,6 +851,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1420>;
+		ti,set-rate-parent;
 	};
 
 	dss_sys_clk: dss_sys_clk {
-- 
1.9.1

