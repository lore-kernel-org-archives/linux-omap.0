From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 1/1] OMAP: McSPI: Unpaired clk_{en,dis}able calls.
Date: Thu, 19 Feb 2009 17:24:02 +0200
Message-ID: <e1ddb08341604496c13766d174bfe055662cc917.1235046721.git.ext-phil.2.carmody@nokia.com>
References: <>
 <1235057042-6833-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35442 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZBSPY3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 10:24:29 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1JFO8VT019485
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2009 17:24:26 +0200
In-Reply-To: <1235057042-6833-1-git-send-email-ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>

If the sky is always blue, and no functions fail, then the interface
and functional clocks will always be in the same state. However,
defensively, failure to enable the 2nd should re-disable the 1st.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/spi/omap2_mcspi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 3da8825..bdccb27 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -277,9 +277,10 @@ static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
 {
 	if (clk_enable(mcspi->ick))
 		return -ENODEV;
-	if (clk_enable(mcspi->fck))
+	if (clk_enable(mcspi->fck)) {
+		clk_disable(mcspi->ick);
 		return -ENODEV;
-
+	}
 	omap2_mcspi_restore_ctx(mcspi);
 
 	return 0;
-- 
1.5.4.3

