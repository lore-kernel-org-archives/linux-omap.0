From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/7] OMAP2/3 clock: add clock pre-rate-change notification
Date: Tue, 23 Dec 2008 03:13:55 -0700
Message-ID: <20081223101354.22979.89860.stgit@localhost.localdomain>
References: <20081223101116.22979.53805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58111 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbYLWKOk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 05:14:40 -0500
In-Reply-To: <20081223101116.22979.53805.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Call the clock notifiers immediately before changing the clock's rate or
parent.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 843d1b5..2a024bf 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -802,6 +802,8 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 	pr_debug("clock: %s: set_rate from %ld Hz to %ld Hz\n", clk->name,
 		 clk->rate, rate);
 
+	omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE);
+
 	ret = clk->set_rate(clk, rate);
 
 	temp_rate = clk->rate;
@@ -868,6 +870,8 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		propagate_rate(clk, TEMP_RATE);
 	}
 
+	omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE);
+
 	if (clk->usecount > 0)
 		_omap2_clk_disable(clk);
 


