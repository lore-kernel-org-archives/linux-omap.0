From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [MMC] omap: Remove BUG_ON for disabled interrupts
Date: Sat, 29 May 2010 19:27:23 -0700
Message-ID: <1275186443-8242-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: akpm@linux-foundation.org, Cory Maccarrone <darkstar6262@gmail.com>
List-Id: linux-omap@vger.kernel.org

This change removes a BUG_ON for when interrupts are disabled
during an MMC request.  During boot, interrupts can be disabled
when a request is made, causing this bug to be triggered.  In reality,
there's no reason this should halt the kernel, as the driver has proved
reliable in spite of disabled interrupts, and additionally, there's
nothing in this code that would require interrupts to be enabled.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 drivers/mmc/host/omap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 2b28168..d98ddcf 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1157,7 +1157,6 @@ static void mmc_omap_start_request(struct mmc_omap_host *host,
 	mmc_omap_start_command(host, req->cmd);
 	if (host->dma_in_use)
 		omap_start_dma(host->dma_ch);
-	BUG_ON(irqs_disabled());
 }
 
 static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
-- 
1.7.0.4

