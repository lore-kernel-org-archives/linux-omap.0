From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 16/20] Get DISPC base addr with platform device
Date: Mon, 23 Aug 2010 21:28:05 +0530
Message-ID: <1282579089-10487-17-git-send-email-svadivu@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38247 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-16-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DISPC Base addr got from the platform device.  Hadrcoding of base
addr removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ae18b5f..8a7a086 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -40,7 +40,6 @@
 #include "dss.h"
 
 /* DISPC */
-#define DISPC_BASE			0x48050400
 
 #define DISPC_SZ_REGS			SZ_1K
 
@@ -3094,6 +3093,7 @@ static void _omap_dispc_initial_config(void)
 int dispc_init(struct platform_device *pdev)
 {
 	u32 rev;
+	struct resource *dispc_mem;
 
 	spin_lock_init(&dispc.irq_lock);
 
@@ -3104,7 +3104,8 @@ int dispc_init(struct platform_device *pdev)
 
 	INIT_WORK(&dispc.error_work, dispc_error_worker);
 
-	dispc.base = ioremap(DISPC_BASE, DISPC_SZ_REGS);
+	dispc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dispc.base = ioremap(dispc_mem->start, resource_size(dispc_mem));
 	if (!dispc.base) {
 		DSSERR("can't ioremap DISPC\n");
 		return -ENOMEM;
-- 
1.6.3.3

