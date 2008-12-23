From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/7] OMAP2/3 clock: add clock prepare-rate-change notifications
Date: Tue, 23 Dec 2008 03:13:55 -0700
Message-ID: <20081223101355.22979.28301.stgit@localhost.localdomain>
References: <20081223101116.22979.53805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58118 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbYLWKOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 05:14:42 -0500
In-Reply-To: <20081223101116.22979.53805.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Call the clock notifiers before rate or parent changes.  If a callback
refuses the change, it should return NOTIFY_BAD; otherwise, NOTIFY_DONE.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2a024bf..50d8e06 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -790,6 +790,7 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
 	unsigned long temp_rate;
+	int r;
 
 	if (!clk->set_rate)
 		return -EINVAL;
@@ -799,6 +800,13 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 		propagate_rate(clk, TEMP_RATE);
 	}
 
+	r = omap_clk_notify_downstream(clk, CLK_PREPARE_RATE_CHANGE);
+	if (r == NOTIFY_BAD) {
+		pr_debug("clock: %s: clk_set_rate() aborted by notifier\n",
+			 clk->name);
+		return -EAGAIN;
+	}
+
 	pr_debug("clock: %s: set_rate from %ld Hz to %ld Hz\n", clk->name,
 		 clk->rate, rate);
 
@@ -851,6 +859,7 @@ static u32 _omap2_clksel_get_src_field(struct clk *src_clk, struct clk *clk,
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	u32 field_val, v, parent_div;
+	int r;
 	unsigned long orig_rate, new_rate;
 
 	if (!clk->clksel)
@@ -870,6 +879,13 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		propagate_rate(clk, TEMP_RATE);
 	}
 
+	r = omap_clk_notify_downstream(clk, CLK_PREPARE_RATE_CHANGE);
+	if (r == NOTIFY_BAD) {
+		pr_debug("clock: %s: clk_set_parent() aborted by notifier\n",
+			 clk->name);
+		return -EAGAIN;
+	}
+
 	omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE);
 
 	if (clk->usecount > 0)


