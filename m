From: hvaibhav@ti.com
Subject: [PATCH 1/5] dss2-core:Warning Fix: core_dump_clocks enclosed under DEBUG_FS
Date: Thu, 17 Dec 2009 20:48:25 +0530
Message-ID: <1261063105-19874-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43416 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965017AbZLQPSr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Dec 2009 10:18:47 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/video/omap2/dss/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 29497a0..2fabaf2 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -124,6 +124,7 @@ static void restore_all_ctx(void)
 	dss_clk_disable_all_no_ctx();
 }
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 /* CLOCKS */
 static void core_dump_clocks(struct seq_file *s)
 {
@@ -149,6 +150,7 @@ static void core_dump_clocks(struct seq_file *s)
 				clocks[i]->usecount);
 	}
 }
+#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
 
 static int dss_get_clock(struct clk **clock, const char *clk_name)
 {
-- 
1.6.2.4

