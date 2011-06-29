From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] cbus: retu: stop polluting <plat/irqs.h>
Date: Wed, 29 Jun 2011 14:46:51 +0300
Message-ID: <1309348011-23141-3-git-send-email-balbi@ti.com>
References: <1309348011-23141-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:49206 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755346Ab1F2LrE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 07:47:04 -0400
Received: by bwf20 with SMTP id 20so1182761bwf.20
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:47:02 -0700 (PDT)
In-Reply-To: <1309348011-23141-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

now that we're using sparse IRQs, we don't
need to polute <plat/irqs.h> anymore with
the dumb IRQ_BASE/IRQ_END definitions.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c   |    2 --
 arch/arm/mach-omap2/board-n8x0.c       |    2 --
 arch/arm/plat-omap/include/plat/irqs.h |   10 +---------
 include/linux/platform_data/cbus.h     |    2 --
 4 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 7990c48..5eb1a7f 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -124,8 +124,6 @@ static struct resource retu_resource[] = {
 };
 
 static struct cbus_retu_platform_data nokia770_retu_data = {
-	.irq_base	= CBUS_RETU_IRQ_BASE,
-	.irq_end	= CBUS_RETU_IRQ_END,
 	.devid		= CBUS_RETU_DEVICE_ID,
 };
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index b3e80c9..f7548e4 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -220,8 +220,6 @@ static struct resource retu_resource[] = {
 };
 
 static struct cbus_retu_platform_data n8x0_retu_data = {
-	.irq_base	= CBUS_RETU_IRQ_BASE,
-	.irq_end	= CBUS_RETU_IRQ_END,
 	.devid		= CBUS_RETU_DEVICE_ID,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 8c8f517..24eeccd 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -419,15 +419,7 @@
 #define OMAP_GPMC_NR_IRQS	8
 #define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
 
-#define CBUS_RETU_IRQ_BASE	OMAP_GPMC_IRQ_END
-#ifdef CONFIG_CBUS_RETU
-#define CBUS_RETU_NR_IRQS	16
-#else
-#define CBUS_RETU_NR_IRQS	0
-#endif
-#define CBUS_RETU_IRQ_END	(CBUS_RETU_IRQ_BASE + CBUS_RETU_NR_IRQS)
-
-#define NR_IRQS			CBUS_RETU_IRQ_END
+#define NR_IRQS			OMAP_GPMC_IRQ_END
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
diff --git a/include/linux/platform_data/cbus.h b/include/linux/platform_data/cbus.h
index a1c5a26..09809c7 100644
--- a/include/linux/platform_data/cbus.h
+++ b/include/linux/platform_data/cbus.h
@@ -32,8 +32,6 @@ struct cbus_host_platform_data {
 };
 
 struct cbus_retu_platform_data {
-	int	irq_base;
-	int	irq_end;
 	int	devid;
 };
 
-- 
1.7.6

