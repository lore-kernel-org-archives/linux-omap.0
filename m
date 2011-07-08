From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 11/11] cbus: retu: IRQ demux optimization
Date: Sat,  9 Jul 2011 01:52:39 +0300
Message-ID: <1310165559-31037-12-git-send-email-balbi@ti.com>
References: <1310165559-31037-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:41934 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377Ab1GHWxU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 18:53:20 -0400
Received: by mail-bw0-f49.google.com with SMTP id 12so3191254bwf.22
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 15:53:19 -0700 (PDT)
In-Reply-To: <1310165559-31037-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

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

