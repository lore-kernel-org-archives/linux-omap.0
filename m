From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] ARM: dts: am43xx-clocks.dtsi: add ti,set-rate-parent to display clock path
Date: Wed, 21 May 2014 15:16:11 +0300
Message-ID: <1400674571-633-2-git-send-email-tomi.valkeinen@ti.com>
References: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48815 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518AbaEUMQ6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 08:16:58 -0400
In-Reply-To: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

We need set-rate-parent flags for the display's clock path so that the
DSS driver can change the clock rate of the PLL.

This patchs adds the ti,set-rate-parent flag to disp_clk and
dpll_disp_m2_ck clock nodes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 142009cc9332..a6f7ee74990f 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -229,6 +229,7 @@
 		reg = <0x2e30>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		ti,set-rate-parent;
 	};
 
 	dpll_per_ck: dpll_per_ck {
@@ -511,6 +512,7 @@
 		compatible = "ti,mux-clock";
 		clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
 		reg = <0x4244>;
+		ti,set-rate-parent;
 	};
 
 	dpll_extdev_ck: dpll_extdev_ck {
-- 
1.9.1

