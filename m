From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] ARM: dts: dra7: Set a default parent to mcasp3_ahclkx_mux
Date: Wed, 6 Sep 2017 19:09:32 +0530
Message-ID: <1504705172-17781-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Assign a default parent to mcasp3_ahclkx_mux clock using
the assigned-clock-parents property. This is helpful in
cases like kexec where in the clock parent can be something
other than the value at reset.

Suggested-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index cf229df..e62b628 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1817,6 +1817,8 @@
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
 		ti,bit-shift = <24>;
 		reg = <0x1868>;
+		assigned-clocks = <&mcasp3_ahclkx_mux>;
+		assigned-clock-parents = <&abe_24m_fclk>;
 	};
 
 	mcasp3_aux_gfclk_mux: mcasp3_aux_gfclk_mux@1868 {
-- 
1.9.1
