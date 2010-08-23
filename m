From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 19/20] Get RFBI baseaddr with platform device
Date: Mon, 23 Aug 2010 21:28:08 +0530
Message-ID: <1282579089-10487-20-git-send-email-svadivu@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38244 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-19-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

RFBI base addr got from platform device.  Hardcoding of
base addr removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/rfbi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index fe4f423..690f7bf 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -36,7 +36,6 @@
 #include <plat/display.h>
 #include "dss.h"
 
-#define RFBI_BASE               0x48050800
 
 struct rfbi_reg { u16 idx; };
 
@@ -961,6 +960,7 @@ int rfbi_init(struct platform_device *pdev)
 {
 	u32 rev;
 	u32 l;
+	struct resource *rfbi_mem;
 
 	spin_lock_init(&rfbi.cmd_lock);
 
@@ -968,7 +968,8 @@ int rfbi_init(struct platform_device *pdev)
 	atomic_set(&rfbi.cmd_fifo_full, 0);
 	atomic_set(&rfbi.cmd_pending, 0);
 
-	rfbi.base = ioremap(RFBI_BASE, SZ_256);
+	rfbi_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rfbi.base = ioremap(rfbi_mem->start, resource_size(rfbi_mem));
 	if (!rfbi.base) {
 		DSSERR("can't ioremap RFBI\n");
 		return -ENOMEM;
-- 
1.6.3.3

