From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 17/17] ARM: dts: Add missing hwmod related properties for dra7
Date: Wed, 30 Aug 2017 08:19:53 -0700
Message-ID: <20170830151953.30856-18-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On dra7 we're missing two "ti,hwmods" properties that the SoC
interconnect code needs. For hdq 1-wire, we need to add the
node for that.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -457,6 +457,7 @@
 			#dma-cells = <1>;
 			dma-channels = <32>;
 			dma-requests = <127>;
+			ti,hwmods = "dma_system";
 		};
 
 		edma: edma@43300000 {
@@ -1069,6 +1070,13 @@
 			max-frequency = <192000000>;
 		};
 
+		hdqw1w: 1w@480b2000 {
+			compatible = "ti,omap3-1w";
+			reg = <0x480b2000 0x1000>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "hdq1w";
+		};
+
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x480b4000 0x400>;
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
