From: Charulatha V <charu@ti.com>
Subject: [PATCH:v4 03/13] OMAP: GPIO: Include platform_data structure for GPIO
Date: Tue, 22 Jun 2010 20:31:46 +0530
Message-ID: <1277218916-15213-4-git-send-email-charu@ti.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
 <1277218916-15213-2-git-send-email-charu@ti.com>
 <1277218916-15213-3-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41816 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756413Ab0FVPB2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 11:01:28 -0400
In-Reply-To: <1277218916-15213-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com, b-cousson@ti.com, Charulatha V <charu@ti.com>

This patch introduces platform_data structure for GPIO
so that GPIO module can be implemented in platform device model.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/plat-omap/include/plat/gpio.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de1c604..212ce22 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -28,6 +28,7 @@
 
 #include <linux/io.h>
 #include <mach/irqs.h>
+#include <linux/platform_device.h>
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
 
@@ -71,6 +72,25 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+#define METHOD_MPUIO		0
+#define METHOD_GPIO_1510	1
+#define METHOD_GPIO_1610	2
+#define METHOD_GPIO_7XX		3
+#define METHOD_GPIO_24XX	5
+#define METHOD_GPIO_44XX	6
+
+struct omap_gpio_dev_attr {
+	int gpio_bank_width;	/* GPIO bank width */
+	bool dbck_flag;		/* dbck validity - True only for OMAP3&4 */
+	bool omap1_ick_flag;	/* OMAP1 ick - True only for OMAP15xx */
+};
+
+struct omap_gpio_platform_data {
+	u16 virtual_irq_start;
+	int bank_type;
+	struct omap_gpio_dev_attr *gpio_attr;
+};
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_idle(int power_state);
 extern void omap2_gpio_resume_after_idle(void);
-- 
1.6.3.3

