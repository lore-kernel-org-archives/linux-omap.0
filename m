From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] MMC: OMAP: Flush posted write to IRQ
Date: Mon, 06 Apr 2009 12:58:48 +0300
Message-ID: <49D9D258.80008@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26883 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbZDFJ7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 05:59:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Mon, 6 Apr 2009 12:54:21 +0300
Subject: [PATCH] MMC: OMAP: Flush posted write to IRQ

Flush posted write to IRQ status register in HSMMC interrupt handler
to avoid spurious interrupts.

This is in addition to commit id,
b420f201e8c3bba92606fb98a032ee019804835d

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
  drivers/mmc/host/omap_hsmmc.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ac51f0b..c1f09fa 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -415,6 +415,8 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
  	if (host->cmd == NULL && host->data == NULL) {
  		OMAP_HSMMC_WRITE(host->base, STAT,
  			OMAP_HSMMC_READ(host->base, STAT));
+		/* Flush posted write to avoid spurious interrupt */
+		OMAP_HSMMC_READ(host->base, STAT);
  		return IRQ_HANDLED;
  	}

-- 
1.5.6.3
