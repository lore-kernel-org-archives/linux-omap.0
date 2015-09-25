From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: <omap2/omap4/omap5/dra7>>: fix address
 translation for pbias
Date: Thu, 24 Sep 2015 18:10:17 -0700
Message-ID: <20150925011017.GO23801@atomide.com>
References: <1441368504-21304-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441368504-21304-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: t-kristo-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [150904 05:12]:
> "ARM: dts: <omap2/omap4/omap5/dra7>: add minimal l4 bus
> layout with control module support" moved pbias_regulator dt node
> from being a child node of ocp to be the child node of
> 'syscon'. Since 'syscon' doesn't have the 'ranges' property,
> address translation fails while trying to convert the address
> to resource. Fix it here by populating 'ranges' property in
> syscon dt node.

I'm applying the following version of this with omap3 device
tree booting fixed for MMC.

Regards,

Tony

8<-----------------------From 9a5e3f27d1b8ca349b79e8b5fe1874eeeedb6f45 Mon Sep 17 00:00:00 2001
From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Date: Fri, 4 Sep 2015 17:38:24 +0530
Subject: [PATCH] ARM: dts: fix omap2+ address translation for pbias

"ARM: dts: <omap2/omap4/omap5/dra7>: add minimal l4 bus
layout with control module support" moved pbias_regulator dt node
from being a child node of ocp to be the child node of
'syscon'. Since 'syscon' doesn't have the 'ranges' property,
address translation fails while trying to convert the address
to resource. Fix it here by populating 'ranges' property in
syscon dt node.

Fixes: 72b10ac00eb1 ("ARM: dts: omap24xx: add minimal l4 bus
layout with control module support")

Fixes: 7415b0b4c645 ("ARM: dts: omap4: add minimal l4 bus layout
with control module support")

Fixes: ed8509edddeb ("ARM: dts: omap5: add minimal l4 bus
layout with control module support")

Fixes: d919501feffa ("ARM: dts: dra7: add minimal l4 bus
layout with control module support")

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
[tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org: fixed omap3 pbias to work]
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -120,6 +120,7 @@
 					reg = <0x0 0x1400>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x0 0x1400>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-dra7", "ti,pbias-omap";
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -56,6 +56,7 @@
 					reg = <0x270 0x240>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x270 0x240>;
 
 					scm_clocks: clocks {
 						#address-cells = <1>;
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -113,10 +113,22 @@
 				};
 
 				scm_conf: scm_conf@270 {
-					compatible = "syscon";
+					compatible = "syscon", "simple-bus";
 					reg = <0x270 0x330>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x270 0x330>;
+
+					pbias_regulator: pbias_regulator {
+						compatible = "ti,pbias-omap3", "ti,pbias-omap";
+						reg = <0x2b0 0x4>;
+						syscon = <&scm_conf>;
+						pbias_mmc_reg: pbias_mmc_omap2430 {
+							regulator-name = "pbias_mmc_omap2430";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <3000000>;
+						};
+					};
 
 					scm_clocks: clocks {
 						#address-cells = <1>;
@@ -202,17 +214,6 @@
 			dma-requests = <96>;
 		};
 
-		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap3", "ti,pbias-omap";
-			reg = <0x2b0 0x4>;
-			syscon = <&scm_conf>;
-			pbias_mmc_reg: pbias_mmc_omap2430 {
-				regulator-name = "pbias_mmc_omap2430";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-			};
-		};
-
 		gpio1: gpio@48310000 {
 			compatible = "ti,omap3-gpio";
 			reg = <0x48310000 0x200>;
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -196,6 +196,7 @@
 					reg = <0x5a0 0x170>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x5a0 0x170>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-omap4", "ti,pbias-omap";
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -185,6 +185,7 @@
 					reg = <0x5a0 0xec>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x5a0 0xec>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-omap5", "ti,pbias-omap";
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
