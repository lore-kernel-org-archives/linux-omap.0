From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v6 20/25] gpio/omap: skip operations in runtime callbacks
Date: Wed, 31 Aug 2011 19:12:36 +0530
Message-ID: <1314798161-19523-21-git-send-email-tarun.kanti@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46694 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075Ab1HaNnh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:43:37 -0400
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Most operations within runtime callbacks should be skipped when
*_runtime_get_sync() and *_runtime_put_sync() are called in probe(),
*_gpio_request() and *_gpio_free(). We just need clock enable/disable.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 9d68b15..67c5a96 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1136,6 +1136,9 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 		clk_disable(bank->dbck);
 
+	if (!bank->mod_usage)
+		return 0;
+
 	/*
 	 * If going to OFF, remove triggering for all
 	 * non-wakeup GPIOs.  Otherwise spurious IRQs will be
@@ -1177,6 +1180,9 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
 		clk_enable(bank->dbck);
 
+	if (!bank->mod_usage)
+		return 0;
+
 	if (bank->get_context_loss_count) {
 		context_lost_cnt_after =
 			bank->get_context_loss_count(bank->dev);
-- 
1.7.0.4

