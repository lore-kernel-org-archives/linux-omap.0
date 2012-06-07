From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/11] ARM: OMAP: PM: Lock clocks list while generating
 summary
Date: Thu, 07 Jun 2012 00:13:12 -0600
Message-ID: <20120607061311.25532.12581.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60892 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760089Ab2FGGVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 02:21:38 -0400
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Todd Poynor <toddpoynor@google.com>

From: Todd Poynor <toddpoynor@google.com>

Commit a53025724052b2b1edbc982a4a248784638f563d (OMAP: Add debugfs
node to show the summary of all clocks) introduced clock summary,
however, we are interested in seeing snapshot of the clock state, not
in dynamically changing clock configurations as the data provided by
clock summary will then be useless for debugging configuration
issues. So, hold the common lock when dumping the clock summary.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
[nm@ti.com: added commit message]
Signed-off-by: Nishanth Menon <nm@ti.com>
[paul@pwsan.com: minor edits to commit message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


