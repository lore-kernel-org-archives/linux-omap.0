From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 15/20] Use platform device to get DSS base addr
Date: Mon, 23 Aug 2010 21:28:04 +0530
Message-ID: <1282579089-10487-16-git-send-email-svadivu@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37924 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab0HWP6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-15-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSS Base addr got form platform device. Hardcoding of base addr could be removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/dss.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index cbad9ff..21005c6 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -973,8 +973,10 @@ int dss_init(bool skip_init)
 {
 	int r;
 	u32 rev;
+	struct resource *dss_mem;
 
-	dss.base = ioremap(DSS_BASE, DSS_SZ_REGS);
+	dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
+	dss.base = ioremap(dss_mem->start, resource_size(dss_mem));
 	if (!dss.base) {
 		DSSERR("can't ioremap DSS\n");
 		r = -ENOMEM;
-- 
1.6.3.3

