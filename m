From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] clk: ti: fix building without legacy omap3
Date: Wed, 19 Apr 2017 19:44:56 +0200
Message-ID: <20170419174507.4055014-2-arnd@arndb.de>
References: <20170419174507.4055014-1-arnd@arndb.de>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170419174507.4055014-1-arnd@arndb.de>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When CONFIG_ATAGS or CONFIG_OMAP3 is disabled, we get a build error:

In file included from include/linux/clk-provider.h:15:0,
                 from drivers/clk/ti/clk.c:19:
drivers/clk/ti/clk.c: In function 'ti_clk_add_aliases':
drivers/clk/ti/clk.c:438:29: error: 'simple_clk_match_table' undeclared (first use in this function); did you mean 'simple_attr_write'?

Moving the match table down fixes it.

Fixes: c17435c56bb1 ("clk: ti: add API for creating aliases automatically for simple clock types")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/ti/clk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index ddbad7e8d7c9..e5a1c8297a1d 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -371,12 +371,6 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	return clk;
 }
 
-static const struct of_device_id simple_clk_match_table[] __initconst = {
-	{ .compatible = "fixed-clock" },
-	{ .compatible = "fixed-factor-clock" },
-	{ }
-};
-
 int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 {
 	struct clk *clk;
@@ -425,6 +419,12 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 }
 #endif
 
+static const struct of_device_id simple_clk_match_table[] __initconst = {
+	{ .compatible = "fixed-clock" },
+	{ .compatible = "fixed-factor-clock" },
+	{ }
+};
+
 /**
  * ti_clk_add_aliases - setup clock aliases
  *
-- 
2.9.0

