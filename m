From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 11/19] OMAP3+: SR: fix cosmetic indentation
Date: Sat,  5 Mar 2011 20:59:14 +0530
Message-ID: <1299338962-5602-12-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:57807 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab1CEPbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:31:25 -0500
Received: by gwaa20 with SMTP id a20so1714084gwa.9
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:31:24 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Error label case seems to have a 2 tab indentation when just 1 is
necessary.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2b6fdc7..1e52d61 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -276,16 +276,16 @@ static int sr_late_init(struct omap_sr *sr_info)
 	return ret;
 
 error:
-		iounmap(sr_info->base);
-		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
-		release_mem_region(mem->start, resource_size(mem));
-		list_del(&sr_info->node);
-		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
-			"interrupt handler. Smartreflex will"
-			"not function as desired\n", __func__);
-		kfree(name);
-		kfree(sr_info);
-		return ret;
+	iounmap(sr_info->base);
+	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	list_del(&sr_info->node);
+	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
+		"interrupt handler. Smartreflex will"
+		"not function as desired\n", __func__);
+	kfree(name);
+	kfree(sr_info);
+	return ret;
 }
 
 static void sr_v1_disable(struct omap_sr *sr)
-- 
1.7.1

