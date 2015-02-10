From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: am43xx-clocks: Fix ehrpwm tbclk data on am43xx
Date: Tue, 10 Feb 2015 11:05:42 +0530
Message-ID: <1423546542-29664-3-git-send-email-vigneshr@ti.com>
References: <1423546542-29664-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423546542-29664-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ehrpwm tbclk is wrongly modelled as deriving from dpll_per_m2_ck.
The TRM says tbclk is derived from SYSCLKOUT. SYSCLKOUT nothing but the
functional clock of pwmss (l4ls_gclk).
Fix this by changing source of ehrpwmx_tbclk to l4ls_gclk.

Fixes: 4da1c67719f61 ("add tbclk data for ehrpwm")
Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index c7dc9dab93a4..cfb49686ab6a 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -107,7 +107,7 @@
 	ehrpwm0_tbclk: ehrpwm0_tbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <0>;
 		reg = <0x0664>;
 	};
@@ -115,7 +115,7 @@
 	ehrpwm1_tbclk: ehrpwm1_tbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <1>;
 		reg = <0x0664>;
 	};
@@ -123,7 +123,7 @@
 	ehrpwm2_tbclk: ehrpwm2_tbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <2>;
 		reg = <0x0664>;
 	};
@@ -131,7 +131,7 @@
 	ehrpwm3_tbclk: ehrpwm3_tbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <4>;
 		reg = <0x0664>;
 	};
@@ -139,7 +139,7 @@
 	ehrpwm4_tbclk: ehrpwm4_tbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <5>;
 		reg = <0x0664>;
 	};
@@ -147,7 +147,7 @@
 	ehrpwm5_tbclk: ehrpwm5_tbclk {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
-		clocks = <&dpll_per_m2_ck>;
+		clocks = <&l4ls_gclk>;
 		ti,bit-shift = <6>;
 		reg = <0x0664>;
 	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
