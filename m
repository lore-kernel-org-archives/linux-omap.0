From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/6] usb: gadget: omap_udc: remove useless print
Date: Tue, 29 May 2012 15:15:57 +0300
Message-ID: <1338293761-9457-3-git-send-email-balbi@ti.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:44812 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753491Ab2E2MRw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 08:17:52 -0400
Received: by lbok6 with SMTP id k6so3387313lbo.18
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 05:17:49 -0700 (PDT)
In-Reply-To: <1338293761-9457-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

that print isn't needed at all. Remove it
and move the use_dma reinitialization to
probe() function.

Note that ideally we would drop all
cpu_is_* and machine_is_* checks from
this driver instead. Later patches will
come to get rid of those.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/omap_udc.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index aa2d174..5e7b891 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2800,6 +2800,9 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 	struct clk		*dc_clk = NULL;
 	struct clk		*hhc_clk = NULL;
 
+	if (cpu_is_omap7xx())
+		use_dma = 0;
+
 	/* NOTE:  "knows" the order of the resources! */
 	if (!request_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1,
@@ -3096,16 +3099,6 @@ static struct platform_driver udc_driver = {
 
 static int __init udc_init(void)
 {
-	/* Disable DMA for omap7xx -- it doesn't work right. */
-	if (cpu_is_omap7xx())
-		use_dma = 0;
-
-	INFO("%s, version: " DRIVER_VERSION
-#ifdef	USE_ISO
-		" (iso)"
-#endif
-		"%s\n", driver_desc,
-		use_dma ?  " (dma)" : "");
 	return platform_driver_probe(&udc_driver, omap_udc_probe);
 }
 module_init(udc_init);
-- 
1.7.10.2

