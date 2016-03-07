From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 08/10] ARM: clk: dra7xx: Correct mcasp8_ahclkx_mux name
Date: Mon, 7 Mar 2016 17:17:35 +0200
Message-ID: <1457363857-20797-9-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

rename the mcasp8_ahclk_mux to mcasp8_ahclkx_mux.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
 drivers/clk/ti/clk-7xx.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d0bae06b7eb7..4d614b3c7ec2 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1856,7 +1856,7 @@
 		reg = <0x1908>;
 	};
 
-	mcasp8_ahclk_mux: mcasp8_ahclk_mux {
+	mcasp8_ahclkx_mux: mcasp8_ahclkx_mux {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atl_clkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index a911d7de3377..6b5a309d9939 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -223,7 +223,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK(NULL, "mcasp6_aux_gfclk_mux", "mcasp6_aux_gfclk_mux"),
 	DT_CLK(NULL, "mcasp7_ahclkx_mux", "mcasp7_ahclkx_mux"),
 	DT_CLK(NULL, "mcasp7_aux_gfclk_mux", "mcasp7_aux_gfclk_mux"),
-	DT_CLK(NULL, "mcasp8_ahclk_mux", "mcasp8_ahclk_mux"),
+	DT_CLK(NULL, "mcasp8_ahclkx_mux", "mcasp8_ahclkx_mux"),
 	DT_CLK(NULL, "mcasp8_aux_gfclk_mux", "mcasp8_aux_gfclk_mux"),
 	DT_CLK(NULL, "mmc1_fclk_mux", "mmc1_fclk_mux"),
 	DT_CLK(NULL, "mmc1_fclk_div", "mmc1_fclk_div"),
-- 
2.7.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
