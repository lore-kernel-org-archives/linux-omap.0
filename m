From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v8 1/4] mtd: devices: elm: check for hardware engine's design constraints
Date: Thu, 20 Mar 2014 18:43:05 +0530
Message-ID: <1395321188-4123-2-git-send-email-pekon@ti.com>
References: <1395321188-4123-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34204 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393AbaCTNNZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2014 09:13:25 -0400
In-Reply-To: <1395321188-4123-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Pekon Gupta <pekon@ti.com>

ELM hardware engine is used by BCH ecc-schemes for detecting and locating ECC
errors. This patch adds the following checks for ELM hardware engine:

 - ELM internal buffers are of 1K,
   so it cannot process data with ecc-step-size > 1K.

 - ELM engine can execute upto maximum of 8 threads in parallel,
   so in *page-mode* (when complete page is processed in single iteration),
   ELM cannot support ecc-steps > 8.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/devices/elm.c         | 13 ++++++++++++-
 drivers/mtd/nand/omap2.c          |  9 ++++++---
 include/linux/platform_data/elm.h |  3 ++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index f160d2c..c51752a 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -103,7 +103,8 @@ static u32 elm_read_reg(struct elm_info *info, int offset)
  * @dev:	ELM device
  * @bch_type:	Type of BCH ecc
  */
-int elm_config(struct device *dev, enum bch_ecc bch_type)
+int elm_config(struct device *dev, enum bch_ecc bch_type,
+	int ecc_steps, int ecc_step_size, int ecc_syndrome_size)
 {
 	u32 reg_val;
 	struct elm_info *info = dev_get_drvdata(dev);
@@ -112,6 +113,16 @@ int elm_config(struct device *dev, enum bch_ecc bch_type)
 		dev_err(dev, "Unable to configure elm - device not probed?\n");
 		return -ENODEV;
 	}
+	/* ELM cannot detect ECC errors for chunks > 1KB */
+	if (ecc_step_size > ((ELM_ECC_SIZE + 1) / 2)) {
+		dev_err(dev, "unsupported config ecc-size=%d\n", ecc_step_size);
+		return -EINVAL;
+	}
+	/* ELM support 8 error syndrome process */
+	if (ecc_steps > ERROR_VECTOR_MAX) {
+		dev_err(dev, "unsupported config ecc-step=%d\n", ecc_steps);
+		return -EINVAL;
+	}
 
 	reg_val = (bch_type & ECC_BCH_LEVEL_MASK) | (ELM_ECC_SIZE << 16);
 	elm_write_reg(info, ELM_LOCATION_CONFIG, reg_val);
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index ab9c472..6f9b339 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1540,6 +1540,8 @@ static int is_elm_present(struct omap_nand_info *info,
 			struct device_node *elm_node, enum bch_ecc bch_type)
 {
 	struct platform_device *pdev;
+	struct nand_ecc_ctrl *ecc = &info->nand.ecc;
+	int err;
 	/* check whether elm-id is passed via DT */
 	if (!elm_node) {
 		pr_err("nand: error: ELM DT node not found\n");
@@ -1553,9 +1555,10 @@ static int is_elm_present(struct omap_nand_info *info,
 	}
 	/* ELM module available, now configure it */
 	info->elm_dev = &pdev->dev;
-	if (elm_config(info->elm_dev, bch_type))
-		return -ENODEV;
-	return 0;
+	err = elm_config(info->elm_dev, bch_type,
+		(info->mtd.writesize / ecc->size), ecc->size, ecc->bytes);
+
+	return err;
 }
 #endif /* CONFIG_MTD_NAND_ECC_BCH */
 
diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index bf0a83b..6e37156 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -50,5 +50,6 @@ struct elm_errorvec {
 
 void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
 		struct elm_errorvec *err_vec);
-int elm_config(struct device *dev, enum bch_ecc bch_type);
+int elm_config(struct device *dev, enum bch_ecc bch_type,
+	int ecc_steps, int ecc_step_size, int ecc_syndrome_size);
 #endif /* __ELM_H */
-- 
1.8.5.1.163.gd7aced9

