From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 19/20] ARM: dts: dm814x: add clkctrl nodes
Date: Thu, 7 Dec 2017 10:46:52 +0200
Message-ID: <1512636413-25243-20-git-send-email-t-kristo@ti.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512636413-25243-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for DM814x SoC. These are going to be acting as
replacement for part of the existing clock data and the existing
clkctrl hooks under hwmod data.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dm814x-clocks.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
index c4671af..f80525a 100644
--- a/arch/arm/boot/dts/dm814x-clocks.dtsi
+++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
@@ -337,3 +337,33 @@
 		clock-frequency = <20000000>;
 	};
 };
+
+&prcm {
+	default_cm: default_cm@500 {
+		compatible = "ti,omap4-cm";
+		reg = <0x500 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x500 0x100>;
+
+		default_clkctrl: clk@0 {
+			compatible = "ti,clkctrl";
+			reg = <0x0 0x5c>;
+			#clock-cells = <2>;
+		};
+	};
+
+	alwon_cm: alwon_cm@1400 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1400 0x300>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1400 0x300>;
+
+		alwon_clkctrl: clk@0 {
+			compatible = "ti,clkctrl";
+			reg = <0x0 0x228>;
+			#clock-cells = <2>;
+		};
+	};
+};
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
