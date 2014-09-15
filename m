From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/9] irqchip: add irq-omap-intc.h header
Date: Mon, 15 Sep 2014 16:15:01 -0500
Message-ID: <1410815709-462-2-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34833 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbaIOVP4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Sep 2014 17:15:56 -0400
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

OMAP INTC irqchip driver will be moved under
drivers/irqchip/ soon but we still have a dependency
with mach-omap2 when it comes to idle functions.

In order to make it easy to share those function
prototypes with OMAP PM code, we introduce this new
header.

To avoid modifying several board-files and some of
the PM-related code, we just include the new header
from common.h which was already included by all
users of IRQ-related PM code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/common.h          | 10 +---------
 include/linux/irqchip/irq-omap-intc.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/irqchip/irq-omap-intc.h

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 1800093..377eea8 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -32,6 +32,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/i2c-omap.h>
 #include <linux/reboot.h>
+#include <linux/irqchip/irq-omap-intc.h>
 
 #include <asm/proc-fns.h>
 
@@ -210,15 +211,6 @@ extern struct device *omap2_get_iva_device(void);
 extern struct device *omap2_get_l3_device(void);
 extern struct device *omap4_get_dsp_device(void);
 
-void omap2_init_irq(void);
-void omap3_init_irq(void);
-void ti81xx_init_irq(void);
-extern int omap_irq_pending(void);
-void omap_intc_save_context(void);
-void omap_intc_restore_context(void);
-void omap3_intc_suspend(void);
-void omap3_intc_prepare_idle(void);
-void omap3_intc_resume_idle(void);
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/include/linux/irqchip/irq-omap-intc.h b/include/linux/irqchip/irq-omap-intc.h
new file mode 100644
index 0000000..e06b370
--- /dev/null
+++ b/include/linux/irqchip/irq-omap-intc.h
@@ -0,0 +1,32 @@
+/**
+ * irq-omap-intc.h - INTC Idle Functions
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: Felipe Balbi <balbi@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H
+#define __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H
+
+void omap2_init_irq(void);
+void omap3_init_irq(void);
+void ti81xx_init_irq(void);
+
+int omap_irq_pending(void);
+void omap_intc_save_context(void);
+void omap_intc_restore_context(void);
+void omap3_intc_suspend(void);
+void omap3_intc_prepare_idle(void);
+void omap3_intc_resume_idle(void);
+
+#endif /* __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H */
-- 
2.0.1.563.g66f467c

