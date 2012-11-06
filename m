From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 3/3] omap nand : use onfi mode to compute optimized timings
Date: Tue,  6 Nov 2012 17:44:37 +0100
Message-ID: <1352220277-4251-3-git-send-email-matthieu.castet@parrot.com>
References: <1352220277-4251-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62480 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab2KFQov (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 11:44:51 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so317573bkc.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 08:44:51 -0800 (PST)
In-Reply-To: <1352220277-4251-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, Matthieu CASTET <matthieu.castet@parrot.com>

If the platform data give us nand timings (in gpmc_t), we use
them and not use onfi timings.

Tested on omap 3630 (with onfi flash and mode {2, 4 , 5})

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 drivers/mtd/nand/omap2.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 618cf42..6c45c59 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -29,6 +29,7 @@
 
 #include <plat/dma.h>
 #include <plat/gpmc.h>
+#include <plat/cpu.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #define	DRIVER_NAME	"omap2-nand"
@@ -153,6 +154,8 @@ struct omap_nand_info {
 #endif
 };
 
+static int optim_rd, optim_wr;
+
 /**
  * omap_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
@@ -181,6 +184,13 @@ static int omap_prefetch_enable(int cs, int fifo_th, int dma_mode,
 	val = ((cs << PREFETCH_CONFIG1_CS_SHIFT) |
 		PREFETCH_FIFOTHRESHOLD(fifo_th) | ENABLE_PREFETCH |
 		(dma_mode << DMA_MPU_MODE_SHIFT) | (0x1 & is_write));
+	if (is_write) {
+		if (optim_wr)
+			val |= (1 << 27) /* ENABLEOPTIMIZEDACCESS */| (optim_wr << 28);
+	} else {
+		if (optim_rd)
+			val |= (1 << 27) /* ENABLEOPTIMIZEDACCESS */| (optim_rd << 28);
+	}
 	writel(val, info->reg.gpmc_prefetch_config1);
 
 	/*  Start the prefetch engine */
@@ -1239,6 +1249,122 @@ static void omap3_free_bch(struct mtd_info *mtd)
 }
 #endif /* CONFIG_MTD_NAND_OMAP_BCH */
 
+/* Update hardware configuration after device geometry has been queried */
+static int omap_onfi_set(struct mtd_info* mtd, int mode)
+{
+	struct omap_nand_info *info = container_of(mtd,
+						struct omap_nand_info, mtd);
+
+    const struct reduced_onfi *tn = nand_get_timing(mode, 1);
+	int tmp;
+	struct gpmc_timings t;
+
+	pr_info("omap nand : setting onfi mode %d\n", mode);
+
+
+	/* only tested on 3630 */
+	if (!cpu_is_omap3630()) {
+		/* wr_access is shared with access */
+		return -EINVAL;
+	}
+
+	memset(&t, 0, sizeof(t));
+
+	/* all signal start at the same time :
+	   we could delay nRE, nWE, but this won't
+	   work with prefetcher optimisation...
+	 */
+
+	t.cs_on = 0;
+	t.adv_on = 0;
+	t.oe_on = 0;
+	t.we_on = 0;
+
+	tmp = gpmc_round_ns_to_ticks(tn->twp);
+	/* nCS low to nWE high */
+	t.we_off = gpmc_round_ns_to_ticks(tn->twsetup) + tmp;
+
+	/* nCS low to end */
+	t.wr_cycle = t.we_off + max((int)tn->twh, tn->twc - tmp);
+
+	/* BCH need 4 cycles */
+	if (gpmc_ns_to_ticks(t.wr_cycle) < 4)
+		t.wr_cycle = gpmc_ticks_to_ns(4);
+	else if (gpmc_ns_to_ticks(t.wr_cycle) > 0x1f)
+		t.wr_cycle = gpmc_ticks_to_ns(0x1f);
+
+	t.cs_wr_off = t.wr_cycle;
+	t.adv_wr_off = t.wr_cycle;
+	t.wr_access = t.we_off;
+
+	tmp = gpmc_round_ns_to_ticks(tn->trp);
+	/* nCS low to nRE high */
+	t.oe_off = gpmc_round_ns_to_ticks(tn->trsetup) + tmp;
+
+	/* nCS low to end */
+	t.rd_cycle = t.oe_off + max((int)tn->treh, tn->trc - tmp);;
+
+	/* BCH need 4 cycles */
+	if (gpmc_ns_to_ticks(t.rd_cycle) < 4)
+		t.rd_cycle = gpmc_ticks_to_ns(4);
+	else if (gpmc_ns_to_ticks(t.rd_cycle) > 0x1f)
+		t.rd_cycle = gpmc_ticks_to_ns(0x1f);
+
+	t.cs_rd_off = t.rd_cycle;
+	t.adv_rd_off = t.rd_cycle; /* not used */
+	if (tn->edo)
+		t.access = t.rd_cycle;
+	else
+		t.access = t.oe_off;
+
+	t.page_burst_access = 0;  /* not used */
+	t.wr_data_mux_bus = 0; /* not used not in MUXADDDATA mode */
+
+	/* we often overflow here ... */
+	tmp = gpmc_ns_to_ticks(tn->bta);
+	if (tmp > 0xf)
+		tmp = 0xf;
+	t.busturnaround = gpmc_ticks_to_ns(tmp);
+
+	tmp = gpmc_ns_to_ticks(tn->twhr);
+	if (tmp > 0xf)
+		tmp = 0xf;
+	t.cycle2cycledelay = gpmc_ticks_to_ns(tmp);
+
+	/*
+	   XXX tbusy is not configurable
+	   trm is not clear how much the gpmc wait between WAIT high and read.
+	   But the linux driver doesn't use SYNCHROMODE in GPMC_PREFETCH_CONFIG1,
+	   so we should be safe
+	 */
+	pr_debug("nand timings\n");
+	pr_debug("oe_off=%d, rd_cycle=%d\n", t.oe_off, t.rd_cycle);
+	pr_debug("we_off=%d, wr_cycle=%d\n", t.we_off, t.wr_cycle);
+
+	/* make sure timming register got sane default */
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG2, 0);
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG3, 0);
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG4, 0);
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG5, 0);
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG6, (1<<31) | (1<<7));
+	gpmc_cs_set_timings(info->gpmc_cs, &t);
+
+	/* for burst we can remove twsetup/trsetup, but we should
+	   make sure cycle is not less than 4 (for bch)
+
+	   This number is the cycles to be
+	   subtracted from RdCycleTime, WrCycleTime,
+	   AccessTime, CSRdOffTime, CSWrOffTime,
+	   ADVRdOffTime, ADVWrOffTime, OEOffTime, WEOffTime
+	 */
+	optim_wr = min(gpmc_ns_to_ticks(t.wr_cycle) - 4,
+			gpmc_ns_to_ticks(tn->twsetup));
+	optim_rd = min(gpmc_ns_to_ticks(t.rd_cycle) - 4,
+			gpmc_ns_to_ticks(tn->trsetup));
+
+	return 0;
+}
+
 static int __devinit omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
@@ -1408,6 +1534,11 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
+	if (!pdata->gpmc_t) {
+		/* default to mode 0 for init */
+		omap_onfi_set(&info->mtd, 0);
+	}
+
 	/* update for 16 bits device */
 	if (info->nand.options & NAND_BUSWIDTH_16) {
 		if (!(pdata->bussize & NAND_OMAP_BUS_16)) {
@@ -1471,6 +1602,9 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (!pdata->gpmc_t && info->nand.onfi_speed >= 0)
+		omap_onfi_set(&info->mtd, info->nand.onfi_speed);
+
 	/* second phase scan */
 	if (nand_scan_tail(&info->mtd)) {
 		err = -ENXIO;
-- 
1.7.10.4

