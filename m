From: "J.D. Schroeder" <Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/3] ARM: dts: dra7: fix clock node definition to avoid build warning
Date: Mon, 2 May 2016 12:12:03 -0500
Message-ID: <1462209123-7332-4-git-send-email-Linux.HWI@garmin.com>
References: <20160427171658.GA5995@atomide.com>
 <1462209123-7332-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462209123-7332-1-git-send-email-Linux.HWI-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: "J.D. Schroeder" <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>

This patch fixes the following warning for the DRA7 clock node:
Warning (unit_address_vs_reg): Node
/ocp/l4@4a000000/scm@2000/scm_conf@0/clocks/sys_32k_ck
has a reg or ranges property, but no unit name

Signed-off-by: J.D. Schroeder <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index f7ec976..34cda4b 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2186,7 +2186,7 @@
 		reg = <0x0558>;
 	};
 
-	sys_32k_ck: sys_32k_ck {
+	sys_32k_ck: sys_32k_ck@6c4 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_clk32_crystal_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
