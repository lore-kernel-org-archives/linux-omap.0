From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 3/4] drivers: input: Fix OMAP_GPIO_IRQ with gpio_to_irq() in ams_delta_serio_exit()
Date: Thu, 29 Mar 2012 15:31:56 +0530
Message-ID: <1333015317-11866-4-git-send-email-tarun.kanti@ti.com>
References: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab2C2KCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 06:02:17 -0400
In-Reply-To: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: olof@lixom.net, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Even though ams-delta-serio input driver uses gpio_to_irq() in all
relevent places to get irq number, the ams_delta_serio_exit() still
uses OMAP_GPIO_IRQ macro. Fix this.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 drivers/input/serio/ams_delta_serio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index d4d08bd..dbe1ae8 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -170,7 +170,7 @@ module_init(ams_delta_serio_init);
 static void __exit ams_delta_serio_exit(void)
 {
 	serio_unregister_port(ams_delta_serio);
-	free_irq(OMAP_GPIO_IRQ(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
+	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
 	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_CLK);
 	gpio_free(AMS_DELTA_GPIO_PIN_KEYBRD_DATA);
 }
-- 
1.7.0.4

