From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 10/15] OMAP: DSS2: Fix compile warning
Date: Fri,  8 Jan 2010 15:22:44 +0200
Message-ID: <1262956969-1664-11-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-8-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-9-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57056 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab0AHNWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:31 -0500
In-Reply-To: <1262956969-1664-10-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index dbb0ce2..82918ee 100644
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
1.6.5

