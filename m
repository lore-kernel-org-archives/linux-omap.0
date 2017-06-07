From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 6/6] ARM: dts: dra7xx-clocks: Use DPLL_GPU for GPU clocks
Date: Wed, 7 Jun 2017 16:27:30 -0500
Message-ID: <20170607212730.33002-7-s-anna@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170607212730.33002-1-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Subhajit Paul <subhajit_paul-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Subhajit Paul <subhajit_paul-l0cyMroinI0@public.gmane.org>

The GPU has two functional clocks - GPU_CORE_GCLK and GPU_HYD_GCLK.
Both of these are mux clocks and are derived from the DPLL_CORE
H14 output clock CORE_GPU_CLK by default. These clocks can also be
be derived from DPLL_PER or DPLL_GPU.

The GPU DPLL provides the output clocks primarily for the GPU.
Configuring the GPU for different OPP clock frequencies is easier
to achieve when using the DPLL_GPU rather than the other two DPLLs
due to:
1. minimal affect on any other output clocks from these DPLLs
2. may require an impossible post-divider values on existing DPLLs
   without affecting other clocks.

So, switch the GPU functional clocks to be sourced from GPU DPLL by
default. This is done using the DT standard properties "assigned-clocks"
and "assigned-clock-parents". Newer u-boots (from 2017.01 onwards) reuse
and can update these properties to choose an appropriate one-time fixed
OPP configuration as all the required ABB/AVS setup is performed within
the bootloader. Note that there is no DVFS supported for any of the
non-MPU domains. The DPLL will automatically transition into a low-power
stop mode when the associated output clocks are not utilized or gated
automatically.

This patch also sets the initial values for the DPLL_GPU outputs.
These values are chosen based on the OPP_NOM values defined as per
recommendation from design team. The DPLL locked frequency is kept
at 1277 MHz, so that the value for the divider clock, dpll_gpu_m2_ck,
can be set to 425.67 MHz for OPP_NOM.

Signed-off-by: Subhajit Paul <subhajit_paul-l0cyMroinI0@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: revise patch description]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 76e2b7478141..cf229dfabf61 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -414,6 +414,8 @@
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_gpu_byp_mux>;
 		reg = <0x02d8>, <0x02dc>, <0x02e4>, <0x02e0>;
+		assigned-clocks = <&dpll_gpu_ck>;
+		assigned-clock-rates = <1277000000>;
 	};
 
 	dpll_gpu_m2_ck: dpll_gpu_m2_ck@2e8 {
@@ -425,6 +427,8 @@
 		reg = <0x02e8>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		assigned-clocks = <&dpll_gpu_m2_ck>;
+		assigned-clock-rates = <425666667>;
 	};
 
 	dpll_core_m2_ck: dpll_core_m2_ck@130 {
@@ -1760,6 +1764,8 @@
 		clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>, <&dpll_gpu_m2_ck>;
 		ti,bit-shift = <24>;
 		reg = <0x1220>;
+		assigned-clocks = <&gpu_core_gclk_mux>;
+		assigned-clock-parents = <&dpll_gpu_m2_ck>;
 	};
 
 	gpu_hyd_gclk_mux: gpu_hyd_gclk_mux@1220 {
@@ -1768,6 +1774,8 @@
 		clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>, <&dpll_gpu_m2_ck>;
 		ti,bit-shift = <26>;
 		reg = <0x1220>;
+		assigned-clocks = <&gpu_hyd_gclk_mux>;
+		assigned-clock-parents = <&dpll_gpu_m2_ck>;
 	};
 
 	l3instr_ts_gclk_div: l3instr_ts_gclk_div@e50 {
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
