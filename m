From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] ARM: dts: dra7: Correct clock tree for sys_32k_ck
Date: Mon, 14 Mar 2016 17:33:21 +0530
Message-ID: <1457957001-720-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is w.r.t J6/J6eco: 32clk is pseudo (erratum i856) - clock source.
Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz external
crystal is not enabled at power up. Instead the CPU falls back to using
an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is usually
20MHz on boards so far (which gives an emulated frequency of 32.786KHz)

Modelling the same in device tree.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
Errata Document: http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
Errata number: i856

Tested the debugfs clock tree nodes on DRA7-EVM.

Changes in v2:

Added missing Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 357bede..7f1f892 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -98,12 +98,20 @@
 		clock-frequency = <32768>;
 	};
 
-	sys_32k_ck: sys_32k_ck {
+	sys_clk32_crystal_ck: sys_clk32_crystal_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 	};
 
+	sys_clk32_pseudo_ck: sys_clk32_pseudo_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin1>;
+		clock-mult = <1>;
+		clock-div = <610>;
+	};
+
 	virt_12000000_ck: virt_12000000_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -2146,4 +2154,12 @@
 		ti,bit-shift = <0>;
 		reg = <0x558>;
 	};
+
+	sys_32k_ck: sys_32k_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clk32_crystal_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>;
+		ti,bit-shift = <8>;
+		reg = <0x6c4>;
+	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
