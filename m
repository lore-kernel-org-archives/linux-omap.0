From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] clk: ti: dra7-atl-clock: fix a memory leak
Date: Fri, 12 Sep 2014 16:39:07 +0300
Message-ID: <1410529147-19950-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51072 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846AbaILNi6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2014 09:38:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

of_clk_add_provider makes an internal copy of the parent_names property
while its called, thus it is no longer needed after this call and can
be freed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/ti/clk-dra7-atl.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index 4a65b41..3f9308a 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -199,6 +199,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		kfree(parent_names);
 		return;
 	}
 cleanup:
-- 
1.7.9.5

