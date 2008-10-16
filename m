From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 1/3] ARM: OMAP: hsmmc requires data reset after data timeout
Date: Thu, 16 Oct 2008 16:37:14 +0300
Message-ID: <48F7438A.8060706@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65404 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbYJPNa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 09:30:56 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9GDUljk004462
	for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 16:30:53 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>

According to TRM a software reset SRD after data timeout
is required.

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 00b1b68..8fb677e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -417,6 +417,11 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 					mmc_dma_cleanup(host);
 				else
 					host->data->error = -EILSEQ;
+				OMAP_HSMMC_WRITE(host->base, SYSCTL,
+					OMAP_HSMMC_READ(host->base,
+							SYSCTL) | SRD);
+				while (OMAP_HSMMC_READ(host->base,
+							SYSCTL) & SRD) ;
 				end_trans = 1;
 			}
 		}
-- 
1.5.4.3
