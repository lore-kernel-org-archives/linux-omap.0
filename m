From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH 9/9] omap mmc host: Use disable_irq_nosync() from within
	irq handlers.
Date: Thu, 16 Apr 2009 15:55:21 +1000
Message-ID: <1239861321.29831.130.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out3.iinet.net.au ([203.59.1.148]:7672
	"EHLO outbound.icp-qv1-irony-out3.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756629AbZDPFz4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Apr 2009 01:55:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: pierre@ossman.eu, linux-kernel <linux-kernel@vger.kernel.org>


disable_irq() should wait for all running handlers to complete
before returning.  As such, if it's used to disable an interrupt
from that interrupt's handler it will deadlock.  This replaces
the dangerous instances with the _nosync() variant which doesn't
have this problem.

Signed-off-by: Ben Nizette <bn@niasdigital.com>
---
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5570849..d5ea652 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -824,7 +824,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 		del_timer(&host->cmd_abort_timer);
 		host->abort = 1;
 		OMAP_MMC_WRITE(host, IE, 0);
-		disable_irq(host->irq);
+		disable_irq_nosync(host->irq);
 		schedule_work(&host->cmd_abort_work);
 		return IRQ_HANDLED;
 	}
-- 
1.6.0.2



