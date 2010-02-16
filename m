From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 10/24] omap4: clokcs: Make gpio driver's clock calls OMAP4 compatible
Date: Tue, 16 Feb 2010 21:28:01 +0530
Message-ID: <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54278 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757040Ab0BPP6g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:58:36 -0500
In-Reply-To: <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Abhijit Pagare <abhijitpagare@ti.com>

From: Abhijit Pagare <abhijitpagare@ti.com>

The gpio driver has been adapted for the OMAP4 way of clock calls.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
---
 arch/arm/plat-omap/gpio.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 6055028..5ae7a5a 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1724,7 +1724,10 @@ static int __init _omap_gpio_init(void)
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
-			sprintf(clk_name, "gpio%d_ick", i + 1);
+			if (!cpu_is_omap44xx())
+				sprintf(clk_name, "gpio%d_ick", i + 1);
+			else
+				sprintf(clk_name, "gpio%d_ck", i + 1);
 			gpio_iclks[i] = clk_get(NULL, clk_name);
 			if (IS_ERR(gpio_iclks[i]))
 				printk(KERN_ERR "Could not get %s\n", clk_name);
@@ -1891,7 +1894,7 @@ static int __init _omap_gpio_init(void)
 		set_irq_chained_handler(bank->irq, gpio_irq_handler);
 		set_irq_data(bank->irq, bank);
 
-		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		if (cpu_is_omap34xx()) {
 			sprintf(clk_name, "gpio%d_dbck", i + 1);
 			bank->dbck = clk_get(NULL, clk_name);
 			if (IS_ERR(bank->dbck))
-- 
1.6.0.4

