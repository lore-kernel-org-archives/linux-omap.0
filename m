From: charu@ti.com
Subject: [PATCH] [OMAP] GPIO Module is reset during initialization
Date: Fri, 23 Oct 2009 21:25:29 +0530
Message-ID: <1256313329-24996-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58754 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbZJWPz2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 11:55:28 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9NFtUw4011757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 10:55:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

During initialization, GPIO module is reset using soft reset bit
of SYSCONFIG register

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 2304a5d..4579650 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -1670,7 +1671,7 @@ static int __init _omap_gpio_init(void)
 	}
 #endif
 	for (i = 0; i < gpio_bank_count; i++) {
-		int j, gpio_count = 16;
+		int j, gpio_count = 16, attempt = 0;
 
 		bank = &gpio_bank[i];
 		spin_lock_init(&bank->lock);
@@ -1698,6 +1699,15 @@ static int __init _omap_gpio_init(void)
 			static const u32 non_wakeup_gpios[] = {
 				0xe203ffc0, 0x08700040
 			};
+
+		/* Software Reset of GPIO module */
+		__raw_writel(0x0002, bank->base	+ OMAP24XX_GPIO_SYSCONFIG);
+		while (((__raw_readl(bank->base + OMAP24XX_GPIO_SYSSTATUS)
+					& 0x1) == 0) && attempt < 5) {
+			udelay(1);
+			attempt++;
+		}
+
 		if (cpu_is_omap44xx()) {
 			__raw_writel(0xffffffff, bank->base +
 						OMAP4_GPIO_IRQSTATUSCLR0);
-- 
1.6.0.4

