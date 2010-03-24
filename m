From: Laurent Epinat <laurent.epinat@cioinfoindus.fr>
Subject: Re: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
Date: Wed, 24 Mar 2010 16:52:53 +0100
Message-ID: <4BAA3555.80403@cioinfoindus.fr>
References: <20100322212025.GW11448@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F127117@dbde02.ent.ti.com>
	<20100323152709.GD11448@atomide.com> <4BA94564.8030803@ti.com>
	<000201cacb67$9849e4d0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <000201cacb67$9849e4d0$544ff780@am.dhcp.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Nishanth Menon' <nm@ti.com>, "'Pandita, Vikram'" <vikram.pandita@ti.com>, "'Pais, Allen'" <allen.pais@ti.com>, 'Tony Lindgren' <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello all

I've juste finished a modification about a multi eMMC on own platform.
we used 4 eMMC of 32Gib (micron MTFC32GHKD) on same host (MMC1) and we used=
 it like de big device (128Gib)

I had a similar problem (It was the pbias 1 configuration)

I can't test the effect on SD card
any comments...



diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 3f2a912..6054441 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -32,6 +32,19 @@ config MMC_BLOCK_BOUNCE

  	  If unsure, say Y here.

+config MULTI_MMC_AS_ONE
+	bool "Simulate multi mmc card as one big"
+	depends on MMC_BLOCK && MULTI_MMC_ON_HOST
+	default y
+	help
+	  A multiple SD/MMC card can be connected on a single host controller.
+	  with this you can see a large device.
+
+	  Say N here if you want to see as multiple storage devices
+
+	  If unsure, say N here.
+
+
  config SDIO_UART
  	tristate "SDIO UART/GPS class support"
  	help
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1f552c6..a368ecb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -16,6 +16,12 @@
   *
   * Author:  Andrew Christian
   *          28 May 2002
+ *
+ * 20100315	=

+ *          Laurent Epinat <laurent.epinat@cioinfoindus.fr>
+ * Add multi "card" on one controller
+ * seen as multi card or as one big card
+ *
   */
  #include <linux/moduleparam.h>
  #include <linux/module.h>
@@ -41,6 +47,10 @@

  #include "queue.h"

+#ifdef CONFIG_MULTI_MMC_ON_HOST
+#include "../core/mmc_ops.h"
+#endif
+
  MODULE_ALIAS("mmc:block");

  /*
@@ -248,6 +258,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, stru=
ct request *req)
  	struct mmc_blk_request brq;
  	int ret =3D 1, disable_multi =3D 0;

+#ifdef CONFIG_MULTI_MMC_ON_HOST
+static struct mmc_card *card_cur=3DNULL;
+int card_size;
+#ifdef CONFIG_MULTI_MMC_AS_ONE
+	int idx;
+#endif
+#endif
  	mmc_claim_host(card->host);

  	do {
@@ -261,6 +278,17 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, stru=
ct request *req)
  		brq.cmd.arg =3D blk_rq_pos(req);
  		if (!mmc_card_blockaddr(card))
  			brq.cmd.arg <<=3D 9;
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+		else {
+			/* All cards as a seem size */
+			/* TODO: check for card <2Gb (ext_csd is 0 );and
+			 * calculation for a size different
+			 **/
+			BUG_ON(!card->ext_csd.sectors);
+			card_size =3D card->ext_csd.sectors;
+		}
+#endif
+			=

  		brq.cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
  		brq.data.blksz =3D 512;
  		brq.stop.opcode =3D MMC_STOP_TRANSMISSION;
@@ -273,9 +301,39 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, stru=
ct request *req)
  		 * restrictions, so we need to be prepared for too big
  		 * requests.
  		 */
-		if (brq.data.blocks > card->host->max_blk_count)
+		if (brq.data.blocks > card->host->max_blk_count)
  			brq.data.blocks =3D card->host->max_blk_count;

+#ifdef CONFIG_MULTI_MMC_ON_HOST
+#ifdef CONFIG_MULTI_MMC_AS_ONE
+		idx =3D (brq.cmd.arg/card_size);
+		/* Force to select a new card if necessary */
+		if (card !=3D card->host->cards[idx]) {
+			card =3D card->host->cards[idx];
+			card_size =3D card->ext_csd.sectors;
+			brq.cmd.arg -=3D idx * card_size;
+		}
+		/*
+		 * Check if the block can go the selected card
+		 * if not truc it
+		 */
+		if (brq.cmd.arg + brq.data.blocks >  card_size) {
+			brq.data.blocks =3D card_size - brq.cmd.arg;
+		}
+#endif /* CONFIG_MULTI_MMC_AS_ONE */
+
+		/* Change the current mmc on bus if needed */
+		if (card !=3D card_cur){
+			if (!mmc_select_card(card)) {
+				card_cur=3Dcard;
+			}
+			else {
+				printk(KERN_ERR "%s: error: Can't select Card %d\n",
+								req->rq_disk->disk_name, card->rca);
+			}
+		}
+#endif /* CONFIG_MULTI_MMC_ON_HOST */
+
  		/*
  		 * After a read error, we redo the request one sector at a time
  		 * in order to accurately determine which sectors can be read
@@ -481,6 +539,12 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_c=
ard *card)
  	struct mmc_blk_data *md;
  	int devidx, ret;

+#ifdef CONFIG_MULTI_MMC_AS_ONE
+	struct mmc_host *host =3D card->host;
+	int i;
+	int sec_num;
+#endif
+
  	devidx =3D find_first_zero_bit(dev_use, MMC_NUM_MINORS);
  	if (devidx >=3D MMC_NUM_MINORS)
  		return ERR_PTR(-ENOSPC);
@@ -492,7 +556,6 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_ca=
rd *card)
  		goto out;
  	}

-
  	/*
  	 * Set the read-only status based on the supported commands
  	 * and the write protect switch.
@@ -543,15 +606,47 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_=
card *card)
  		 * The EXT_CSD sector count is in number or 512 byte
  		 * sectors.
  		 */
+#ifdef CONFIG_MULTI_MMC_AS_ONE
+		for (i=3D0;i<host->card_detected;++i){
+			sec_num+=3Dhost->cards[i]->ext_csd.sectors;
+		}
+		set_capacity(md->disk, sec_num);
+#else
  		set_capacity(md->disk, card->ext_csd.sectors);
+#endif
  	} else {
  		/*
  		 * The CSD capacity field is in units of read_blkbits.
  		 * set_capacity takes units of 512 bytes.
  		 */
-		set_capacity(md->disk,
-			card->csd.capacity << (card->csd.read_blkbits - 9));
+#ifdef MMC_MULTI_CARD_AS_ONE
+		for (i=3D0; i<host->card_detected; ++i){
+			sec_num +=3D host->cards[i]->csd.capacity <<
+									(host->cards[i]->csd.read_blkbits - 9)
+		}
+		set_capacity(md->disk, sec_num);
+#else
+		set_capacity(md->disk,
+						card->csd.capacity << (card->csd.read_blkbits - 9));
+#endif
  	}
+
+#if defined(CONFIG_MULTI_MMC_ON_HOST)
+{
+	/* deselect cards without waiting for completion */
+	struct mmc_request mrq=3D{0};
+	struct mmc_command cmd=3D{0};
+
+	cmd.opcode =3D MMC_SELECT_CARD;
+	cmd.arg =3D 0; /* deselect cards */
+	cmd.flags =3D MMC_RSP_NONE | MMC_CMD_AC;
+	mrq.cmd =3D &cmd;
+	mrq.cmd->mrq =3D &mrq;
+	=

+	card->host->ops->request(card->host, &mrq);
+}
+#endif
+
  	return md;

   err_putdisk:
diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index bb22ffd..b3c854e 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -16,3 +16,8 @@ config MMC_UNSAFE_RESUME

  	  This option sets a default which can be overridden by the
  	  module parameter "removable=3D0" or "removable=3D1".
+
+config MULTI_MMC_ON_HOST
+	bool "Detect multiple MMC/SD cards one same host controller"
+	help
+	  If you say Y here, the MMC layer scan the bus to discover MMC cards
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index bdb165f..badec96 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -221,7 +222,9 @@ struct mmc_card *mmc_alloc_card(struct mmc_host *host, =
struct device_type *type)
   */
  int mmc_add_card(struct mmc_card *card)
  {
+#ifndef CONFIG_MULTI_MMC_AS_ONE
  	int ret;
+#endif
  	const char *type;

  	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card->host), card->rca);
@@ -255,9 +258,11 @@ int mmc_add_card(struct mmc_card *card)
  			type, card->rca);
  	}

+#ifndef CONFIG_MULTI_MMC_AS_ONE
  	ret =3D device_add(&card->dev);
  	if (ret)
  		return ret;
+#endif

  #ifdef CONFIG_DEBUG_FS
  	mmc_add_card_debugfs(card);
@@ -286,7 +291,9 @@ void mmc_remove_card(struct mmc_card *card)
  			printk(KERN_INFO "%s: card %04x removed\n",
  				mmc_hostname(card->host), card->rca);
  		}
+#ifndef CONFIG_MULTI_MMC_AS_ONE
  		device_del(&card->dev);
+#endif
  	}

  	put_device(&card->dev);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 30acd52..b186933 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -910,9 +910,9 @@ static void mmc_power_up(struct mmc_host *host)
  	if (host->f_min > 400000) {
  		pr_warning("%s: Minimum clock frequency too high for "
  				"identification mode\n", mmc_hostname(host));
-		host->ios.clock =3D host->f_min;
-	} else
  		host->ios.clock =3D 400000;
+	} else
+		host->ios.clock =3D host->f_min;

  	host->ios.power_mode =3D MMC_POWER_ON;
  	mmc_set_ios(host);
@@ -1164,8 +1164,6 @@ void mmc_stop_host(struct mmc_host *host)
  	}
  	mmc_bus_put(host);

-	BUG_ON(host->card);
-
  	mmc_power_off(host);
  }

@@ -1235,10 +1233,21 @@ EXPORT_SYMBOL(mmc_card_sleep);

  int mmc_card_can_sleep(struct mmc_host *host)
  {
+
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	struct mmc_card *card;
+	int i;
+	for (i=3D0; i<host->card_detected;++i){
+		card =3D host->cards[i];
+		if (card && mmc_card_mmc(card) && card->ext_csd.rev >=3D 3)
+			return 1;
+	}
+#else
  	struct mmc_card *card =3D host->card;

  	if (card && mmc_card_mmc(card) && card->ext_csd.rev >=3D 3)
  		return 1;
+#endif
  	return 0;
  }
  EXPORT_SYMBOL(mmc_card_can_sleep);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0eac6c8..e29d1bd 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -5,6 +5,11 @@
   *  Copyright (C) 2005-2007 Pierre Ossman, All Rights Reserved.
   *  MMCv4 support Copyright (C) 2006 Philip Langdale, All Rights Reserved.
   *
+ * 20100315
+ *          Laurent Epinat <laurent.epinat@cioinfoindus.fr>
+ * Add multi "card" detection on one controller
+ * they can be seen as multi card or as one big card
+ *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License version 2 as
   * published by the Free Software Foundation.
@@ -224,6 +229,11 @@ static int mmc_read_ext_csd(struct mmc_card *card)
  		if (card->ext_csd.sectors)
  			mmc_card_set_blockaddr(card);
  	}
+	else {
+		/* TODO: In MULTI CARD we need the size to select the crad on the bus */
+		WARN_ON(!card->ext_csd.sectors);
+
+	}

  	switch (ext_csd[EXT_CSD_CARD_TYPE]) {
  	case EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
@@ -293,6 +303,261 @@ static struct device_type mmc_type =3D {
  	.groups =3D mmc_attr_groups,
  };

+#ifdef CONFIG_MULTI_MMC_ON_HOST
+/*
+ * Handle the detection and initialisation of a cards.
+ *
+ * In the case of a resume, "rescan" will contain a flag and
+ * we're trying to reinitialise all cards.
+ */
+static int mmc_init_cards(struct mmc_host *host, u32 ocr, int rescan)
+{
+	int i;
+	int high_speed =3D 1;
+	unsigned int ext_csd_bit=3D0, bus_width =3D MMC_BUS_WIDTH_8;
+	struct mmc_card *card=3DNULL;
+	int err;
+	u32 cid[4];
+	unsigned int max_dtr =3D (unsigned int)-1;
+
+	BUG_ON(!host);
+	WARN_ON(!host->claimed);
+
+	BUG_ON(host->card_detected);
+
+	/*
+	 * Since we're changing the OCR value, we seem to
+	 * need to tell some cards to go back to the idle
+	 * state.  We wait 1ms to give cards time to
+	 * respond.
+	 */
+	mmc_go_idle(host);
+
+	/* The extra bit indicates that we support high capacity */
+	err =3D mmc_send_op_cond(host, ocr | (1 << 30), NULL);
+	if (err)
+		goto err;
+
+	/*
+	 * For SPI, enable CRC as appropriate.
+	 */
+	if (mmc_host_is_spi(host)) {
+		err =3D mmc_spi_set_crc(host, use_spi_crc);
+		if (err)
+			goto err;
+	}
+
+	while(host->card_detected < MMC_MAX_CARD) {
+		/*
+		 * Fetch CID from card.
+		 */
+		if (mmc_host_is_spi(host))
+			err =3D mmc_send_cid(host, 0, cid);
+		else
+			err =3D mmc_all_send_cid(host, cid);
+		=

+		if (err) {
+			if (!host->card_detected)
+				goto err;
+			else
+				break;
+		}
+		if (rescan) {
+			card =3D host->cards[host->card_detected];
+			if (memcmp(cid, card->raw_cid, sizeof(cid)) !=3D 0) {
+				err =3D -ENOENT;
+				goto err;
+			}
+		} else {
+			/*
+			 * Allocate card structure.
+			 */
+			card =3D mmc_alloc_card(host, &mmc_type);
+			if (IS_ERR(card)) {
+				err =3D PTR_ERR(card);
+				goto err;
+			}
+
+			card->type =3D MMC_TYPE_MMC;
+			card->rca =3D host->card_detected+1;
+			memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
+			=

+			host->cards[host->card_detected] =3D card;
+		}
+
+		/*
+		 * For native busses:  set card RCA and quit open drain mode.
+		 */
+		if (!mmc_host_is_spi(host)) {
+			err =3D mmc_set_relative_addr(card);
+			if (err)
+				goto free_card;
+		}
+		host->card_detected++;
+	}
+
+	if (host->card_detected >=3D MMC_MAX_CARD) {
+			printk(KERN_ERR "%s: Problem card number detected\n",
+								mmc_hostname(host));
+		goto free_card;
+	}
+		=

+	printk(KERN_INFO "%s: %d cards detected on this controller\n",
+			       mmc_hostname(host), host->card_detected);
+	=

+	/* Set to push pull mode */
+	if (!mmc_host_is_spi(host)) {
+		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
+	}
+
+	for (i=3D0;  !rescan && i < host->card_detected; ++i) {
+		card =3D host->cards[i];
+			/*
+			 * Fetch CSD from card.
+			 */
+			err =3D mmc_send_csd(card, card->raw_csd);
+			if (err)
+				goto free_card;
+
+			err =3D mmc_decode_csd(card);
+			if (err)
+				goto free_card;
+			err =3D mmc_decode_cid(card);
+			if (err)
+				goto free_card;
+	}
+
+	/* Get the EXT CSD for each card */
+	for (i=3D0; i < host->card_detected; ++i) {
+		card =3D host->cards[i];
+
+		/*
+		 * Select card, as all following commands rely on that.
+		 */
+		if (!mmc_host_is_spi(host)) {
+			err =3D mmc_select_card(card);
+			if (err)
+				goto free_card;
+		}
+
+		/*
+		 * Fetch and process extended CSD.
+		 */
+		if (!rescan) {
+			err =3D mmc_read_ext_csd(card);
+			if (err)
+				goto free_card;
+		}
+
+		/* Check if all cards can be switched to high speed mode */
+		if ((card->ext_csd.hs_max_dtr =3D=3D 0) ||
+			!(host->caps & MMC_CAP_MMC_HIGHSPEED))
+		{
+			high_speed =3D 0;
+		}
+
+		/* Check if all cards can be switch to wide bus */
+		if (card->csd.mmca_vsn < CSD_SPEC_VER_4) {
+			bus_width =3D 0;
+		}
+	}
+
+	if (bus_width && (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))=
) {
+		if (host->caps & MMC_CAP_8_BIT_DATA) {
+			ext_csd_bit =3D EXT_CSD_BUS_WIDTH_8;
+			bus_width =3D MMC_BUS_WIDTH_8;
+		} else {
+			ext_csd_bit =3D EXT_CSD_BUS_WIDTH_4;
+			bus_width =3D MMC_BUS_WIDTH_4;
+		}
+	}
+	else {
+		bus_width =3D 0;
+	}
+
+	/* Set the speed en bus width to all cards */
+	for (i=3D0; i < host->card_detected; ++i) {
+		card =3D host->cards[i];
+
+		/*
+		 * Select card, as all following commands rely on that.
+		 */
+		if (!mmc_host_is_spi(host)) {
+			err =3D mmc_select_card(card);
+			if (err)
+				goto free_card;
+		}
+
+		if (high_speed)  {
+			/*
+			 * Activate high speed for all cards
+			 */
+			err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_HS_TIMING, 1);
+			if (err && err !=3D -EBADMSG)
+				goto free_card;
+
+			if (err) {
+				high_speed =3D 0;
+				printk(KERN_WARNING "%s: switch to highspeed failed\n",
+					   mmc_hostname(card->host));
+			}
+			else {
+				mmc_card_set_highspeed(card);
+			}
+		}
+
+		/*
+		 * Activate wide bus (if supported).
+		 */
+		if (bus_width) {
+			err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_BUS_WIDTH, ext_csd_bit);
+
+			if (err) {
+				printk(KERN_WARNING "%s: switch to highspeed failed\n",
+					   mmc_hostname(card->host));
+				bus_width =3D 0;
+			}
+		}
+
+		/*
+		 * Compute bus speed.
+		 * and chose the fastest of slowest cards
+		 */
+		if (mmc_card_highspeed(card)) {
+			if (max_dtr > card->ext_csd.hs_max_dtr)
+				max_dtr =3D card->ext_csd.hs_max_dtr;
+		} else if (max_dtr > card->csd.max_dtr) {
+			if (max_dtr > card->csd.max_dtr)
+				max_dtr =3D card->csd.max_dtr;
+		}
+	}
+
+	if (high_speed) {
+		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+	}
+	if (bus_width)
+		mmc_set_bus_width(card->host, bus_width);
+
+	if (max_dtr !=3D (unsigned int)-1)
+		mmc_set_clock(host, max_dtr);
+
+	mmc_deselect_cards(host);
+	return 0;
+
+free_card:
+	while(!rescan && host->card_detected) {
+		if (host->cards[host->card_detected])
+			mmc_remove_card(host->cards[host->card_detected]);
+		--host->card_detected;
+	}
+err:
+	return err;
+}
+
+#else /* CONFIG_MULTI_MMC_ON_HOST */
+
  /*
   * Handle the detection and initialisation of a card.
   *
@@ -336,7 +601,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
  	 * Fetch CID from card.
  	 */
  	if (mmc_host_is_spi(host))
-		err =3D mmc_send_cid(host, cid);
+		err =3D mmc_send_cid(host, 0, cid);
  	else
  		err =3D mmc_all_send_cid(host, cid);
  	if (err)
@@ -486,17 +751,27 @@ err:

  	return err;
  }
-
+#endif
  /*
   * Host is being removed. Free up the current card.
   */
  static void mmc_remove(struct mmc_host *host)
  {
  	BUG_ON(!host);
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	while (host->card_detected--) {
+		BUG_ON(!host->cards[host->card_detected]);
+		mmc_remove_card(host->cards[host->card_detected]);
+		host->cards[host->card_detected] =3D NULL;
+	}
+
+	=

+#else	=

  	BUG_ON(!host->card);

  	mmc_remove_card(host->card);
  	host->card =3D NULL;
+#endif
  }

  /*
@@ -504,6 +779,8 @@ static void mmc_remove(struct mmc_host *host)
   */
  static void mmc_detect(struct mmc_host *host)
  {
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+#else
  	int err;

  	BUG_ON(!host);
@@ -525,6 +802,7 @@ static void mmc_detect(struct mmc_host *host)
  		mmc_detach_bus(host);
  		mmc_release_host(host);
  	}
+#endif
  }

  /*
@@ -532,7 +810,20 @@ static void mmc_detect(struct mmc_host *host)
   */
  static int mmc_suspend(struct mmc_host *host)
  {
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	int i;
  	BUG_ON(!host);
+	mmc_claim_host(host);
+	if (!mmc_host_is_spi(host))
+		mmc_deselect_cards(host);
+	for (i=3D0; i<host->card_detected;++i){
+		host->cards[i]->state &=3D ~MMC_STATE_HIGHSPEED;
+	}
+	host->card_detected =3D 0;
+	mmc_release_host(host);
+#else
+	BUG_ON(!host);
+
  	BUG_ON(!host->card);

  	mmc_claim_host(host);
@@ -540,7 +831,7 @@ static int mmc_suspend(struct mmc_host *host)
  		mmc_deselect_cards(host);
  	host->card->state &=3D ~MMC_STATE_HIGHSPEED;
  	mmc_release_host(host);
-
+#endif
  	return 0;
  }

@@ -554,26 +845,58 @@ static int mmc_resume(struct mmc_host *host)
  {
  	int err;

+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	BUG_ON(!host);
+	mmc_claim_host(host);
+	err =3D mmc_init_cards(host, host->ocr, 1);
+	mmc_release_host(host);
+#else
  	BUG_ON(!host);
  	BUG_ON(!host->card);

  	mmc_claim_host(host);
  	err =3D mmc_init_card(host, host->ocr, host->card);
  	mmc_release_host(host);
+#endif

  	return err;
  }

  static void mmc_power_restore(struct mmc_host *host)
  {
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	int i;
+	mmc_claim_host(host);
+	for (i=3D0; i<host->card_detected; ++i){
+		host->cards[i]->state &=3D ~MMC_STATE_HIGHSPEED;
+	}
+	host->card_detected =3D 0;
+	mmc_init_cards(host, host->ocr, 1);
+	mmc_release_host(host);
+#else
  	host->card->state &=3D ~MMC_STATE_HIGHSPEED;
  	mmc_claim_host(host);
  	mmc_init_card(host, host->ocr, host->card);
  	mmc_release_host(host);
+#endif
  }

  static int mmc_sleep(struct mmc_host *host)
  {
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	int i;
+	struct mmc_card *card;
+	int err =3D -ENOSYS;
+	for (i=3D0; i<host->card_detected;++i){
+		card =3D host->cards[i];
+		if (card && card->ext_csd.rev >=3D 3) {
+			err =3D mmc_card_sleepawake(card, 1);
+			if (err < 0)
+				pr_debug("%s: Error %d while putting card into sleep",
+					 mmc_hostname(host), err);
+		}
+	}
+#else
  	struct mmc_card *card =3D host->card;
  	int err =3D -ENOSYS;

@@ -583,12 +906,28 @@ static int mmc_sleep(struct mmc_host *host)
  			pr_debug("%s: Error %d while putting card into sleep",
  				 mmc_hostname(host), err);
  	}
+#endif

  	return err;
  }

  static int mmc_awake(struct mmc_host *host)
  {
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	struct mmc_card *card;
+	int err =3D -ENOSYS;
+	int i;
+	for (i=3D0; i<host->card_detected;++i){
+		card =3D host->cards[i];
+
+		if (card && card->ext_csd.rev >=3D 3) {
+			err =3D mmc_card_sleepawake(card, 0);
+			if (err < 0)
+				pr_debug("%s: Error %d while awaking sleeping card",
+					 mmc_hostname(host), err);
+		}
+	}
+#else
  	struct mmc_card *card =3D host->card;
  	int err =3D -ENOSYS;

@@ -598,6 +937,7 @@ static int mmc_awake(struct mmc_host *host)
  			pr_debug("%s: Error %d while awaking sleeping card",
  				 mmc_hostname(host), err);
  	}
+#endif

  	return err;
  }
@@ -639,7 +979,9 @@ static void mmc_attach_bus_ops(struct mmc_host *host)
  int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
  {
  	int err;
-
+#if defined(CONFIG_MULTI_MMC_ON_HOST)
+	int i;
+#endif
  	BUG_ON(!host);
  	WARN_ON(!host->claimed);

@@ -671,10 +1013,31 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
  	 * Can we support the voltage of the card?
  	 */
  	if (!host->ocr) {
+		printk(KERN_ERR "%s: card claims to unsupported voltages\n",
+		       mmc_hostname(host));
  		err =3D -EINVAL;
  		goto err;
  	}

+#ifdef CONFIG_MULTI_MMC_ON_HOST
+	err =3D mmc_init_cards(host, host->ocr, 0);
+	if (err)  {
+		goto remove_card;
+	}
+	mmc_release_host(host);
+
+	for (i=3D0; i < host->card_detected; ++i) {
+		err =3D mmc_add_card(host->cards[i]);
+		if (err)
+			goto remove_card;
+	}
+#ifdef CONFIG_MULTI_MMC_AS_ONE
+	err =3D device_add(&host->cards[0]->dev);
+	if (err)
+		goto remove_device;
+#endif
+
+#else  /* CONFIG_MULTI_MMC_ON_HOST */
  	/*
  	 * Detect and init the card.
  	 */
@@ -687,12 +1050,29 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
  	err =3D mmc_add_card(host->card);
  	if (err)
  		goto remove_card;
+#endif  /* CONFIG_MULTI_MMC_ON_HOST */

  	return 0;
+	=

+#if defined(CONFIG_MULTI_MMC_AS_ONE)
+remove_device:
+	device_del(&host->cards[0]->dev);
+#endif

+#ifdef CONFIG_MULTI_MMC_ON_HOST
+remove_card:
+	while (host->card_detected) {
+		if (host->cards[host->card_detected])
+			mmc_remove_card(host->cards[host->card_detected]);
+		host->cards[host->card_detected] =3D NULL;
+		--host->card_detected;
+	}
+	host->card_detected =3D 0;
+#else
  remove_card:
  	mmc_remove_card(host->card);
  	host->card =3D NULL;
+#endif
  	mmc_claim_host(host);
  err:
  	mmc_detach_bus(host);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d2cb5c6..b894481 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -29,7 +29,6 @@ static int _mmc_select_card(struct mmc_host *host, struct=
 mmc_card *card)
  	memset(&cmd, 0, sizeof(struct mmc_command));

  	cmd.opcode =3D MMC_SELECT_CARD;
-
  	if (card) {
  		cmd.arg =3D card->rca << 16;
  		cmd.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
@@ -51,20 +50,21 @@ int mmc_select_card(struct mmc_card *card)

  	return _mmc_select_card(card->host, card);
  }
+EXPORT_SYMBOL(mmc_select_card);

  int mmc_deselect_cards(struct mmc_host *host)
  {
  	return _mmc_select_card(host, NULL);
  }
+EXPORT_SYMBOL(mmc_deselect_cards);

-int mmc_card_sleepawake(struct mmc_host *host, int sleep)
+int mmc_card_sleepawake(struct mmc_card *card, int sleep)
  {
  	struct mmc_command cmd;
-	struct mmc_card *card =3D host->card;
  	int err;

  	if (sleep)
-		mmc_deselect_cards(host);
+		mmc_deselect_cards(card->host);

  	memset(&cmd, 0, sizeof(struct mmc_command));

@@ -74,7 +74,7 @@ int mmc_card_sleepawake(struct mmc_host *host, int sleep)
  		cmd.arg |=3D 1 << 15;

  	cmd.flags =3D MMC_RSP_R1B | MMC_CMD_AC;
-	err =3D mmc_wait_for_cmd(host, &cmd, 0);
+	err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
  	if (err)
  		return err;

@@ -84,7 +84,7 @@ int mmc_card_sleepawake(struct mmc_host *host, int sleep)
  	 * SEND_STATUS command to poll the status because that command (and most
  	 * others) is invalid while the card sleeps.
  	 */
-	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
+	if (!(card->host->caps & MMC_CAP_WAIT_WHILE_BUSY))
  		mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));

  	if (!sleep)
@@ -325,14 +325,15 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
  	return 0;
  }

-int mmc_send_cid(struct mmc_host *host, u32 *cid)
+int mmc_send_cid(struct mmc_host *host, unsigned int rca, u32 *cid)
  {
  	int ret, i;

+	if (!host)
+		return -EINVAL;
+
  	if (!mmc_host_is_spi(host)) {
-		if (!host->card)
-			return -EINVAL;
-		return mmc_send_cxd_native(host, host->card->rca << 16,
+		return mmc_send_cxd_native(host, rca << 16,
  				cid, MMC_SEND_CID);
  	}

diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 653eb8e..d0aee59 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -22,10 +22,10 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd);
  int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
  int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
  int mmc_send_status(struct mmc_card *card, u32 *status);
-int mmc_send_cid(struct mmc_host *host, u32 *cid);
+int mmc_send_cid(struct mmc_host *host, unsigned int rca, u32 *cid);
  int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
  int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
-int mmc_card_sleepawake(struct mmc_host *host, int sleep);
+int mmc_card_sleepawake(struct mmc_card *card, int sleep);

  #endif

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fdd414e..0889de2 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -366,7 +366,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 =
ocr,
  	 * Fetch CID from card.
  	 */
  	if (mmc_host_is_spi(host))
-		err =3D mmc_send_cid(host, cid);
+		err =3D mmc_send_cid(host, 0, cid);
  	else
  		err =3D mmc_all_send_cid(host, cid);
  	if (err)
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 83f0aff..e3ad4cf 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -38,6 +38,12 @@
  #include <plat/mmc.h>
  #include <plat/cpu.h>

+#ifdef CONFIG_MMC_DEBUG
+#define mmc_dbg(fmt, arg...)	printk(KERN_DEBUG fmt, ##arg)
+#else
+#define mmc_dbg(fmt, arg...)
+#endif
+
  /* OMAP HSMMC Host Controller Registers */
  #define OMAP_HSMMC_SYSCONFIG	0x0010
  #define OMAP_HSMMC_SYSSTATUS	0x0014
@@ -56,6 +62,7 @@
  #define OMAP_HSMMC_IE		0x0134
  #define OMAP_HSMMC_ISE		0x0138
  #define OMAP_HSMMC_CAPA		0x0140
+#define OMAP_HSMMC_CUR_CAPA	0x0148

  #define VS18			(1 << 26)
  #define VS30			(1 << 25)
@@ -625,13 +632,13 @@ static int omap_hsmmc_context_restore(struct omap_hsm=
mc_host *host)
  		if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
  			dsor++;

-		if (dsor > 250)
-			dsor =3D 250;
+		if (dsor > 1023) /* Maximum of ratio 0x3FF */
+			dsor =3D 1023;
  	}

  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
  		OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
-	OMAP_HSMMC_WRITE(host->base, SYSCTL, (dsor << 6) | (DTO << 16));
+	OMAP_HSMMC_WRITE(host->base, SYSCTL, (dsor << 6) | (DTO << DTO_SHIFT));
  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
  		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);

@@ -816,6 +823,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, =
struct mmc_command *cmd,

  	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
  	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
+
  }

  static int
@@ -867,6 +875,52 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, str=
uct mmc_data *data)
  	omap_hsmmc_start_command(host, data->stop, NULL);
  }

+#ifdef CONFIG_MMC_DEBUG
+static const char *mmc_report_card_status(u32 status)
+{
+	/* It's the status come from the omap mmc controler */
+	/* --- means reserved bit without definition at documentation */
+	static const char *mmc_status_bits[] =3D {
+		"---", "---", "---", "---", "---", "APP_CMD", "---", "SW_ERROR",
+		"READY_4_DATA",
+		"---", "---", "---", "---", /* mmc_report_card_state */
+		=

+		"ERASE_RST",  "---", "WP_ERASE_SKIP", "CID/CSD_OVR", "---","---",
+		"ERR", "CC_ERR", "CARD_ECC_FAILED", "ILLEGAL_CMD", "COM_CRC_ERR",
+		"(UN)LOCK_FAILED", "CARD_LOCKED", "WP_VIOLATION",
+		"ERASE_PARAM", "ERASE_SEQ_ERR", "BLK_LEN_ERR", "ADDR_MISCALIGN",
+		"ADDR_OUT_OF_RANGE",
+	};
+	static const char *mmc_state_bits[] =3D {
+			"S_IDLE", "S_READY","S_IDENT","S_STBY",
+			"S_TRAN","S_DATA","S_RCV","S_PRG","S_DIS",
+			"S_BTST","S_SLP","---", "---", "---", "---","---"
+	};
+
+	static char res[256];
+	char *buf =3D res;
+	int len, i;
+
+	len =3D sprintf(buf, "CARD status 0x%x :", status);
+	buf +=3D len;
+
+	for (i =3D 0; i < ARRAY_SIZE(mmc_status_bits); i++) {
+		if (i>=3D9 && i<=3D12){
+			if (i=3D=3D9){
+				len =3D sprintf(buf, " %s |", mmc_state_bits[status&0x0F]);
+				buf +=3D len;
+			}
+		}
+		else {
+			if (status & (1 << i)) {
+				len =3D sprintf(buf, " %s |", mmc_status_bits[i]);
+				buf +=3D len;
+			}
+		}
+	}
+	return res;
+}
+#endif /* CONFIG_MMC_DEBUG */
  /*
   * Notify the core about command completion
   */
@@ -882,9 +936,18 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, stru=
ct mmc_command *cmd)
  			cmd->resp[2] =3D OMAP_HSMMC_READ(host->base, RSP32);
  			cmd->resp[1] =3D OMAP_HSMMC_READ(host->base, RSP54);
  			cmd->resp[0] =3D OMAP_HSMMC_READ(host->base, RSP76);
+			mmc_dbg("%s: "
+					"RSP10=3D0x%08x RSP32=3D0x%08x RSP54=3D0x%08x RSP76=3D0x%08x\n",
+					mmc_hostname(host->mmc),
+					cmd->resp[3],cmd->resp[2],cmd->resp[1],cmd->resp[0]);
+		=

  		} else {
  			/* response types 1, 1b, 3, 4, 5, 6 */
  			cmd->resp[0] =3D OMAP_HSMMC_READ(host->base, RSP10);
+			mmc_dbg("%s: RSP10=3D0x%08x %s\n",
+					mmc_hostname(host->mmc),
+					cmd->resp[0],
+					mmc_report_card_status(cmd->resp[0]));
  		}
  	}
  	if ((host->data =3D=3D NULL && !host->response_busy) || cmd->error) {
@@ -914,6 +977,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_ho=
st *host, int errno)
   * Readable error output
   */
  #ifdef CONFIG_MMC_DEBUG
+
  static void omap_hsmmc_report_irq(struct omap_hsmmc_host *host, u32 statu=
s)
  {
  	/* --- means reserved bit without definition at documentation */
@@ -938,6 +1002,7 @@ static void omap_hsmmc_report_irq(struct omap_hsmmc_ho=
st *host, u32 status)

  	dev_dbg(mmc_dev(host->mmc), "%s\n", res);
  }
+
  #endif  /* CONFIG_MMC_DEBUG */

  /*
@@ -1539,13 +1604,13 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
  		if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
  			dsor++;

-		if (dsor > 250)
-			dsor =3D 250;
+		if (dsor > 1023) /* Maximum of ratio 0x3FF */
+			dsor =3D 1023;
  	}
  	omap_hsmmc_stop_clock(host);
  	regval =3D OMAP_HSMMC_READ(host->base, SYSCTL);
  	regval =3D regval & ~(CLKD_MASK);
-	regval =3D regval | (dsor << 6) | (DTO << 16);
+	regval =3D regval | (dsor << 6) | (DTO << DTO_SHIFT);
  	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
  	OMAP_HSMMC_WRITE(host->base, SYSCTL,
  		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
@@ -1921,7 +1986,8 @@ static int omap_hsmmc_regs_show(struct seq_file *s, v=
oid *data)
  			OMAP_HSMMC_READ(host->base, ISE));
  	seq_printf(s, "CAPA:\t\t0x%08x\n",
  			OMAP_HSMMC_READ(host->base, CAPA));
-
+	seq_printf(s, "CUR_CAPA:\t\t0x%08x\n",
+			OMAP_HSMMC_READ(host->base, CUR_CAPA));
  	clk_disable(host->fclk);

  	return 0;
@@ -2132,13 +2198,13 @@ static int __init omap_hsmmc_probe(struct platform_=
device *pdev)
  	ret =3D request_irq(host->irq, omap_hsmmc_irq, IRQF_DISABLED,
  			mmc_hostname(mmc), host);
  	if (ret) {
-		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
+		dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
  		goto err_irq;
  	}

  	if (pdata->init !=3D NULL) {
  		if (pdata->init(&pdev->dev) !=3D 0) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_err(mmc_dev(host->mmc),
  				"Unable to configure MMC IRQs\n");
  			goto err_irq_cd_init;
  		}
@@ -2161,7 +2227,7 @@ static int __init omap_hsmmc_probe(struct platform_de=
vice *pdev)
  					  | IRQF_DISABLED,
  				  mmc_hostname(mmc), host);
  		if (ret) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_err(mmc_dev(host->mmc),
  				"Unable to grab MMC CD IRQ\n");
  			goto err_irq_cd;
  		}
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9ad2295..7996bcc 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -5,6 +5,11 @@
   * Copyright (C) 2008 Nokia Corporation
   * Author: Texas Instruments
   *
+ *
+ * 20100315
+ *          Laurent Epinat <laurent.epinat@cioinfoindus.fr>
+ * Add 	cpu_is_omap34xx() for pbias1  (VMMCa1)
+ *
   * This program is free software; you can redistribute it and/or modify
   * it under the terms of the GNU General Public License version 2 as
   * published by the Free Software Foundation.
@@ -83,14 +88,23 @@ static void hsmmc1_before_set_reg(struct device *dev, i=
nt slot,
  			prog_io =3D omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
  			prog_io |=3D OMAP3630_PRG_SDMMC1_SPEEDCTRL;
  			omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
-		} else {
+		}
+		else if (cpu_is_omap34xx()) {
+			reg &=3D 	~(OMAP343X_PBIASSPEEDCTRL1|OMAP2_PBIASSPEEDCTRL0);
+		}
+		else {
  			reg |=3D OMAP2_PBIASSPEEDCTRL0;
  		}
  		reg &=3D ~OMAP2_PBIASLITEPWRDNZ0;
+		if (cpu_is_omap34xx())
+			reg &=3D ~OMAP343X_PBIASLITEPWRDNZ1;
  		omap_ctrl_writel(reg, control_pbias_offset);
  	} else {
  		reg =3D omap_ctrl_readl(control_pbias_offset);
  		reg &=3D ~OMAP2_PBIASLITEPWRDNZ0;
+		if (cpu_is_omap34xx())
+			reg &=3D ~OMAP343X_PBIASLITEPWRDNZ1;
+
  		omap_ctrl_writel(reg, control_pbias_offset);
  	}
  }
@@ -106,15 +120,29 @@ static void hsmmc1_after_set_reg(struct device *dev, =
int slot,
  	if (power_on) {
  		reg =3D omap_ctrl_readl(control_pbias_offset);
  		reg |=3D (OMAP2_PBIASLITEPWRDNZ0 | OMAP2_PBIASSPEEDCTRL0);
-		if ((1 << vdd) <=3D MMC_VDD_165_195)
+		if (cpu_is_omap34xx()) {
+			reg |=3D 	(OMAP343X_PBIASLITEPWRDNZ1 | OMAP343X_PBIASSPEEDCTRL1);
+		}
+		if ((1 << vdd) <=3D MMC_VDD_165_195) {
  			reg &=3D ~OMAP2_PBIASLITEVMODE0;
-		else
+			if (cpu_is_omap34xx()) {
+				reg &=3D ~OMAP343X_PBIASLITEVMODE1;
+			}
+		}
+		else {
  			reg |=3D OMAP2_PBIASLITEVMODE0;
+			if (cpu_is_omap34xx()) {
+				reg |=3D OMAP343X_PBIASLITEVMODE1;
+			}
+		}
  		omap_ctrl_writel(reg, control_pbias_offset);
  	} else {
  		reg =3D omap_ctrl_readl(control_pbias_offset);
  		reg |=3D (OMAP2_PBIASSPEEDCTRL0 | OMAP2_PBIASLITEPWRDNZ0 |
  			OMAP2_PBIASLITEVMODE0);
+		if (cpu_is_omap34xx())
+			reg |=3D 	(OMAP343X_PBIASSPEEDCTRL1 | OMAP343X_PBIASLITEPWRDNZ1 |
+						OMAP343X_PBIASLITEVMODE1);
  		omap_ctrl_writel(reg, control_pbias_offset);
  	}
  }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index eaf3636..b925265 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -182,7 +182,12 @@ struct mmc_host {
  	unsigned int		disable_delay;	/* disable delay in msecs */
  	struct delayed_work	disable;	/* disabling work */

-	struct mmc_card		*card;		/* device attached to this host */
+#ifdef CONFIG_MULTI_MMC_ON_HOST
+#define MMC_MAX_CARD	64		/* spec ~40 in same host ? */
+	struct mmc_card *cards[MMC_MAX_CARD];/* devices attached to this host */
+	int  card_detected;
+#endif
+	struct mmc_card *card;			/* Keep for compatibility SD, SDIO, ...*/

  	wait_queue_head_t	wq;
  	struct task_struct	*claimer;	/* task that has host claimed */
---



Le 24.03.2010 16:35, Madhusudhan a =E9crit :
>
>
>> -----Original Message-----
>> From: Nishanth Menon [mailto:nm@ti.com]
>> Sent: Tuesday, March 23, 2010 5:49 PM
>> To: Tony Lindgren
>> Cc: Pais, Allen; linux-arm-kernel@lists.infradead.org; linux-
>> omap@vger.kernel.org; Pandita, Vikram; Madhusudhan Chikkature Rajashekar
>> Subject: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
>>
>> Tony Lindgren had written, on 03/23/2010 10:27 AM, the following:
>> [...]
>>> Then at least one issue remains for zoom3 to be usable..
>>> I'm getting tons of MMC errors trying to mount root on it:
>>>
>>> mmcblk1: error -110 transferring data, sector 2097024, nr 8, card status
>> 0x900
>>> end_request: I/O error, dev mmcblk1, sector 2097024
>>> ...
>>>
>> I have seen this on few platforms and seem to be related to eMMC usage.
>>
>>> Any ideas if that's fixed somewhere also?
>> Madhu, any comments?
>>
> Sorry about multiple replies to this mail. Just wanted to avoid top posti=
ng.
>
> The eMMC on Zoom2 has an issue with respect to detection as a high
> capacity card. This was discussed on the list with Pierre sometime back. I
> don't have an acceptable solution to make this device work. Rather I
> prefer to submit a patch which disables MMC2 on these boards.
>
> You can still use MMC1 to mount your file system. This is the card you can
> plug in to the cage.
>
> Regards,
> Madhu
>
>> --
>> Regards,
>> Nishanth Menon
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


-- =


Salutations
Laurent Epinat -> mailto:laurent.epinat@cioinfoindus.fr

CIO Informatique
Le millenium
1, rue de Presse - BP 710
42950 Saint-Etienne Cedex 9

Tel    33 (0) 477 93 34 32
Tcopie 33 (0) 477 79 75 55
WWW : http://www.cioinfoindus.fr/
