From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 01/33] CLK: clkdev: add support for looking up clocks from DT
Date: Tue, 23 Jul 2013 10:19:56 +0300
Message-ID: <1374564028-11352-2-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33439 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab3GWHWA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:22:00 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>

clk_get_sys / clk_get can now find clocks from device-tree. If a DT clock
is found, an entry is added to the clk_lookup list also for subsequent
searches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 drivers/clk/clkdev.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..e39f082 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -93,6 +93,18 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
 EXPORT_SYMBOL(of_clk_get_by_name);
 #endif
 
+/**
+ * clkdev_add_nolock - add lookup entry for a clock
+ * @cl: pointer to new clock lookup entry
+ *
+ * Non-locking version, used internally by clk_find() to add DT based
+ * clock lookup entries.
+ */
+static void clkdev_add_nolock(struct clk_lookup *cl)
+{
+	list_add_tail(&cl->node, &clocks);
+}
+
 /*
  * Find the correct struct clk for the device and connection ID.
  * We do slightly fuzzy matching here:
@@ -106,6 +118,9 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 {
 	struct clk_lookup *p, *cl = NULL;
 	int match, best_found = 0, best_possible = 0;
+	struct device_node *node;
+	struct clk *clk;
+	struct of_phandle_args clkspec;
 
 	if (dev_id)
 		best_possible += 2;
@@ -133,6 +148,23 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
 				break;
 		}
 	}
+
+	if (cl)
+		return cl;
+
+	/* If clock was not found, attempt to look-up from DT */
+	node = of_find_node_by_name(NULL, con_id);
+
+	clkspec.np = node;
+
+	clk = of_clk_get_from_provider(&clkspec);
+
+	if (!IS_ERR(clk)) {
+		/* We found a clock, add node to clkdev */
+		cl = clkdev_alloc(clk, con_id, dev_id);
+		clkdev_add_nolock(cl);
+	}
+
 	return cl;
 }
 
-- 
1.7.9.5

