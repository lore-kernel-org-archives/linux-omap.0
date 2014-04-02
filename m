From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] ARM: DTS: dra7/dra7xx-clocks: ATL related changes
Date: Wed, 2 Apr 2014 16:55:07 +0300
Message-ID: <1396446907-20383-4-git-send-email-peter.ujfalusi@ti.com>
References: <1396446907-20383-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396446907-20383-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Modify the clock nodes for the ATL clocks to use the ATL clock driver to
handle them.

Add the ATL device node at the same time for DRA7.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi          | 11 +++++++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 16 ++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1c0f8e1893ae..5e360e939aa7 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -789,6 +789,17 @@
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
+
+		atl: atl@4843c000 {
+			compatible = "ti,dra7-atl";
+			reg = <0x4843c000 0x3ff>;
+			ti,hwmods = "atl";
+			ti,provided-clocks = <&atl_clkin0_ck>, <&atl_clkin1_ck>,
+					     <&atl_clkin2_ck>, <&atl_clkin3_ck>;
+			clocks = <&atl_gfclk_mux>;
+			clock-names = "fck";
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 30160348934c..789e92cd5595 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -10,26 +10,26 @@
 &cm_core_aon_clocks {
 	atl_clkin0_ck: atl_clkin0_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	atl_clkin1_ck: atl_clkin1_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	atl_clkin2_ck: atl_clkin2_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	atl_clkin3_ck: atl_clkin3_ck {
 		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
+		compatible = "ti,dra7-atl-clock";
+		clocks = <&atl_gfclk_mux>;
 	};
 
 	hdmi_clkin_ck: hdmi_clkin_ck {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
