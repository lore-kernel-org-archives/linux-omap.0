From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/23] ARM: dts: omap5-clocks.dtsi: add ti,set-rate-parent to dss_dss_clk
Date: Thu, 24 Apr 2014 13:17:05 +0300
Message-ID: <1398334639-14172-10-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59022 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755017AbaDXKTJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:09 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

Add ti,set-rate-parent to dss_dss_clk so that the DSS driver can
set the rate.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 26c02f9e92c4..b53ca885c021 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -859,6 +859,7 @@
 		clocks = <&dpll_per_h12x2_ck>;
 		ti,bit-shift = <8>;
 		reg = <0x1420>;
+		ti,set-rate-parent;
 	};
 
 	dss_sys_clk: dss_sys_clk {
-- 
1.9.1

