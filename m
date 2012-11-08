From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 08/26] ARM: OMAP: clock: Define a function to enable clocks at init
Date: Wed, 7 Nov 2012 17:12:43 -0800
Message-ID: <1352337181-29427-9-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52110 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab2KHBNd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:33 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Platform code can use omap2_clk_enable_init_clocks() to enable a
list of clocks that are needed to be enabled at init.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clock.c |   11 +++++++++++
 arch/arm/mach-omap2/clock.h |    1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2b4cfae..99fb246 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -458,6 +458,17 @@ int omap2_clk_disable_autoidle_all(void)
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
 const struct clk_hw_omap_ops clkhwops_wait = {
 	.find_idlest	= omap2_clk_dflt_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b075831..22555fd 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -565,6 +565,7 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_disable_autoidle_all(void);
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 #else
 int omap2_dflt_clk_enable(struct clk *clk);
 void omap2_dflt_clk_disable(struct clk *clk);
-- 
1.7.9.5

