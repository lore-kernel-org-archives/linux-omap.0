From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 01/14] ARM: OMAP: remove DSS DT hack
Date: Wed, 27 Mar 2013 10:45:08 +0200
Message-ID: <1364373921-7599-2-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35579 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727Ab3C0IqR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:46:17 -0400
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

As a temporary solution to enable DSS for selected boards when booting
with DT, a hack was added to board-generic.c in
63d5fc0c2f748e20f38a0a0ec1c8494bddf5c288 (OMAP: board-generic: enable
DSS for panda & sdp boards).

We're now adding proper DT support, so the hack can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |    8 --------
 arch/arm/mach-omap2/dss-common.c    |   24 ------------------------
 arch/arm/mach-omap2/dss-common.h    |    2 --
 3 files changed, 34 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index e54a480..a61544b 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -41,14 +41,6 @@ static void __init omap_generic_init(void)
 
 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 
-	/*
-	 * HACK: call display setup code for selected boards to enable omapdss.
-	 * This will be removed when omapdss supports DT.
-	 */
-	if (of_machine_is_compatible("ti,omap4-panda"))
-		omap4_panda_display_init_of();
-	else if (of_machine_is_compatible("ti,omap4-sdp"))
-		omap_4430sdp_display_init_of();
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index a10c56b..78e409a 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -93,13 +93,6 @@ void __init omap4_panda_display_init(void)
 	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
 
-void __init omap4_panda_display_init_of(void)
-{
-	omap_display_init(&omap4_panda_dss_data);
-	platform_device_register(&omap4_panda_tfp410_device);
-	platform_device_register(&omap4_panda_hdmi_device);
-}
-
 
 /* OMAP4 Blaze display data */
 
@@ -242,20 +235,3 @@ void __init omap_4430sdp_display_init(void)
 	omap_mux_init_gpio(HDMI_GPIO_CT_CP_HPD, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(HDMI_GPIO_HPD, OMAP_PIN_INPUT_PULLDOWN);
 }
-
-void __init omap_4430sdp_display_init_of(void)
-{
-	int r;
-
-	/* Enable LCD2 by default (instead of Pico DLP) */
-	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
-			"display_sel");
-	if (r)
-		pr_err("%s: Could not get display_sel GPIO\n", __func__);
-
-	sdp4430_picodlp_init();
-	omap_display_init(&sdp4430_dss_data);
-	platform_device_register(&sdp4430_hdmi_device);
-	platform_device_register(&sdp4430_lcd1_device);
-	platform_device_register(&sdp4430_lcd2_device);
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
1.7.10.4

