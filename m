From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/12] OMAP: omap_device: ensure hwmod tracks attached omap_device pointer
Date: Wed, 16 Jun 2010 17:17:05 -0700
Message-ID: <1276733833-18510-5-git-send-email-khilman@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49651 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758043Ab0FQAR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 20:17:27 -0400
Received: by mail-pw0-f46.google.com with SMTP id 1so3974097pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 17:17:27 -0700 (PDT)
In-Reply-To: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, thara@ti.com, b-cousson@ti.com

The omap_hwmod struct has a field to track the omap_device that is
attached to it, but it was not being assigned.  Fix by assigning omap_device
pointer when omap_device is built.

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

