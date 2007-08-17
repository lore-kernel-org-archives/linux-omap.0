From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [06/17 PATCH] MMC: OMAP: General code cleanup, modifications at some
 dev_* functions and other hacks at mmc_omap_irq() for MMC multislot
 support.
Date: Fri, 17 Aug 2007 15:01:53 -0400
Message-ID: <46C5F0A1.3010204@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000307000303050706040901"
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
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000307000303050706040901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Juha Yrjola <juha.yrjola@solidboot.com>

General code cleanup, modifications at some dev_* functions and other
hacks at mmc_omap_irq() for MMC multislot support.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

--------------000307000303050706040901
Content-Type: text/x-patch;
	name*0="0006-MMC-OMAP-General-cleanup-for-mmc-multislot-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0006-MMC-OMAP-General-cleanup-for-mmc-multislot-support.patc";
	filename*1="h"

General code cleanup, modifications at some dev_* functions and other hacks at 
mmc_omap_irq() for MMC multislot support.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br> 

Index: linux-omap/drivers/mmc/host/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/host/omap.c	2007-08-16 12:33:07.000000000 -0400
+++ linux-omap/drivers/mmc/host/omap.c	2007-08-16 12:33:10.000000000 -0400
@@ -559,11 +559,12 @@ static irqreturn_t mmc_omap_irq(int irq,
 	u16 status;
 	int end_command;
 	int end_transfer;
-	int transfer_error;
+	int transfer_error, cmd_error;
 
 	if (host->cmd == NULL && host->data == NULL) {
 		status = OMAP_MMC_READ(host, STAT);
-		dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
+		dev_info(mmc_dev(host->slots[0]->mmc),
+			 "Spurious IRQ 0x%04x\n", status);
 		if (status != 0) {
 			OMAP_MMC_WRITE(host, STAT, status);
 			OMAP_MMC_WRITE(host, IE, 0);
@@ -574,12 +575,19 @@ static irqreturn_t mmc_omap_irq(int irq,
 	end_command = 0;
 	end_transfer = 0;
 	transfer_error = 0;
+	cmd_error = 0;
 
 	while ((status = OMAP_MMC_READ(host, STAT)) != 0) {
+		int cmd;
+
 		OMAP_MMC_WRITE(host, STAT, status);
+		if (host->cmd != NULL)
+			cmd = host->cmd->opcode;
+		else
+			cmd = -1;
 #ifdef CONFIG_MMC_DEBUG
 		dev_dbg(mmc_dev(host->mmc), "MMC IRQ %04x (CMD %d): ",
-			status, host->cmd != NULL ? host->cmd->opcode : -1);
+			status, cmd);
 		mmc_omap_report_irq(status);
 		printk("\n");
 #endif
@@ -591,12 +599,12 @@ static irqreturn_t mmc_omap_irq(int irq,
 				mmc_omap_xfer_data(host, 1);
 		}
 
-		if (status & OMAP_MMC_STAT_END_OF_DATA) {
+		if (status & OMAP_MMC_STAT_END_OF_DATA)
 			end_transfer = 1;
-		}
 
 		if (status & OMAP_MMC_STAT_DATA_TOUT) {
-			dev_dbg(mmc_dev(host->mmc), "data timeout\n");
+			dev_dbg(mmc_dev(host->mmc), "data timeout (CMD%d)\n",
+				cmd);
 			if (host->data) {
 				host->data->error |= MMC_ERR_TIMEOUT;
 				transfer_error = 1;
@@ -618,17 +626,19 @@ static irqreturn_t mmc_omap_irq(int irq,
 		if (status & OMAP_MMC_STAT_CMD_TOUT) {
 			/* Timeouts are routine with some commands */
 			if (host->cmd) {
+				struct mmc_omap_slot *slot =
+					host->current_slot;
 				if (host->cmd->opcode != MMC_ALL_SEND_CID &&
-						host->cmd->opcode !=
-						MMC_SEND_OP_COND &&
-						host->cmd->opcode !=
-						MMC_APP_CMD &&
-						!mmc_omap_cover_is_open(host))
+				    host->cmd->opcode != MMC_SEND_OP_COND &&
+				    host->cmd->opcode != MMC_APP_CMD &&
+				    (slot == NULL ||
+				     !mmc_omap_cover_is_open(slot)))
 					dev_err(mmc_dev(host->mmc),
-						"command timeout, CMD %d\n",
-						host->cmd->opcode);
+						"command timeout (CMD%d)\n",
+						cmd);
 				host->cmd->error = MMC_ERR_TIMEOUT;
 				end_command = 1;
+				cmd_error = 1;
 			}
 		}
 
@@ -636,9 +646,10 @@ static irqreturn_t mmc_omap_irq(int irq,
 			if (host->cmd) {
 				dev_err(mmc_dev(host->mmc),
 					"command CRC error (CMD%d, arg 0x%08x)\n",
-					host->cmd->opcode, host->cmd->arg);
+					cmd, host->cmd->arg);
 				host->cmd->error = MMC_ERR_BADCRC;
 				end_command = 1;
+				cmd_error = 1;
 			} else
 				dev_err(mmc_dev(host->mmc),
 					"command CRC error without cmd?\n");
@@ -647,13 +658,13 @@ static irqreturn_t mmc_omap_irq(int irq,
 		if (status & OMAP_MMC_STAT_CARD_ERR) {
 			dev_dbg(mmc_dev(host->mmc),
 				"ignoring card status error (CMD%d)\n",
-				host->cmd->opcode);
+				cmd);
 			end_command = 1;
 		}
 
 		/*
 		 * NOTE: On 1610 the END_OF_CMD may come too early when
-		 * starting a write 
+		 * starting a write
 		 */
 		if ((status & OMAP_MMC_STAT_END_OF_CMD) &&
 		    (!(status & OMAP_MMC_STAT_A_EMPTY))) {
@@ -661,13 +672,14 @@ static irqreturn_t mmc_omap_irq(int irq,
 		}
 	}
 
-	if (end_command) {
+	if (end_command)
 		mmc_omap_cmd_done(host, host->cmd);
+	if (host->data != NULL) {
+		if (transfer_error)
+			mmc_omap_xfer_done(host, host->data);
+		else if (end_transfer)
+			mmc_omap_end_of_data(host, host->data);
 	}
-	if (transfer_error)
-		mmc_omap_xfer_done(host, host->data);
-	else if (end_transfer)
-		mmc_omap_end_of_data(host, host->data);
 
 	return IRQ_HANDLED;
 }

--------------000307000303050706040901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000307000303050706040901--
