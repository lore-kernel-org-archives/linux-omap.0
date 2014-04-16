From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 3/5] arm: omap2: skip device build from platform code for dt.
Date: Wed, 16 Apr 2014 18:02:10 +0530
Message-ID: <1397651532-31456-4-git-send-email-sourav.poddar@ti.com>
References: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52885 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714AbaDPMdH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Apr 2014 08:33:07 -0400
In-Reply-To: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zbr@ioremap.net, tony@atomide.com, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, paul@pwsan.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

For SOCs with dt enabled, device should be build through device tree.
Prevent device build call from platform code, if device tree is
enabled.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/mach-omap2/hdq1w.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/hdq1w.c b/arch/arm/mach-omap2/hdq1w.c
index cbc8e3c..f78b4a1 100644
--- a/arch/arm/mach-omap2/hdq1w.c
+++ b/arch/arm/mach-omap2/hdq1w.c
@@ -76,6 +76,7 @@ int omap_hdq1w_reset(struct omap_hwmod *oh)
 	return 0;
 }
 
+#ifndef CONFIG_OF
 static int __init omap_init_hdq(void)
 {
 	int id = -1;
@@ -95,3 +96,4 @@ static int __init omap_init_hdq(void)
 	return 0;
 }
 omap_arch_initcall(omap_init_hdq);
+#endif
-- 
1.7.9.5

