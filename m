From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 12/24] ARM: omap: clk: Define a function to enable clocks at init
Date: Fri, 1 Jun 2012 17:37:53 +0530
Message-ID: <1338552485-31325-13-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59473 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759512Ab2FAMIr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:08:47 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Platform code can use omap2_clk_enable_init_clocks() to enable a
list of clocks that are needed to be enabled at init.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   11 +++++++++++
 arch/arm/mach-omap2/clock.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4c7fa4b..cdfa9c5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -375,6 +375,17 @@ int omap2_clk_disable_autoidle_all(void)
 	return 0;
 }
 
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
+{
+	struct clk *init_clk;
+	int i;
+
+	for (i = 0; i < num_clocks; i++) {
+		init_clk = clk_get(NULL, clk_names[i]);
+		clk_prepare_enable(init_clk);
+	}
+}
+
 const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
 	.allow_idle	= omap3_dpll_allow_idle,
 	.deny_idle	= omap3_dpll_deny_idle,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index fd73f7a..5767751 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -404,6 +404,7 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk, void __iomem **idlest_r
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_disable_autoidle_all(void);
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 #else
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
-- 
1.7.1

