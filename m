From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH v2 05/12] arm: omap: irqs: add CBUS_RETU_IRQ_BASE and CBUS_RETU_IRQ_END
Date: Fri,  7 Jan 2011 11:08:03 +0200
Message-ID: <1294391290-7285-6-git-send-email-balbi@ti.com>
References: <1294391290-7285-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54886 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754259Ab1AGJI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:08:29 -0500
Received: by mail-ew0-f52.google.com with SMTP id 23so7550926ewy.11
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:08:28 -0800 (PST)
In-Reply-To: <1294391290-7285-1-git-send-email-balbi@ti.com>
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
1.7.3.4.598.g85356

