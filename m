From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 15/17] ARM: dts: Add missing dma hwmod property for omap5
Date: Wed, 30 Aug 2017 08:19:51 -0700
Message-ID: <20170830151953.30856-16-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap5 we're missing the dma "ti,hwmods" property that the
SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -295,6 +295,7 @@
 			#dma-cells = <1>;
 			dma-channels = <32>;
 			dma-requests = <127>;
+			ti,hwmods = "dma_system";
 		};
 
 		gpio1: gpio@4ae10000 {
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
