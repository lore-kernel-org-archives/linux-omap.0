From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 09/18] omap3+: sr: fix cosmetic indentation
Date: Wed,  2 Mar 2011 16:25:22 +0530
Message-ID: <1299063331-27968-10-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:46280 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757159Ab1CBK5B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:57:01 -0500
Received: by mail-yw0-f51.google.com with SMTP id 4so2018061ywg.10
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:57:00 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Error label case seems to have a 2 tab indentation when just 1 is
necessary.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 35658a2..99e4c4f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -289,15 +289,15 @@ static int sr_late_init(struct omap_sr *sr_info)
 	return ret;
 
 error:
-		iounmap(sr_info->base);
-		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
-		release_mem_region(mem->start, resource_size(mem));
-		list_del(&sr_info->node);
-		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
-			"interrupt handler. Smartreflex will"
-			"not function as desired\n", __func__);
-		kfree(sr_info);
-		return ret;
+	iounmap(sr_info->base);
+	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	list_del(&sr_info->node);
+	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
+		"interrupt handler. Smartreflex will"
+		"not function as desired\n", __func__);
+	kfree(sr_info);
+	return ret;
 }
 
 static void sr_v1_disable(struct omap_sr *sr)
-- 
1.7.1

