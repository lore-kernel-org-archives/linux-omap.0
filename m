From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/4] clk: ti: add support for default-rate property from DT
Date: Thu, 13 Feb 2014 11:00:47 +0200
Message-ID: <1392282048-6284-4-git-send-email-t-kristo@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58379 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbaBMJB3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 04:01:29 -0500
In-Reply-To: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

default-rate property can now be used to define default rates for clocks,
which get configured during boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm_common.c |    2 ++
 drivers/clk/ti/clk.c             |    1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b4c4ab9..4703545 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -528,5 +528,7 @@ int __init of_prcm_init(void)
 
 	ti_dt_clockdomains_setup();
 
+	of_clk_set_init_rates();
+
 	return 0;
 }
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index b1a6f71..23998b7 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -156,6 +156,7 @@ void ti_dt_clk_init_provider(struct device_node *parent, int index)
 		clk_init_cb = (of_clk_init_cb_t)match->data;
 		pr_debug("%s: initializing: %s\n", __func__, np->name);
 		clk_init_cb(np);
+		of_clk_parse_init_rate(np, NULL);
 	}
 
 	list_for_each_entry_safe(retry, tmp, &retry_list, link) {
-- 
1.7.9.5

