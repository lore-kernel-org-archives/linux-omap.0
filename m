From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 07/31] dmaengine: PL08x: constify channel names and bus_id
 strings
Date: Thu, 07 Jun 2012 11:48:04 +0100
Message-ID: <E1ScaG4-0003kI-4p@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54181 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545Ab2FGKsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:48:09 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |    2 +-
 include/linux/amba/pl08x.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9494990..775efef 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -237,7 +237,7 @@ struct pl08x_dma_chan {
 	struct pl08x_phy_chan *phychan;
 	int phychan_hold;
 	struct tasklet_struct tasklet;
-	char *name;
+	const char *name;
 	const struct pl08x_channel_data *cd;
 	dma_addr_t src_addr;
 	dma_addr_t dst_addr;
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 48d02bf..158ce26 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -58,7 +58,7 @@ enum {
  * these buses (use PL08X_AHB1 | PL08X_AHB2).
  */
 struct pl08x_channel_data {
-	char *bus_id;
+	const char *bus_id;
 	int min_signal;
 	int max_signal;
 	u32 muxval;
-- 
1.7.4.4

