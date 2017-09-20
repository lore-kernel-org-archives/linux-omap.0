From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: Configure earlycon for omap5-common
Date: Wed, 20 Sep 2017 07:43:24 -0700
Message-ID: <20170920144324.1978-3-tony@atomide.com>
References: <20170920144324.1978-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170920144324.1978-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With commit 8dd6666f4937 ("ARM: OMAP2+: omap_hwmod: Add support for
earlycon") we can now get debug information early if something goes
wrong as long as kernel command line has earlycon in it. Let's enable
it for omap5-common as all these have debug uart at uart3.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -14,6 +14,10 @@
 		display0 = &hdmi0;
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	vmain: fixedregulator-vmain {
 		compatible = "regulator-fixed";
 		regulator-name = "vmain";
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
