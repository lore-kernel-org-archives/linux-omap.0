From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC PATCH 2/2] staging: tidspbridge: detect wdt3 feature at runtime
Date: Tue, 14 Feb 2012 21:00:34 -0600
Message-ID: <1329274834-30154-3-git-send-email-omar.ramirez@ti.com>
References: <1329274834-30154-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:43753 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757650Ab2BODAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 22:00:54 -0500
Received: by mail-tul01m020-f178.google.com with SMTP id wc7so1038940obb.23
        for <linux-omap@vger.kernel.org>; Tue, 14 Feb 2012 19:00:53 -0800 (PST)
In-Reply-To: <1329274834-30154-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, devel@driverdev.osuosl.org, Jiri Kosina <jkosina@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, Greg KH <gregkh@linuxfoundation.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

In order to detect WDT feature on the dsp code, we need to
find the symbol used to enable it inside the baseimage.

This should fix the warning comming from L3 driver:

    WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:161 omap3_l3_app_irq...
    In-band Error seen by IVA_SS  at address 0
    ...

That occurs because the dsp tries to access wdt3 registers when the clock
for those registers is not enabled.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 670de0a..7862513 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -383,6 +383,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	u32 clk_cmd;
 	struct io_mgr *hio_mgr;
 	u32 ul_load_monitor_timer;
+	u32 wdt_en = 0;
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
 
@@ -594,9 +595,12 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 		if (!wait_for_start(dev_context, dw_sync_addr))
 			status = -ETIMEDOUT;
 
-		/* Start wdt */
-		dsp_wdt_sm_set((void *)ul_shm_base);
-		dsp_wdt_enable(true);
+		dev_get_symbol(dev_context->dev_obj, "_WDT_enable", &wdt_en);
+		if (wdt_en) {
+			/* Start wdt */
+			dsp_wdt_sm_set((void *)ul_shm_base);
+			dsp_wdt_enable(true);
+		}
 
 		status = dev_get_io_mgr(dev_context->dev_obj, &hio_mgr);
 		if (hio_mgr) {
-- 
1.7.4.1

