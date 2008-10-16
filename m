From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 2/3] ARM: OMAP: calculate hsmmc data timeout accurately
Date: Thu, 16 Oct 2008 16:37:23 +0300
Message-ID: <48F74393.3040800@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24201 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbYJPNbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 09:31:24 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9GDVHB4006758
	for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 16:31:22 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>

The data timeout can be calculated from the clock
rate and timing values given by the card.  At
present the timeout is set to the maximum value,
about 2.7 secs.  When dealing with cards that do have
errors, this causes large unnecessary delays because
the correct timeout may be around 10 millisecs.

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8fb677e..942f68d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -64,6 +64,9 @@
 #define ICS			0x2
 #define CEN			(1<<2)
 #define CLKD_MASK		0x0000FFC0
+#define CLKD_SHIFT		6
+#define DTO_MASK		0x000F0000
+#define DTO_SHIFT		16
 #define INT_EN_MASK		0x307F0033
 #define INIT_STREAM		(1<<1)
 #define DP_SELECT		(1<<21)
@@ -661,6 +664,42 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
 	return 0;
 }
 
+static void set_data_timeout(struct mmc_omap_host *host,
+			     struct mmc_request *req)
+{
+	unsigned int timeout, cycle_ns;
+	uint32_t reg, clkd, dto = 0;
+
+	reg = OMAP_HSMMC_READ(host->base, SYSCTL);
+	clkd = (reg & CLKD_MASK) >> CLKD_SHIFT;
+	if (clkd == 0)
+		clkd = 1;
+
+	cycle_ns = 1000000000 / (clk_get_rate(host->fclk) / clkd);
+	timeout = req->data->timeout_ns / cycle_ns;
+	timeout += req->data->timeout_clks;
+	if (timeout) {
+		while ((timeout & 0x80000000) == 0) {
+			dto += 1;
+			timeout <<= 1;
+		}
+		dto = 31 - dto;
+		timeout <<= 1;
+		if (timeout && dto)
+			dto += 1;
+		if (dto >= 13)
+			dto -= 13;
+		else
+			dto = 0;
+		if (dto > 14)
+			dto = 14;
+	}
+
+	reg &= ~DTO_MASK;
+	reg |= dto << DTO_SHIFT;
+	OMAP_HSMMC_WRITE(host->base, SYSCTL, reg);
+}
+
 /*
  * Configure block length for MMC/SD cards and initiate the transfer.
  */
@@ -678,6 +717,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 
 	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
 					| (req->data->blocks << 16));
+	set_data_timeout(host, req);
 
 	host->datadir = (req->data->flags & MMC_DATA_WRITE) ?
 			OMAP_MMC_DATADIR_WRITE : OMAP_MMC_DATADIR_READ;
-- 
1.5.4.3
