From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [patch 3/5] SD MULTIPLE SUPPORT
Date: Wed, 8 Mar 2006 10:27:27 +0200
Message-ID: <20060308102727.64b24649.Hiroshi.DOYU@nokia.com>
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

SD seems to use different RCA assignment mechanism from MMC.
This introduces RCA bitmap to manage RCA number and assign
adequate RCA number to SD cards.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

 drivers/mmc/mmc.c        |   83 ++++++++++++++++++++++++++---------------------
 include/linux/mmc/card.h |    2 -
 2 files changed, 47 insertions(+), 38 deletions(-)

Index: linux-omap/drivers/mmc/mmc.c
===================================================================
--- linux-omap.orig/drivers/mmc/mmc.c	2006-03-07 18:19:58.000000000 +0200
+++ linux-omap/drivers/mmc/mmc.c	2006-03-07 18:20:13.000000000 +0200
@@ -635,13 +635,12 @@
 }
 
 /*
- * Allocate a new MMC card, and assign a unique RCA.
+ * Allocate a new MMC card
  */
 static struct mmc_card *
-mmc_alloc_card(struct mmc_host *host, u32 *raw_cid, unsigned int *frca)
+mmc_alloc_card(struct mmc_host *host, u32 *raw_cid)
 {
-	struct mmc_card *card, *c;
-	unsigned int rca = *frca;
+	struct mmc_card *card;
 
 	card = kmalloc(sizeof(struct mmc_card), GFP_KERNEL);
 	if (!card)
@@ -650,17 +649,6 @@
 	mmc_init_card(card, host);
 	memcpy(card->raw_cid, raw_cid, sizeof(card->raw_cid));
 
- again:
-	list_for_each_entry(c, &host->cards, node)
-		if (c->rca == rca) {
-			rca++;
-			goto again;
-		}
-
-	card->rca = rca;
-
-	*frca = rca;
-
 	return card;
 }
 
@@ -796,10 +784,22 @@
  * Create a mmc_card entry for each discovered card, assigning
  * it an RCA, and save the raw CID for decoding later.
  */
-static void mmc_discover_cards(struct mmc_host *host)
+static int mmc_discover_cards(struct mmc_host *host)
 {
 	struct mmc_card *card;
-	unsigned int first_rca = 1, err;
+	unsigned int err;
+	unsigned long *rca_bitmap;
+	const unsigned int nbits = (1 << (sizeof(card->rca)*8))/8;
+
+	rca_bitmap = kzalloc(nbits, GFP_KERNEL);
+	if (!rca_bitmap)
+		return -ENOMEM;
+
+	set_bit(0, rca_bitmap); /* rca:0 reserved for deselect */
+
+	/* make bitmap for rca availability */
+	list_for_each_entry(card, &host->cards, node)
+		set_bit(card->rca, rca_bitmap);
 
 	while (1) {
 		struct mmc_command cmd;
@@ -821,7 +821,7 @@
 
 		card = mmc_find_card(host, cmd.resp);
 		if (!card) {
-			card = mmc_alloc_card(host, cmd.resp, &first_rca);
+			card = mmc_alloc_card(host, cmd.resp);
 			if (IS_ERR(card)) {
 				err = PTR_ERR(card);
 				break;
@@ -834,27 +834,31 @@
 		if (host->mode == MMC_MODE_SD) {
 			mmc_card_set_sd(card);
 
-			cmd.opcode = SD_SEND_RELATIVE_ADDR;
-			cmd.arg = 0;
-			cmd.flags = MMC_RSP_R6 | MMC_CMD_BCR;
-
-			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
-			if (err != MMC_ERR_NONE)
-				mmc_card_set_dead(card);
-			else {
-				card->rca = cmd.resp[0] >> 16;
-
-				if (!host->ops->get_ro) {
-					printk(KERN_WARNING "%s: host does not "
-						"support reading read-only "
-						"switch. assuming write-enable.\n",
-						mmc_hostname(host));
-				} else {
-					if (host->ops->get_ro(host))
-						mmc_card_set_readonly(card);
+			do {
+				cmd.opcode = SD_SEND_RELATIVE_ADDR;
+				cmd.arg = 0;
+				cmd.flags = MMC_RSP_R6 | MMC_CMD_BCR;
+
+				err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
+				if (err != MMC_ERR_NONE)
+					mmc_card_set_dead(card);
+				else {
+					card->rca = cmd.resp[0] >> 16;
+
+					if (!host->ops->get_ro) {
+						printk(KERN_WARNING "%s: host does not "
+						       "support reading read-only "
+						       "switch. assuming write-enable.\n",
+						       mmc_hostname(host));
+					} else {
+						if (host->ops->get_ro(host))
+							mmc_card_set_readonly(card);
+					}
 				}
-			}
+			} while (test_bit(card->rca, rca_bitmap));
 		} else {
+			card->rca = find_first_zero_bit(rca_bitmap, nbits);
+
 			cmd.opcode = MMC_SET_RELATIVE_ADDR;
 			cmd.arg = card->rca << 16;
 			cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
@@ -863,7 +867,12 @@
 			if (err != MMC_ERR_NONE)
 				mmc_card_set_dead(card);
 		}
+
+		set_bit(card->rca, rca_bitmap);
 	}
+
+	kfree(rca_bitmap);
+	return 0;
 }
 
 static void mmc_read_csds(struct mmc_host *host)
Index: linux-omap/include/linux/mmc/card.h
===================================================================
--- linux-omap.orig/include/linux/mmc/card.h	2006-03-07 18:19:34.000000000 +0200
+++ linux-omap/include/linux/mmc/card.h	2006-03-07 18:20:13.000000000 +0200
@@ -54,7 +54,7 @@
 	struct list_head	node;		/* node in hosts devices list */
 	struct mmc_host		*host;		/* the host this device belongs to */
 	struct device		dev;		/* the device */
-	unsigned int		rca;		/* relative card address of device */
+	unsigned short		rca;		/* relative card address of device */
 	unsigned int		state;		/* (our) card state */
 #define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
 #define MMC_STATE_DEAD		(1<<1)		/* device no longer in stack */

--

		Hiroshi DOYU
