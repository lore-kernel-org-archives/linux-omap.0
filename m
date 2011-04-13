From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAP: DSS2: improve clock debugfs output
Date: Wed, 13 Apr 2011 09:50:15 +0300
Message-ID: <1302677417-4590-4-git-send-email-tomi.valkeinen@ti.com>
References: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51904 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755295Ab1DMGuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 02:50:40 -0400
Received: by eyg7 with SMTP id 7so194876eyg.27
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 23:50:37 -0700 (PDT)
In-Reply-To: <1302677417-4590-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP4 has clocks set up in a bit interesting way, causing, for example,
the DSS's "ick" to be called "dss_fck".

This patch changes the debugfs output to show both the DSS's name for
the clock (ie. basically the clock alias), and the real name from the
clock struct.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index a8d4402..118d320 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -1026,6 +1026,14 @@ static void core_dump_clocks(struct seq_file *s)
 		dss.dss_video_fck
 	};
 
+	const char *names[5] = {
+		"ick",
+		"fck",
+		"sys_clk",
+		"tv_fck",
+		"video_fck"
+	};
+
 	seq_printf(s, "- CORE -\n");
 
 	seq_printf(s, "internal clk count\t\t%u\n", dss.num_clks_enabled);
@@ -1033,8 +1041,11 @@ static void core_dump_clocks(struct seq_file *s)
 	for (i = 0; i < 5; i++) {
 		if (!clocks[i])
 			continue;
-		seq_printf(s, "%-15s\t%lu\t%d\n",
+		seq_printf(s, "%s (%s)%*s\t%lu\t%d\n",
+				names[i],
 				clocks[i]->name,
+				24 - strlen(names[i]) - strlen(clocks[i]->name),
+				"",
 				clk_get_rate(clocks[i]),
 				clocks[i]->usecount);
 	}
-- 
1.7.1

