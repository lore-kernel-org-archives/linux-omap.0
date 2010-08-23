From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 20/20] Get DSS IRQ with platform device
Date: Mon, 23 Aug 2010 21:28:09 +0530
Message-ID: <1282579089-10487-21-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
 <1282579089-10487-8-git-send-email-svadivu@ti.com>
 <1282579089-10487-9-git-send-email-svadivu@ti.com>
 <1282579089-10487-10-git-send-email-svadivu@ti.com>
 <1282579089-10487-11-git-send-email-svadivu@ti.com>
 <1282579089-10487-12-git-send-email-svadivu@ti.com>
 <1282579089-10487-13-git-send-email-svadivu@ti.com>
 <1282579089-10487-14-git-send-email-svadivu@ti.com>
 <1282579089-10487-15-git-send-email-svadivu@ti.com>
 <1282579089-10487-16-git-send-email-svadivu@ti.com>
 <1282579089-10487-17-git-send-email-svadivu@ti.com>
 <1282579089-10487-18-git-send-email-svadivu@ti.com>
 <1282579089-10487-19-git-send-email-svadivu@ti.com>
 <1282579089-10487-20-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55697 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab0HWP6Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:24 -0400
In-Reply-To: <1282579089-10487-20-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSS IRQ got from platform device.  Hardcoding of baseaddr,
IRQ removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/dss.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 21005c6..a22ba65 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -34,7 +34,6 @@
 #include <plat/clock.h>
 #include "dss.h"
 
-#define DSS_BASE			0x48050000
 
 #define DSS_SZ_REGS			SZ_512
 
@@ -971,7 +970,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 
 int dss_init(bool skip_init)
 {
-	int r;
+	int r, dss_irq;
 	u32 rev;
 	struct resource *dss_mem;
 
@@ -1012,15 +1011,18 @@ int dss_init(bool skip_init)
 	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
 #endif
 
-	r = request_irq(INT_24XX_DSS_IRQ,
+	dss_irq = platform_get_irq(dss.pdev, 0);
+	if (dss_irq) {
+		r = request_irq(dss_irq,
 			cpu_is_omap24xx()
 			? dss_irq_handler_omap2
 			: dss_irq_handler_omap3,
 			0, "OMAP DSS", NULL);
 
-	if (r < 0) {
-		DSSERR("omap2 dss: request_irq failed\n");
-		goto fail1;
+		if (r < 0) {
+			DSSERR("omap2 dss: request_irq failed\n");
+			goto fail1;
+		}
 	}
 
 	if (cpu_is_omap34xx()) {
-- 
1.6.3.3

