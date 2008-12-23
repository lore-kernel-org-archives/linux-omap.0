From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/7] OMAP2/3 clock: add clk post-rate-change notifiers
Date: Tue, 23 Dec 2008 03:13:54 -0700
Message-ID: <20081223101353.22979.44354.stgit@localhost.localdomain>
References: <20081223101116.22979.53805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58110 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYLWKOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 05:14:40 -0500
In-Reply-To: <20081223101116.22979.53805.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Calls the  clock post-rate-change notifier whenever clock rates are changed
in the OMAP clock framework.  This is primarily in *_recalc() functions.

One item to note is that the post-rate-change notifier is called even
if the new clock rate is identical to the old rate.  This is because
the process of changing the rate may have temporarily disabled or
glitched the clock or one of its parents, and some devices may be
sensitive to such changes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index c990a17..843d1b5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -789,6 +789,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
+	unsigned long temp_rate;
 
 	if (!clk->set_rate)
 		return -EINVAL;
@@ -803,6 +804,11 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 	ret = clk->set_rate(clk, rate);
 
+	temp_rate = clk->rate;
+	clk->rate = clk->temp_rate;
+	omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
+	clk->rate = temp_rate;
+
 	return ret;
 }
 
@@ -878,11 +884,14 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		_omap2_clk_enable(clk);
 
 	clk->parent = new_parent;
-	clk->rate = new_rate;
 
 	pr_debug("clock: %s: set parent to %s (orig rate %ld, new rate %ld)\n",
 		 clk->name, clk->parent->name, orig_rate, new_rate);
 
+	omap_clk_notify_downstream(clk, CLK_POST_RATE_CHANGE);
+
+	clk->rate = new_rate;
+
 	return 0;
 }
 


