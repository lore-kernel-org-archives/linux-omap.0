From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: [patch 3/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
Date: Fri, 17 Nov 2006 09:03:24 -0400
Message-ID: <455DB31C.40907@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060201040806020203040807"
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
To: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Pierre Ossman <drzeus-list@drzeus.cx>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201040806020203040807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Implement card lock/unlock operation, using the MMC_LOCK_UNLOCK command.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/mmc.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.c	2006-11-16 14:35:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.c	2006-11-16 14:59:38.000000000 -0400
@@ -4,6 +4,8 @@
   *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
   *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
   *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
+ *  MMC password protection (C) 2006 Instituto Nokia de Tecnologia (INdT),
+ *     All Rights Reserved.
   *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License version 2 as
@@ -19,6 +21,7 @@
  #include <linux/err.h>
  #include <asm/scatterlist.h>
  #include <linux/scatterlist.h>
+#include <linux/key.h>

  #include <linux/mmc/card.h>
  #include <linux/mmc/host.h>
@@ -101,7 +104,7 @@ mmc_start_request(struct mmc_host *host,
  	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
  		 mmc_hostname(host), mrq->cmd->opcode,
  		 mrq->cmd->arg, mrq->cmd->flags);
-
+	
  	WARN_ON(host->card_busy == NULL);

  	mrq->cmd->error = 0;
@@ -1159,6 +1162,130 @@ static void mmc_setup(struct mmc_host *h
  		mmc_read_scrs(host);
  }

+/**
+ *	mmc_lock_unlock - send LOCK_UNLOCK command to a specific card.
+ *	@card: card to which the LOCK_UNLOCK command should be sent
+ *	@key: key containing the MMC password
+ *	@mode: LOCK_UNLOCK mode
+ *
+ */
+int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode)
+{
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+	struct scatterlist sg;
+	struct mmc_key_payload *mpayload;
+	unsigned long erase_timeout;
+	int err, data_size;
+	u8 *data_buf;
+
+	mpayload = NULL;
+	data_size = 1;
+	if (mode != MMC_LOCK_MODE_ERASE) {
+		mpayload = rcu_dereference(key->payload.data);
+		data_size = 2 + mpayload->datalen;
+	}
+
+	data_buf = kmalloc(data_size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+	memset(data_buf, 0, data_size);
+
+	data_buf[0] = mode;
+	if (mode != MMC_LOCK_MODE_ERASE) {
+		data_buf[1] = mpayload->datalen;
+		memcpy(data_buf + 2, mpayload->data, mpayload->datalen);
+	}
+
+	err = mmc_card_claim_host(card);
+	if (err != MMC_ERR_NONE) {
+		goto out;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = data_size;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, CMD_RETRIES);
+	if (err != MMC_ERR_NONE) {
+		goto error;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_LOCK_UNLOCK;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1B | MMC_CMD_ADTC;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mmc_set_data_timeout(&data, card, 1);
+
+	//data.blksz_bits = blksz_bits(data_size);
+	data.blksz = data_size;
+	data.blocks = 1;
+	data.flags = MMC_DATA_WRITE;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	sg_init_one(&sg, data_buf, data_size);
+	err = mmc_wait_for_req(card->host, &mrq);
+	if (err != MMC_ERR_NONE) {
+		goto error;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	/* set timeout for forced erase operation to 3 min. (see MMC spec) */
+	erase_timeout = jiffies + 180 * HZ;
+	do {
+		/* we cannot use "retries" here because the
+		 * R1_LOCK_UNLOCK_FAILED bit is cleared by subsequent reads to
+		 * the status register, hiding the error condition */
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (err != MMC_ERR_NONE)
+			break;
+		/* the other modes don't need timeout checking */
+		if (mode != MMC_LOCK_MODE_ERASE)
+			continue;
+		if (time_after(jiffies, erase_timeout)) {
+			dev_dbg(&card->dev, "forced erase timed out\n");
+			err = MMC_ERR_TIMEOUT;
+			break;
+		}
+	} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
+	if (cmd.resp[0] & R1_LOCK_UNLOCK_FAILED) {
+		dev_dbg(&card->dev, "LOCK_UNLOCK operation failed\n");
+		err = MMC_ERR_FAILED;
+	}
+
+	if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+		mmc_card_set_locked(card);
+	else
+		mmc_card_clear_locked(card);
+
+error:
+	mmc_deselect_cards(card->host);
+	mmc_card_release_host(card);
+out:
+	kfree(data_buf);
+
+	return err;
+}
+
+//EXPORT_SYMBOL(mmc_lock_unlock);
+

  /**
   *	mmc_detect_change - process change of state on a MMC socket
Index: linux-omap-2.6.git/drivers/mmc/mmc.h
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.h	2006-11-16 14:35:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.h	2006-11-16 14:35:51.000000000 -0400
@@ -27,6 +27,10 @@ struct mmc_key_payload {
  	char		data[0];	/* actual data */
  };

+struct key;
+
+extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
+
  int mmc_schedule_work(struct work_struct *work);
  int mmc_schedule_delayed_work(struct work_struct *work, unsigned long delay);
  void mmc_flush_scheduled_work(void);
Index: linux-omap-2.6.git/include/linux/mmc/protocol.h
===================================================================
--- linux-omap-2.6.git.orig/include/linux/mmc/protocol.h	2006-11-16 13:45:59.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/protocol.h	2006-11-16 14:35:51.000000000 -0400
@@ -244,5 +244,13 @@ struct _mmc_csd {
  #define SD_BUS_WIDTH_1      0
  #define SD_BUS_WIDTH_4      2

+/*
+ * MMC_LOCK_UNLOCK modes
+ */
+#define MMC_LOCK_MODE_ERASE	(1<<3)
+#define MMC_LOCK_MODE_UNLOCK	(0<<2)
+#define MMC_LOCK_MODE_CLR_PWD	(1<<1)
+#define MMC_LOCK_MODE_SET_PWD	(1<<0)
+
  #endif  /* MMC_MMC_PROTOCOL_H */

--------------060201040806020203040807
Content-Type: text/x-patch;
 name="mmc_lock_unlock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc_lock_unlock.diff"

Implement card lock/unlock operation, using the MMC_LOCK_UNLOCK command.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
Signed-off-by: Anderson Lizardo <anderson.lizardo <at> indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>

Index: linux-omap-2.6.git/drivers/mmc/mmc.c
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.c	2006-11-16 14:35:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.c	2006-11-16 14:59:38.000000000 -0400
@@ -4,6 +4,8 @@
  *  Copyright (C) 2003-2004 Russell King, All Rights Reserved.
  *  SD support Copyright (C) 2004 Ian Molton, All Rights Reserved.
  *  SD support Copyright (C) 2005 Pierre Ossman, All Rights Reserved.
+ *  MMC password protection (C) 2006 Instituto Nokia de Tecnologia (INdT),
+ *     All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -19,6 +21,7 @@
 #include <linux/err.h>
 #include <asm/scatterlist.h>
 #include <linux/scatterlist.h>
+#include <linux/key.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -101,7 +104,7 @@ mmc_start_request(struct mmc_host *host,
 	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
 		 mmc_hostname(host), mrq->cmd->opcode,
 		 mrq->cmd->arg, mrq->cmd->flags);
-
+	
 	WARN_ON(host->card_busy == NULL);
 
 	mrq->cmd->error = 0;
@@ -1159,6 +1162,130 @@ static void mmc_setup(struct mmc_host *h
 		mmc_read_scrs(host);
 }
 
+/**
+ *	mmc_lock_unlock - send LOCK_UNLOCK command to a specific card.
+ *	@card: card to which the LOCK_UNLOCK command should be sent
+ *	@key: key containing the MMC password
+ *	@mode: LOCK_UNLOCK mode
+ *
+ */
+int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode)
+{
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_data data;
+	struct scatterlist sg;
+	struct mmc_key_payload *mpayload;
+	unsigned long erase_timeout;
+	int err, data_size;
+	u8 *data_buf;
+
+	mpayload = NULL;
+	data_size = 1;
+	if (mode != MMC_LOCK_MODE_ERASE) {
+		mpayload = rcu_dereference(key->payload.data);
+		data_size = 2 + mpayload->datalen;
+	}
+
+	data_buf = kmalloc(data_size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+	memset(data_buf, 0, data_size);
+
+	data_buf[0] = mode;
+	if (mode != MMC_LOCK_MODE_ERASE) {
+		data_buf[1] = mpayload->datalen;
+		memcpy(data_buf + 2, mpayload->data, mpayload->datalen);
+	}
+
+	err = mmc_card_claim_host(card);
+	if (err != MMC_ERR_NONE) {
+		goto out;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = data_size;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, CMD_RETRIES);
+	if (err != MMC_ERR_NONE) {
+		goto error;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_LOCK_UNLOCK;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1B | MMC_CMD_ADTC;
+
+	memset(&data, 0, sizeof(struct mmc_data));
+
+	mmc_set_data_timeout(&data, card, 1);
+
+	//data.blksz_bits = blksz_bits(data_size);
+	data.blksz = data_size;
+	data.blocks = 1;
+	data.flags = MMC_DATA_WRITE;
+	data.sg = &sg;
+	data.sg_len = 1;
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+
+	sg_init_one(&sg, data_buf, data_size);
+	err = mmc_wait_for_req(card->host, &mrq);
+	if (err != MMC_ERR_NONE) {
+		goto error;
+	}
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	/* set timeout for forced erase operation to 3 min. (see MMC spec) */
+	erase_timeout = jiffies + 180 * HZ;
+	do {
+		/* we cannot use "retries" here because the
+		 * R1_LOCK_UNLOCK_FAILED bit is cleared by subsequent reads to
+		 * the status register, hiding the error condition */
+		err = mmc_wait_for_cmd(card->host, &cmd, 0);
+		if (err != MMC_ERR_NONE)
+			break;
+		/* the other modes don't need timeout checking */
+		if (mode != MMC_LOCK_MODE_ERASE)
+			continue;
+		if (time_after(jiffies, erase_timeout)) {
+			dev_dbg(&card->dev, "forced erase timed out\n");
+			err = MMC_ERR_TIMEOUT;
+			break;
+		}
+	} while (!(cmd.resp[0] & R1_READY_FOR_DATA));
+	if (cmd.resp[0] & R1_LOCK_UNLOCK_FAILED) {
+		dev_dbg(&card->dev, "LOCK_UNLOCK operation failed\n");
+		err = MMC_ERR_FAILED;
+	}
+
+	if (cmd.resp[0] & R1_CARD_IS_LOCKED)
+		mmc_card_set_locked(card);
+	else
+		mmc_card_clear_locked(card);
+
+error:
+	mmc_deselect_cards(card->host);
+	mmc_card_release_host(card);
+out:
+	kfree(data_buf);
+
+	return err;
+}
+
+//EXPORT_SYMBOL(mmc_lock_unlock);
+
 
 /**
  *	mmc_detect_change - process change of state on a MMC socket
Index: linux-omap-2.6.git/drivers/mmc/mmc.h
===================================================================
--- linux-omap-2.6.git.orig/drivers/mmc/mmc.h	2006-11-16 14:35:51.000000000 -0400
+++ linux-omap-2.6.git/drivers/mmc/mmc.h	2006-11-16 14:35:51.000000000 -0400
@@ -27,6 +27,10 @@ struct mmc_key_payload {
 	char		data[0];	/* actual data */
 };
 
+struct key;
+
+extern int mmc_lock_unlock(struct mmc_card *card, struct key *key, int mode);
+
 int mmc_schedule_work(struct work_struct *work);
 int mmc_schedule_delayed_work(struct work_struct *work, unsigned long delay);
 void mmc_flush_scheduled_work(void);
Index: linux-omap-2.6.git/include/linux/mmc/protocol.h
===================================================================
--- linux-omap-2.6.git.orig/include/linux/mmc/protocol.h	2006-11-16 13:45:59.000000000 -0400
+++ linux-omap-2.6.git/include/linux/mmc/protocol.h	2006-11-16 14:35:51.000000000 -0400
@@ -244,5 +244,13 @@ struct _mmc_csd {
 #define SD_BUS_WIDTH_1      0
 #define SD_BUS_WIDTH_4      2
 
+/*
+ * MMC_LOCK_UNLOCK modes
+ */
+#define MMC_LOCK_MODE_ERASE	(1<<3)
+#define MMC_LOCK_MODE_UNLOCK	(0<<2)
+#define MMC_LOCK_MODE_CLR_PWD	(1<<1)
+#define MMC_LOCK_MODE_SET_PWD	(1<<0)
+
 #endif  /* MMC_MMC_PROTOCOL_H */
 

--------------060201040806020203040807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060201040806020203040807--
