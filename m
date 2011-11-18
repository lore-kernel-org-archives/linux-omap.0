From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] staging: tidspbridge: request dmtimer clocks on init
Date: Fri, 18 Nov 2011 16:18:54 -0600
Message-ID: <1321654734-11882-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:37560 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753517Ab1KRWSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 17:18:45 -0500
Received: by ghrr13 with SMTP id r13so1675857ghr.39
        for <linux-omap@vger.kernel.org>; Fri, 18 Nov 2011 14:18:43 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

Given that dm timer framework doesn't support request of clocks
by soft | hard irqs because some recent changes, tidspbridge needs
to request its clocks on init and enable/disable them on demand.

This was first seen on 3.2-rc1.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/dsp-clock.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/dsp-clock.c b/drivers/staging/tidspbridge/core/dsp-clock.c
index 3d1279c..7eb5617 100644
--- a/drivers/staging/tidspbridge/core/dsp-clock.c
+++ b/drivers/staging/tidspbridge/core/dsp-clock.c
@@ -54,6 +54,7 @@
 
 /* Bridge GPT id (1 - 4), DM Timer id (5 - 8) */
 #define DMT_ID(id) ((id) + 4)
+#define DM_TIMER_CLOCKS		4
 
 /* Bridge MCBSP id (6 - 10), OMAP Mcbsp id (0 - 4) */
 #define MCBSP_ID(id) ((id) - 6)
@@ -114,8 +115,13 @@ static s8 get_clk_type(u8 id)
  */
 void dsp_clk_exit(void)
 {
+	int i;
+
 	dsp_clock_disable_all(dsp_clocks);
 
+	for (i = 0; i < DM_TIMER_CLOCKS; i++)
+		omap_dm_timer_free(timer[i]);
+
 	clk_put(iva2_clk);
 	clk_put(ssi.sst_fck);
 	clk_put(ssi.ssr_fck);
@@ -130,9 +136,13 @@ void dsp_clk_exit(void)
 void dsp_clk_init(void)
 {
 	static struct platform_device dspbridge_device;
+	int i, id;
 
 	dspbridge_device.dev.bus = &platform_bus_type;
 
+	for (i = 0, id = 5; i < DM_TIMER_CLOCKS; i++, id++)
+		timer[i] = omap_dm_timer_request_specific(id);
+
 	iva2_clk = clk_get(&dspbridge_device.dev, "iva2_ck");
 	if (IS_ERR(iva2_clk))
 		dev_err(bridge, "failed to get iva2 clock %p\n", iva2_clk);
@@ -204,8 +214,7 @@ int dsp_clk_enable(enum dsp_clk_id clk_id)
 		clk_enable(iva2_clk);
 		break;
 	case GPT_CLK:
-		timer[clk_id - 1] =
-				omap_dm_timer_request_specific(DMT_ID(clk_id));
+		status = omap_dm_timer_start(timer[clk_id - 1]);
 		break;
 #ifdef CONFIG_OMAP_MCBSP
 	case MCBSP_CLK:
@@ -281,7 +290,7 @@ int dsp_clk_disable(enum dsp_clk_id clk_id)
 		clk_disable(iva2_clk);
 		break;
 	case GPT_CLK:
-		omap_dm_timer_free(timer[clk_id - 1]);
+		status = omap_dm_timer_stop(timer[clk_id - 1]);
 		break;
 #ifdef CONFIG_OMAP_MCBSP
 	case MCBSP_CLK:
-- 
1.7.0.4

