From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 01/22] ARM: OMAP: remove DSS DT hack
Date: Fri, 9 Aug 2013 11:38:46 +0300
Message-ID: <1376037547-10859-2-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51313 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030596Ab3HIIj1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:39:27 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

As a temporary solution to enable DSS for selected boards when booting
with DT, a hack was added to board-generic.c in
63d5fc0c2f748e20f38a0a0ec1c8494bddf5c288 (OMAP: board-generic: enable
DSS for panda & sdp boards).

We're now adding proper DT support, so the hack can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 11 +----------
 arch/arm/mach-omap2/dss-common.c    | 23 -----------------------
 arch/arm/mach-omap2/dss-common.h    |  2 --
 3 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index be5d005..d388d33 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -57,17 +57,8 @@ static void __init omap_generic_init(void)
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 
-	/*
-	 * HACK: call display setup code for selected boards to enable omapdss.
-	 * This will be removed when omapdss supports DT.
-	 */
-	if (of_machine_is_compatible("ti,omap4-panda")) {
-		omap4_panda_display_init_of();
+	if (of_machine_is_compatible("ti,omap4-panda"))
 		legacy_init_ehci_clk("auxclk3_ck");
-
-	}
-	else if (of_machine_is_compatible("ti,omap4-sdp"))
-		omap_4430sdp_display_init_of();
 	else if (of_machine_is_compatible("ti,omap5-uevm"))
 		legacy_init_ehci_clk("auxclk1_ck");
 }
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 043e570..f3282ac 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -98,12 +98,6 @@ void __init omap4_panda_display_init(void)
 	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
 
-void __init omap4_panda_display_init_of(void)
-{
-	omap_display_init(&omap4_panda_dss_data);
-}
-
-
 /* OMAP4 Blaze display data */
 
 #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
@@ -232,20 +226,3 @@ void __init omap_4430sdp_display_init(void)
 	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
-
-void __init omap_4430sdp_display_init_of(void)
-{
-	int r;
-
-	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
-			"display_sel");
-	if (r)
-		pr_err("%s: Could not get display_sel GPIO\n", __func__);
-
-	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
-		"DLP POWER ON");
-	if (r)
-		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
-
-	omap_display_init(&sdp4430_dss_data);
-}
diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
index 915f6ff..611b341 100644
--- a/arch/arm/mach-omap2/dss-common.h
+++ b/arch/arm/mach-omap2/dss-common.h
@@ -7,8 +7,6 @@
  */
 
 void __init omap4_panda_display_init(void);
-void __init omap4_panda_display_init_of(void);
 void __init omap_4430sdp_display_init(void);
-void __init omap_4430sdp_display_init_of(void);
 
 #endif
-- 
1.8.1.2

