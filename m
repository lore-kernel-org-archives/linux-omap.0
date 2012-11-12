From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v3 3/3] mmc: omap_hsmmc: update error code for response_busy cmd
Date: Mon, 12 Nov 2012 18:36:44 +0530
Message-ID: <1352725604-20390-4-git-send-email-balajitk@ti.com>
References: <1352477176-6673-1-git-send-email-balajitk@ti.com>
 <1352725604-20390-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1352725604-20390-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, balbi@ti.com, Balaji T K <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

update error code to cmd->error for commands with response_busy and no data

Signed-off-by: Balaji T K <balajitk@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d931e08..352e18e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -980,8 +980,9 @@ static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
 	if (host->data) {
 		omap_hsmmc_reset_controller_fsm(host, SRD);
 		omap_hsmmc_dma_cleanup(host, err);
+	} else if (host->mrq && host->mrq->cmd) {
+		host->mrq->cmd->error = err;
 	}
-
 }
 
 static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
-- 
1.7.5.4

