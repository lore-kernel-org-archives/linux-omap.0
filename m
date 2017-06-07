From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/6] ARM: dts: dra7xx-clocks: Source IPU1 functional clock from CORE DPLL
Date: Wed, 7 Jun 2017 16:27:27 -0500
Message-ID: <20170607212730.33002-4-s-anna@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170607212730.33002-1-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Subhajit Paul <subhajit_paul-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The IPU1 functional clock is actually the output of a mux clock,
ipu1_gfclk_mux. The mux clock is sourced by default from the
DPLL_ABE_X2_CLK, and this results in a rather odd clock frequency
(361 MHz) for the IPU1 functional clock on platforms where ABE_DPLL
is configured properly. Reconfigure the mux clock to be sourced from
CORE_IPU_ISS_BOOST_CLK (dpll_core_h22x2_ck), so that both the IPU1
and IPU2 are running from the same clock and clocked at the same
nominal frequency of 425 MHz.

This also ensures that IPU1 functional clock is always configured
properly and becomes independent of the state of the ABE DPLL on
all boards.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 3330738e4c6e..cfaf27215901 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -791,6 +791,8 @@
 		clocks = <&dpll_abe_m2x2_ck>, <&dpll_core_h22x2_ck>;
 		ti,bit-shift = <24>;
 		reg = <0x0520>;
+		assigned-clocks = <&ipu1_gfclk_mux>;
+		assigned-clock-parents = <&dpll_core_h22x2_ck>;
 	};
 
 	mcasp1_ahclkr_mux: mcasp1_ahclkr_mux@550 {
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
