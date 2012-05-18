From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP: PM: Lock clocks list while generating summary
Date: Fri, 18 May 2012 12:56:39 -0500
Message-ID: <1337363799-22085-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:58547 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965082Ab2ERR4o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 13:56:44 -0400
Received: by yhjj56 with SMTP id j56so3352097yhj.6
        for <linux-omap@vger.kernel.org>; Fri, 18 May 2012 10:56:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Todd Poynor <toddpoynor@google.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

From: Todd Poynor <toddpoynor@google.com>

commit a53025724052b2b1edbc982a4a248784638f563d
(OMAP: Add debugfs node to show the summary of all clocks)

Introduced clock summary, however, we are interested in seeing
snapshot of the clock state, not in dynamically changing clock
configurations as the data provided by clock summary will then be
useless for debugging configuration issues. So, hold the common lock
when dumping the clock summary.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

[nm@ti.com: added commit message]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/plat-omap/clock.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 62ec5c4..706b7e2 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -461,6 +461,7 @@ static int clk_dbg_show_summary(struct seq_file *s, void *unused)
 	struct clk *c;
 	struct clk *pa;
 
+	mutex_lock(&clocks_mutex);
 	seq_printf(s, "%-30s %-30s %-10s %s\n",
 		"clock-name", "parent-name", "rate", "use-count");
 
@@ -469,6 +470,7 @@ static int clk_dbg_show_summary(struct seq_file *s, void *unused)
 		seq_printf(s, "%-30s %-30s %-10lu %d\n",
 			c->name, pa ? pa->name : "none", c->rate, c->usecount);
 	}
+	mutex_unlock(&clocks_mutex);
 
 	return 0;
 }
-- 
1.7.9.5

