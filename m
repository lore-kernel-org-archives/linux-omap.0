From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 12/13] gpio/omap: fix incorrect context restore logic in omap_gpio_runtime_resume
Date: Wed, 7 Mar 2012 16:46:02 +0530
Message-ID: <1331118963-26364-13-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33553 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120Ab2CGLQT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Mar 2012 06:16:19 -0500
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

In omap_gpio_runtime_resume() the context restore should be independent
of bank->enabled_non_wakeup_gpios. This was preventing context restore
of GPIO lines which are not wakeup enabled.

Reported-by: Govindraj Raja <govindraj.raja@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/gpio/gpio-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2e8e476..ccfbae0 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1227,7 +1227,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 	__raw_writel(bank->context.risingdetect,
 		     bank->base + bank->regs->risingdetect);
 
-	if (!bank->enabled_non_wakeup_gpios || !bank->workaround_enabled) {
+	if (!bank->workaround_enabled) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
 	}
-- 
1.7.0.4

