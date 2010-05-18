From: Charulatha V <charu@ti.com>
Subject: [PATCH 02/11] OMAP: GPIO: Include platform_data structure for GPIO
Date: Tue, 18 May 2010 20:20:51 +0530
Message-ID: <1274194260-16401-3-git-send-email-charu@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35801 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757882Ab0EROty (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 10:49:54 -0400
In-Reply-To: <1274194260-16401-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch introduces platform_data structure for GPIO
so that GPIO module can be implemented in platform device model.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/include/plat/gpio.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index a06acb6..d2d310b 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -28,6 +28,7 @@
 
 #include <linux/io.h>
 #include <mach/irqs.h>
+#include <linux/platform_device.h>
 
 #define OMAP1_MPUIO_BASE		0xfffb5000
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
@@ -137,6 +138,20 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+struct omap_gpio_dev_attr {
+	int gpio_bank_count;
+	int gpio_bank_bits;
+	bool dbck_flag;
+	bool fck_flag;
+	bool arm_gpio_ck_flag;
+};
+
+struct omap_gpio_platform_data {
+	u16 virtual_irq_start;
+	int method;
+	struct omap_gpio_dev_attr *gpio_attr;
+};
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
-- 
1.6.3.3

