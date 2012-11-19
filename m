From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 2/7] mmc: omap_hsmmc: no reset of cmd state machine for DCRC
Date: Mon, 19 Nov 2012 21:59:56 +0530
Message-ID: <1353342601-15210-2-git-send-email-svenkatr@ti.com>
References: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1353342601-15210-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

Avoid soft reset of command internal state machine on data errors.

Signed-off-by: Balaji T K <balajitk@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0fcf792..2d90da8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -972,8 +972,8 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
 					int err, int end_cmd)
 {
-	omap_hsmmc_reset_controller_fsm(host, SRC);
 	if (end_cmd) {
+		omap_hsmmc_reset_controller_fsm(host, SRC);
 		if (host->cmd)
 			host->cmd->error = err;
 	}
-- 
1.8.0

