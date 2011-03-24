From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 5/6] arm: mach-omap2: smartreflex: delete instance from sr_list on probe error
Date: Thu, 24 Mar 2011 18:35:34 +0200
Message-ID: <1300984535-10530-5-git-send-email-aaro.koskinen@nokia.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:29084 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab1CXQiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 12:38:50 -0400
In-Reply-To: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

If the probe fails, the node should be deleted from sr_list.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e72b419..c8cd1ef 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -954,6 +954,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	return ret;
 
 err_iounmap:
+	list_del(&sr_info->node);
 	iounmap(sr_info->base);
 err_release_region:
 	release_mem_region(mem->start, resource_size(mem));
-- 
1.5.6.5

