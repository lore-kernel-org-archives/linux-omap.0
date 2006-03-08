From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [patch 5/5] MMC OMAP DBG CLEANUP
Date: Wed, 8 Mar 2006 10:27:39 +0200
Message-ID: <20060308102739.b3e2958d.Hiroshi.DOYU@nokia.com>
References: <20060307171122.002855000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060307171122.002855000@localhost.localdomain>
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

convert DBG() to pr_debug

 drivers/mmc/omap.c |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)

Index: linux-omap/drivers/mmc/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/omap.c	2006-03-07 18:20:20.000000000 +0200
+++ linux-omap/drivers/mmc/omap.c	2006-03-07 18:22:37.000000000 +0200
@@ -12,12 +12,6 @@
  */
 
 #include <linux/config.h>
-
-// #define CONFIG_MMC_DEBUG
-#ifdef CONFIG_MMC_DEBUG
-#define DEBUG	/* for dev_dbg(), pr_debug(), etc */
-#endif
-
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -50,13 +44,6 @@
 
 #define DRIVER_NAME "mmci-omap"
 
-#ifdef CONFIG_MMC_DEBUG
-#define DBG(x...)	pr_debug(x)
-//#define DBG(x...)	printk(x)
-#else
-#define DBG(x...)	do { } while (0)
-#endif
-
 /* Specifies how often in millisecs to poll for card status changes
  * when the cover switch is open */
 #define OMAP_MMC_SWITCH_POLL_DELAY	500
@@ -342,7 +329,7 @@
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
 
-	DBG("MMC%d: Freeing DMA channel %d\n", host->id, host->dma_ch);
+	pr_debug("MMC%d: Freeing DMA channel %d\n", host->id, host->dma_ch);
 	BUG_ON(host->dma_ch < 0);
 	omap_free_dma(host->dma_ch);
 	host->dma_ch = -1;
@@ -384,7 +371,7 @@
 		cmd->resp[0] =
 			OMAP_MMC_READ(host->base, RSP6) |
 			(OMAP_MMC_READ(host->base, RSP7) << 16);
-		DBG("MMC%d: Response %08x %08x %08x %08x\n", host->id,
+		pr_debug("MMC%d: Response %08x %08x %08x %08x\n", host->id,
 		    cmd->resp[0], cmd->resp[1],
 		    cmd->resp[2], cmd->resp[3]);
 	} else {
@@ -392,7 +379,7 @@
 		cmd->resp[0] =
 			OMAP_MMC_READ(host->base, RSP6) |
 			(OMAP_MMC_READ(host->base, RSP7) << 16);
-		DBG("MMC%d: Response %08x\n", host->id, cmd->resp[0]);
+		pr_debug("MMC%d: Response %08x\n", host->id, cmd->resp[0]);
 		if (card_ready) {
 			pr_debug("MMC%d: Faking card ready based on EOFB\n", host->id);
 			cmd->resp[0] |= R1_READY_FOR_DATA;
@@ -400,7 +387,7 @@
 	}
 
 	if (host->data == NULL || cmd->error != MMC_ERR_NONE) {
-		DBG("MMC%d: End request, err %x\n", host->id, cmd->error);
+		pr_debug("MMC%d: End request, err %x\n", host->id, cmd->error);
 		if (host->data != NULL)
 			del_timer_sync(&host->xfer_timer);
  		host->mrq = NULL;
@@ -587,7 +574,7 @@
 			/* OCR Busy ... happens a lot */
 			if (host->cmd && host->cmd->opcode != MMC_SEND_OP_COND
 				&& host->cmd->opcode != MMC_SET_RELATIVE_ADDR) {
-				DBG("MMC%d: OCR busy error, CMD%d\n",
+				pr_debug("MMC%d: OCR busy error, CMD%d\n",
 				       host->id, host->cmd->opcode);
 			}
 		}
@@ -656,7 +643,7 @@
 	int cover_open, detect_now;
 
 	cover_open = mmc_omap_cover_is_open(host);
-	DBG("MMC%d cover is now %s\n", host->id,
+	pr_debug("MMC%d cover is now %s\n", host->id,
 	    cover_open ? "open" : "closed");
 	set_irq_type(OMAP_GPIO_IRQ(host->switch_pin), 0);
 	detect_now = 0;
@@ -705,7 +692,7 @@
 	} else {
 		/* Assume card detect connected to cover switch */
 		host->switch_last_state = (mmc_mask & 0x2) ? 1 : 0;
-		DBG("MMC%d cover is now %s\n", host->id,
+		pr_debug("MMC%d cover is now %s\n", host->id,
 		    host->switch_last_state ? "open" : "closed");
 	}
 
@@ -726,7 +713,7 @@
 		kobject_uevent(&host->dev->kobj, KOBJ_CHANGE);
 		host->switch_last_state = cover_open;
 	}
-	DBG("MMC cover switch handler started\n");
+	pr_debug("MMC cover switch handler started\n");
 
 	host->slot = 0;
 	do {
@@ -738,7 +725,7 @@
 		if (mmc_card_present(card))
 			cards++;
 	}
-	DBG("MMC%d: %d card(s) present\n", host->id, cards);
+	pr_debug("MMC%d: %d card(s) present\n", host->id, cards);
 	if (cover_open) {
 		if (!complained) {
 			printk(KERN_INFO "MMC%d: cover is open\n", host->id);
@@ -1169,7 +1156,7 @@
 	int dsor;
 	int realclock, i;
 
-	DBG("MMC%d: set_ios: clock %dHz busmode %d powermode %d Vdd %d.%02d\n",
+	pr_debug("MMC%d: set_ios: clock %dHz busmode %d powermode %d Vdd %d.%02d\n",
 	    host->id, ios->clock, ios->bus_mode, ios->power_mode,
 	    ios->vdd / 100, ios->vdd % 100);
 

--

		Hiroshi DOYU
