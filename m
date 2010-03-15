From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 2/7] OMAP3: serial: Use dev_* macros instead of printk
Date: Mon, 15 Mar 2010 18:04:07 -0500
Message-ID: <1268694252-21985-3-git-send-email-saaguirre@ti.com>
References: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57775 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386Ab0COXCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 19:02:34 -0400
In-Reply-To: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

As we have a struct device populated at the time we are
printing the errors, using dev_* macros makes more sense,
as could give a better idea where the error/warning came from.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ef91fc0..a55e6ae 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -550,7 +550,7 @@ static ssize_t sleep_timeout_store(struct device *dev,
 	unsigned int value;
 
 	if (sscanf(buf, "%u", &value) != 1) {
-		printk(KERN_ERR "sleep_timeout_store: Invalid value\n");
+		dev_err(dev, "sleep_timeout_store: Invalid value\n");
 		return -EINVAL;
 	}
 
@@ -666,8 +666,8 @@ void __init omap_serial_early_init(void)
 
 		/* Don't map zero-based physical address */
 		if (p->mapbase == 0) {
-			printk(KERN_WARNING "omap serial: No physical address"
-			       " for uart#%d, so skipping early_init...\n", i);
+			dev_warn(dev, "no physical address for uart#%d,"
+				 " so skipping early_init...\n", i);
 			continue;
 		}
 		/*
@@ -676,21 +676,21 @@ void __init omap_serial_early_init(void)
 		 */
 		p->membase = ioremap(p->mapbase, SZ_8K);
 		if (!p->membase) {
-			printk(KERN_ERR "ioremap failed for uart%i\n", i + 1);
+			dev_err(dev, "ioremap failed for uart%i\n", i + 1);
 			continue;
 		}
 
 		sprintf(name, "uart%d_ick", i + 1);
 		uart->ick = clk_get(NULL, name);
 		if (IS_ERR(uart->ick)) {
-			printk(KERN_ERR "Could not get uart%d_ick\n", i + 1);
+			dev_err(dev, "Could not get uart%d_ick\n", i + 1);
 			uart->ick = NULL;
 		}
 
 		sprintf(name, "uart%d_fck", i+1);
 		uart->fck = clk_get(NULL, name);
 		if (IS_ERR(uart->fck)) {
-			printk(KERN_ERR "Could not get uart%d_fck\n", i + 1);
+			dev_err(dev, "Could not get uart%d_fck\n", i + 1);
 			uart->fck = NULL;
 		}
 
-- 
1.6.3.3

