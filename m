From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/19] omap3+: sr: fix cosmetic indentation
Date: Sat, 19 Feb 2011 17:31:49 +0530
Message-ID: <1298116918-30744-11-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:43557 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753966Ab1BSMD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:03:27 -0500
Received: by mail-gy0-f180.google.com with SMTP id 6so4585968gya.25
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:03:26 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Error label case seems to have a 2 tab indentation when just 1 is
necessary.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index fb675c0..1fe8b95 100644
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

