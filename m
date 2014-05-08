From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 3/5] arm: omap2: skip device build from platform code for dt.
Date: Thu, 8 May 2014 11:30:06 +0530
Message-ID: <1399528808-6920-4-git-send-email-sourav.poddar@ti.com>
References: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50510 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbaEHGBE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 02:01:04 -0400
In-Reply-To: <1399528808-6920-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zbr@ioremap.net, tony@atomide.com, michael.opdenacker@free-electrons.com, wsa@the-dreams.de, paul@pwsan.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

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

