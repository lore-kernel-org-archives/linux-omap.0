From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: DTS: dra7xx-clocks: Correct mcasp2_ahclkx_mux bit-shift
Date: Wed, 2 Apr 2014 16:46:25 +0300
Message-ID: <1396446385-20258-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42384 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758746AbaDBNq6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Apr 2014 09:46:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

The correct bit is 24 for AHCLKX.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index e96da9a898ad..cfb8fc753f50 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1640,7 +1640,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
-		ti,bit-shift = <28>;
+		ti,bit-shift = <24>;
 		reg = <0x1860>;
 	};
 
-- 
1.9.1

