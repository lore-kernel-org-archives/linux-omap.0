From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 25/27] cbus: fix compile issue on tahvo and retu
Date: Thu, 13 Oct 2011 11:35:00 +0300
Message-ID: <1318494902-13093-25-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49789 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753905Ab1JMIf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:57 -0400
Received: by mail-bw0-f51.google.com with SMTP id zu17so1414416bkb.24
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:56 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

set_irq_noprobe has been renamed to irq_set_noprobe
on commit a0cd9ca2b907d7ee26575e7b63ac92dad768a75e
(genirq: Namespace cleanup) and cbus drivers were
left with broken compilation. Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c  |    2 +-
 drivers/cbus/tahvo.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index e749c0e..444a21e 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -279,7 +279,7 @@ static inline void retu_irq_setup(int irq)
 #ifdef CONFIG_ARM
 	set_irq_flags(irq, IRQF_VALID);
 #else
-	set_irq_noprobe(irq);
+	irq_set_noprobe(irq);
 #endif
 }
 
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 623dacb..c16e27d7 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -224,7 +224,7 @@ static inline void tahvo_irq_setup(int irq)
 #ifdef CONFIG_ARM
 	set_irq_flags(irq, IRQF_VALID);
 #else
-	set_irq_noprobe(irq);
+	irq_set_noprobe(irq);
 #endif
 }
 
-- 
1.7.6.396.ge0613

