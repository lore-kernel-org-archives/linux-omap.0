From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 2/6] arm: mach-omap2: smartreflex: fix sr_late_init() error path in probe
Date: Thu, 24 Mar 2011 18:35:31 +0200
Message-ID: <1300984535-10530-2-git-send-email-aaro.koskinen@nokia.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:29107 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab1CXQiv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 12:38:51 -0400
In-Reply-To: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

sr_late_init() will take care of freeing the resources.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 8f674c9..6dfc8db 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -883,7 +883,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		ret = sr_late_init(sr_info);
 		if (ret) {
 			pr_warning("%s: Error in SR late init\n", __func__);
-			goto err_release_region;
+			return ret;
 		}
 	}
 
-- 
1.5.6.5

