From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/7] OMAP2/3 clock: add clock abort-rate-change notifications
Date: Tue, 23 Dec 2008 03:13:56 -0700
Message-ID: <20081223101355.22979.12267.stgit@localhost.localdomain>
References: <20081223101116.22979.53805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbYLWKOl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 05:14:41 -0500
In-Reply-To: <20081223101116.22979.53805.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Call clock notifiers with the CLK_ABORT_RATE_CHANGE message in two
conditions:

- in the PREPARE phase when another callback has denied the rate/parent
  change; or

- in the PRE phase if the set_rate() or set_parent() function fails.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 50d8e06..1600119 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -804,6 +804,7 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	if (r == NOTIFY_BAD) {
 		pr_debug("clock: %s: clk_set_rate() aborted by notifier\n",
 			 clk->name);
+		omap_clk_notify_downstream(clk, CLK_ABORT_RATE_CHANGE);
 		return -EAGAIN;
 	}
 
@@ -814,10 +815,16 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 	ret = clk->set_rate(clk, rate);
 
-	temp_rate = clk->rate;
-	clk->rate = clk->temp_rate;
-	omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
-	clk->rate = temp_rate;
+	if (ret == 0) {
+		temp_rate = clk->rate;
+		clk->rate = clk->temp_rate;
+		omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
+		clk->rate = temp_rate;
+	} else {
+		pr_debug("clock: %s: clk_set_rate() aborted by failed "
+			 "set_rate(): %d\n", clk->name, ret);
+		omap_clk_notify_downstream(clk, CLK_ABORT_RATE_CHANGE);
+	}
 
 	return ret;
 }
@@ -883,6 +890,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	if (r == NOTIFY_BAD) {
 		pr_debug("clock: %s: clk_set_parent() aborted by notifier\n",
 			 clk->name);
+		omap_clk_notify_downstream(clk, CLK_ABORT_RATE_CHANGE);
 		return -EAGAIN;
 	}
 


