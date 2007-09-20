From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 06/14] MMC: OMAP: Abort stuck commands
Date: Thu, 20 Sep 2007 11:03:27 -0400
Message-ID: <46F28BBF.8080503@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Jarkko Lavinen <jarkko.lavinen@nokia.com>

When a card is removed while it is being accessed, a command can get stuck so
that no timeout or end of command interrupt ever occurs. The command getting
stuck is almost always CDM12, but also the other commands can get stuck. Catch
a stuck command with a timer and try sending the initiliazation stream until
the controller starts running again and responds with the end of command
status.

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap.c |   93 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 992b27f..e9b56b5 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -136,6 +136,9 @@ struct mmc_omap_host {
 	unsigned char		bus_mode;
 	unsigned char		hw_bus_mode;
 
+	struct work_struct	cmd_abort;
+	struct timer_list	cmd_timer;
+
 	unsigned int		sg_len;
 	int			sg_idx;
 	u16 *			buffer;
@@ -330,6 +333,8 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
 	if (host->data && !(host->data->flags & MMC_DATA_WRITE))
 		cmdreg |= 1 << 15;
 
+	mod_timer(&host->cmd_timer, jiffies + HZ/2);
+
 	OMAP_MMC_WRITE(host, CTO, 200);
 	OMAP_MMC_WRITE(host, ARGL, cmd->arg & 0xffff);
 	OMAP_MMC_WRITE(host, ARGH, cmd->arg >> 16);
@@ -389,9 +394,37 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 }
 
 static void
+mmc_omap_send_abort(struct mmc_omap_host *host)
+{
+	struct mmc_omap_slot *slot = host->current_slot;
+	unsigned int restarts, passes, timeout;
+	u16 stat = 0;
+
+	/* Sending abort takes 80 clocks. Have some extra and round up */
+	timeout = (120*1000000 + slot->fclk_freq - 1)/slot->fclk_freq;
+	restarts = 0;
+	while (restarts < 10000) {
+		OMAP_MMC_WRITE(host, STAT, 0xFFFF);
+		OMAP_MMC_WRITE(host, CMD, (3 << 12) | (1 << 7));
+
+		passes = 0;
+		while (passes < timeout) {
+			stat = OMAP_MMC_READ(host, STAT);
+			if (stat & OMAP_MMC_STAT_END_OF_CMD)
+				goto out;
+			udelay(1);
+			passes++;
+		}
+
+		restarts++;
+	}
+out:
+	OMAP_MMC_WRITE(host, STAT, stat);
+}
+
+static void
 mmc_omap_abort_xfer(struct mmc_omap_host *host, struct mmc_data *data)
 {
-	int loops;
 	u16 ie;
 
 	if (host->dma_in_use)
@@ -402,16 +435,8 @@ mmc_omap_abort_xfer(struct mmc_omap_host *host, struct mmc_data *data)
 
 	ie = OMAP_MMC_READ(host, IE);
 	OMAP_MMC_WRITE(host, IE, 0);
-	OMAP_MMC_WRITE(host, CMD, 1 << 7);
-	loops = 0;
-	while (!(OMAP_MMC_READ(host, STAT) & OMAP_MMC_STAT_END_OF_CMD)) {
-		udelay(1);
-		loops++;
-		if (loops == 100000)
-			break;
-	}
-	OMAP_MMC_WRITE(host, STAT, OMAP_MMC_STAT_END_OF_CMD);
 	OMAP_MMC_WRITE(host, IE, ie);
+	mmc_omap_send_abort(host);
 }
 
 static void
@@ -467,6 +492,8 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 {
 	host->cmd = NULL;
 
+	del_timer(&host->cmd_timer);
+
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
 			/* response type 2 */
@@ -502,6 +529,47 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 	}
 }
 
+/*
+ * Abort stuck command. Can occur when card is removed while it is being
+ * read.
+ */
+static void mmc_omap_abort_command(struct work_struct *work)
+{
+	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
+						  cmd_abort);
+	u16 ie;
+
+	ie = OMAP_MMC_READ(host, IE);
+	OMAP_MMC_WRITE(host, IE, 0);
+
+	if (!host->cmd) {
+		OMAP_MMC_WRITE(host, IE, ie);
+		return;
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "Aborting stuck command CMD%d\n",
+		host->cmd->opcode);
+
+	if (host->data && host->dma_in_use)
+		mmc_omap_release_dma(host, host->data, 1);
+
+	host->data = NULL;
+	host->sg_len = 0;
+
+	mmc_omap_send_abort(host);
+	host->cmd->error = MMC_ERR_TIMEOUT;
+	mmc_omap_cmd_done(host, host->cmd);
+	OMAP_MMC_WRITE(host, IE, ie);
+}
+
+static void
+mmc_omap_cmd_timer(unsigned long data)
+{
+	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
+
+	schedule_work(&host->cmd_abort);
+}
+
 /* PIO only */
 static void
 mmc_omap_sg_to_buf(struct mmc_omap_host *host)
@@ -1270,6 +1338,11 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		goto err_free_mem_region;
 	}
 
+	INIT_WORK(&host->cmd_abort, mmc_omap_abort_command);
+	init_timer(&host->cmd_timer);
+	host->cmd_timer.function = mmc_omap_cmd_timer;
+	host->cmd_timer.data = (unsigned long) host;
+
 	spin_lock_init(&host->dma_lock);
 	init_timer(&host->dma_timer);
 	spin_lock_init(&host->slot_lock);
-- 1.5.3.GIT
