From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 08/20] ARM: dts: omap5: add bus functionality to base PRCM nodes
Date: Thu, 7 Dec 2017 10:46:41 +0200
Message-ID: <1512636413-25243-9-git-send-email-t-kristo@ti.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512636413-25243-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add simple-bus compatibility and ranges properties to cm_core_aon, cm_core
and prm nodes. This is done in preparation of adding the support for
clkctrl nodes.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 404c78f..b0992b8 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -201,8 +201,12 @@
 			};
 
 			cm_core_aon: cm_core_aon@4000 {
-				compatible = "ti,omap5-cm-core-aon";
+				compatible = "ti,omap5-cm-core-aon",
+					     "simple-bus";
 				reg = <0x4000 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x4000 0x2000>;
 
 				cm_core_aon_clocks: clocks {
 					#address-cells = <1>;
@@ -214,8 +218,11 @@
 			};
 
 			cm_core: cm_core@8000 {
-				compatible = "ti,omap5-cm-core";
+				compatible = "ti,omap5-cm-core", "simple-bus";
 				reg = <0x8000 0x3000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x8000 0x3000>;
 
 				cm_core_clocks: clocks {
 					#address-cells = <1>;
@@ -240,9 +247,12 @@
 			};
 
 			prm: prm@6000 {
-				compatible = "ti,omap5-prm";
+				compatible = "ti,omap5-prm", "simple-bus";
 				reg = <0x6000 0x3000>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x6000 0x3000>;
 
 				prm_clocks: clocks {
 					#address-cells = <1>;
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
