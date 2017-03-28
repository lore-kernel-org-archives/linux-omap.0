From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-droid4: Stop disabling SRAM and GPMC
Date: Mon, 27 Mar 2017 17:46:12 -0700
Message-ID: <20170328004612.16350-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

I disabled SRAM and GPMC originally when seeing errors with
omap_barriers_init(). But that is no longer happening probably
because the memory range is now properly configured to 1021 MB
instead of 1024 MB. So let's enable SRAM and GPMC so we get
omap_barriers_init() working and can idle the GPMC.

Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -24,8 +24,7 @@
 
 	/*
 	 * We seem to have only 1021 MB accessible, 1021 - 1022 is locked,
-	 * then 1023 - 1024 seems to contain mbm. For SRAM, see the notes
-	 * below about SRAM and L3_ICLK2 being unused by default,
+	 * then 1023 - 1024 seems to contain mbm.
 	 */
 	memory {
 		device_type = "memory";
@@ -176,11 +175,6 @@
 	};
 };
 
-/* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
-&gpmc {
-	status = "disabled";
-};
-
 &hdmi {
 	status = "okay";
 	pinctrl-0 = <&dss_hdmi_pins>;
@@ -356,11 +350,6 @@
 	};
 };
 
-/* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
-&ocmcram {
-	status = "disabled";
-};
-
 &omap4_pmx_core {
 
 	/* hdmi_hpd.gpio_63 */
-- 
2.12.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
