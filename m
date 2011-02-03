From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 05/13] arm: omap: irqs: add CBUS_RETU_IRQ_BASE and CBUS_RETU_IRQ_END
Date: Thu,  3 Feb 2011 12:20:20 +0200
Message-ID: <1296728428-26399-6-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47216 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756132Ab1BCKUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:20:48 -0500
Received: by mail-fx0-f45.google.com with SMTP id 12so1076525fxm.32
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:20:47 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

those two will be used to pass down irq_base and irq_end
to retu platform_driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/include/plat/irqs.h |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 2910de9..d62e795 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -411,7 +411,15 @@
 #define TWL_IRQ_END		TWL6030_IRQ_END
 #endif
 
-#define NR_IRQS			TWL_IRQ_END
+#define CBUS_RETU_IRQ_BASE	TWL_IRQ_END
+#ifdef CONFIG_CBUS_RETU
+#define CBUS_RETU_NR_IRQS	16
+#else
+#define CBUS_RETU_NR_IRQS	0
+#endif
+#define CBUS_RETU_IRQ_END	(CBUS_RETU_IRQ_BASE + CBUS_RETU_NR_IRQS)
+
+#define NR_IRQS			CBUS_RETU_IRQ_END
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
-- 
1.7.4.rc2

