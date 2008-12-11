From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] OMAP3 clock: Add debugging in omap3_noncore_dpll_enable()
Date: Thu, 11 Dec 2008 14:22:40 -0700
Message-ID: <20081211212240.22860.68001.stgit@localhost.localdomain>
References: <20081211212030.22860.49518.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51043 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199AbYLKVZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 16:25:13 -0500
In-Reply-To: <20081211212030.22860.49518.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

For testing only, not for merging.

Add some debugging in omap3_noncore_dpll_enable() to try to figure out what
is wrong with ehci-omap.c.
---
 arch/arm/mach-omap2/clock34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 2c655be..9f7c5bf 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -275,6 +275,10 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	if (!dd)
 		return -EINVAL;
 
+	pr_info("clock: %s: clk->rate = %ld, hdwr rate = %d, parent "
+		"rate = %ld\n", clk->name, clk->rate,
+		omap2_get_dpll_rate(clk), dd->bypass_clk->rate);
+
 	if (clk->rate == dd->bypass_clk->rate)
 		r = _omap3_noncore_dpll_bypass(clk);
 	else


