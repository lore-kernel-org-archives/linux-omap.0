From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/13] OMAP: omap_device: ensure hwmod tracks attached omap_device pointer
Date: Wed, 23 Jun 2010 16:42:39 -0700
Message-ID: <1277336563-24988-10-git-send-email-khilman@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54392 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0FWXnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:43:04 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so111388pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:43:03 -0700 (PDT)
In-Reply-To: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

The omap_hwmod struct has a field to track the omap_device that is
attached to it, but it was not being assigned.  Fix by assigning omap_device
pointer when omap_device is built.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/omap_device.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index f899603..6614cba 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -359,8 +359,8 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	struct omap_device *od;
 	char *pdev_name2;
 	struct resource *res = NULL;
-	int res_count;
-	struct omap_hwmod **hwmods;
+	int i, res_count;
+	struct omap_hwmod *oh, **hwmods;
 
 	if (!ohs || oh_cnt == 0 || !pdev_name)
 		return ERR_PTR(-EINVAL);
@@ -416,6 +416,10 @@ struct omap_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 	else
 		ret = omap_device_register(od);
 
+	/* each hwmod has a pointer to its attached omap_device */
+	for (i = 0, oh = hwmods[0]; i < oh_cnt; i++, oh++)
+		oh->od = od;
+
 	if (ret)
 		goto odbs_exit4;
 
-- 
1.7.0.2

