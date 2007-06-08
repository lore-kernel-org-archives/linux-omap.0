From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Subject: [PATCH] Fixing SD response type 6 vs. 1
Date: Fri, 08 Jun 2007 09:59:42 -0400
Message-ID: <20070608135942.2884.86105.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>

Fixing reponse type R6 for CMD3 when SD Card will be attached.

Ignoring OMAP_MMC_STAT_CARD_ERR, treating it as if the command
completed correctly.

Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---

 drivers/mmc/host/omap.c |   24 +++---------------------
 1 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 383bd54..b6a55e1 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -524,28 +524,10 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 		}
 
 		if (status & OMAP_MMC_STAT_CARD_ERR) {
-			if (host->cmd && host->cmd->opcode == MMC_STOP_TRANSMISSION) {
-				u32 response = OMAP_MMC_READ(host, RSP6)
-					| (OMAP_MMC_READ(host, RSP7) << 16);
-				/* STOP sometimes sets must-ignore bits */
-				if (!(response & (R1_CC_ERROR
-								| R1_ILLEGAL_COMMAND
-								| R1_COM_CRC_ERROR))) {
-					end_command = 1;
-					continue;
-				}
-			}
-
-			dev_dbg(mmc_dev(host->mmc), "card status error (CMD%d)\n",
+			dev_dbg(mmc_dev(host->mmc),
+				"ignoring card status error (CMD%d)\n",
 				host->cmd->opcode);
-			if (host->cmd) {
-				host->cmd->error = MMC_ERR_FAILED;
-				end_command = 1;
-			}
-			if (host->data) {
-				host->data->error = MMC_ERR_FAILED;
-				transfer_error = 1;
-			}
+			end_command = 1;
 		}
 
 		/*
