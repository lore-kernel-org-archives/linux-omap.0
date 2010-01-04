From: hvaibhav@ti.com
Subject: [PATCH 1/4] OMAP: DSS2: Fix compile warning
Date: Mon,  4 Jan 2010 20:04:14 +0530
Message-ID: <1262615657-22723-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38661 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab0ADOek (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:34:40 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

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

