From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH PM 2/2] OMAP McSPI: spin_unlock_irq() missing
Date: Thu,  5 Feb 2009 13:07:09 +0200
Message-ID: <1233832029-21614-2-git-send-email-Aaro.Koskinen@nokia.com>
References: <498AC802.8040302@nokia.com>
 <1233832029-21614-1-git-send-email-Aaro.Koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60231 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZBELHh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 06:07:37 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n15B7Ymv025315
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 13:07:35 +0200
Received: from localhost.localdomain (esdhcp042201.research.nokia.com [172.21.42.201])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n15B790H027831
	for <linux-omap@vger.kernel.org>; Thu, 5 Feb 2009 13:07:10 +0200
In-Reply-To: <1233832029-21614-1-git-send-email-Aaro.Koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

spin_unlock_irq() not called on failure path

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 drivers/spi/omap2_mcspi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 4d09777..56e91a4 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -751,7 +751,7 @@ static void omap2_mcspi_work(struct work_struct *work)
 	spin_lock_irq(&mcspi->lock);
 
 	if (omap2_mcspi_enable_clocks(mcspi))
-		return;
+		goto out;
 
 	/* We only enable one channel at a time -- the one whose message is
 	 * at the head of the queue -- although this controller would gladly
@@ -855,6 +855,7 @@ static void omap2_mcspi_work(struct work_struct *work)
 
 	omap2_mcspi_disable_clocks(mcspi);
 
+out:
 	spin_unlock_irq(&mcspi->lock);
 }
 
-- 
1.5.4.3

