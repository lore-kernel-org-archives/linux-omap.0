From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 17/20] Get VENC base addr from platform device
Date: Mon, 23 Aug 2010 21:28:06 +0530
Message-ID: <1282579089-10487-18-git-send-email-svadivu@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35121 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754204Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-17-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

VENC base addr got from platform device.  Hardcoding
of base addr removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/venc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 576f0df..e618b09 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -39,7 +39,6 @@
 
 #include "dss.h"
 
-#define VENC_BASE	0x48050C00
 
 /* Venc registers */
 #define VENC_REV_ID				0x00
@@ -659,13 +658,15 @@ struct regulator *dss_get_vdda_dac(void)
 int venc_init(struct platform_device *pdev)
 {
 	u8 rev_id;
+	struct resource *venc_mem;
 
 	mutex_init(&venc.venc_lock);
 
 	venc.pdev = pdev;
 	venc.wss_data = 0;
 
-	venc.base = ioremap(VENC_BASE, SZ_1K);
+	venc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	venc.base = ioremap(venc_mem->start, resource_size(venc_mem));
 	if (!venc.base) {
 		DSSERR("can't ioremap VENC\n");
 		return -ENOMEM;
-- 
1.6.3.3

