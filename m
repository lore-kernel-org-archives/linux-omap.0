From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 11/22] cbus: retu: IRQ demux optimization
Date: Mon, 11 Jul 2011 14:17:24 +0300
Message-ID: <1310383055-20211-12-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53189 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754997Ab1GKLSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:40 -0400
Received: by mail-yw0-f41.google.com with SMTP id 39so1505759ywm.0
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:39 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

it's definitely not always that we will have
all 16 interrupts fired at the same time, so
in order to avoid looping so many times, we
are now using ffs() which is implemented
(on ARM) using the far better clz instruction.

This will save us quite some loops and could
improve IRQ latency on Retu significantly
(no actual measurements were made, though)

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index b7fbd18..e749c0e 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -36,6 +36,8 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/cbus.h>
 
+#include <asm/bitops.h>
+
 #include "cbus.h"
 #include "retu.h"
 
@@ -183,8 +185,6 @@ static irqreturn_t retu_irq_handler(int irq, void *_retu)
 {
 	struct retu		*retu = _retu;
 
-	int			i;
-
 	u16			idr;
 	u16			imr;
 
@@ -199,11 +199,13 @@ static irqreturn_t retu_irq_handler(int irq, void *_retu)
 		return IRQ_NONE;
 	}
 
-	for (i = retu->irq_base; idr != 0; i++, idr >>= 1) {
-		if (!(idr & 1))
-			continue;
+	while (idr) {
+		unsigned long	pending = __ffs(idr);
+		unsigned int	irq;
 
-		handle_nested_irq(i);
+		idr &= ~BIT(pending);
+		irq = pending + retu->irq_base;
+		handle_nested_irq(irq);
 	}
 
 	return IRQ_HANDLED;
-- 
1.7.6

