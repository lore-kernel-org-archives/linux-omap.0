From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RFC/PATCH v2] mtd: nand: Fix ONFI detection of 16-bit width NAND devices
Date: Sat, 30 Nov 2013 14:17:39 -0300
Message-ID: <1385831859-19170-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1385831859-19170-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46462 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751336Ab3K3RS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Nov 2013 12:18:56 -0500
In-Reply-To: <1385831859-19170-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, shc_work@mail.ru, u.kleine-koenig@pengutronix.de, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patch is alternative implementation for following commit which introduced
NAND_BUSWIDTH_AUTO for detection of bus-width during device probe
   commit 64b37b2a63eb2f80b65c7185f0013f8ffc637ae3
   Author:     Matthieu CASTET <matthieu.castet@parrot.com>
   AuthorDate: 2012-11-06

As NAND device is identified only during nand_scan_ident(), so this patch
assumes that NAND driver may un-initialized or partially congigured while
calling nand_scan_ident(). Hence, this patch does following:

 1. Temporarily configures 'bus-width=x8' mode before reading ONFI parameters,
    as required by ONFI specification [1].

 2. Reconfigures the driver with correct bus-width determined by either reading
    ONFI param, or the nand_flash_id[] table.

This patch removes any dependency on either 'DT binding' or 'platform data' to
specify the NAND device bus-width.

[*] Reference: ONFI spec version 3.1 (section 3.5.3. Target Initialization)
    "The Read ID and Read Parameter Page commands only use the lower 8-bits
     of the data bus. The host shall not issue commands that use a word
     data width on x16 devices until the host determines the device supports
     a 16-bit data bus width in the parameter page."

Signed-off-by: Pekon Gupta <pekon@ti.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index bd39f7b..3ff9944 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2942,15 +2942,6 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->read_byte(mtd) != 'F' || chip->read_byte(mtd) != 'I')
 		return 0;
 
-	/*
-	 * ONFI must be probed in 8-bit mode or with NAND_BUSWIDTH_AUTO, not
-	 * with NAND_BUSWIDTH_16
-	 */
-	if (chip->options & NAND_BUSWIDTH_16) {
-		pr_err("ONFI cannot be probed in 16-bit mode; aborting\n");
-		return 0;
-	}
-
 	chip->cmdfunc(mtd, NAND_CMD_PARAM, 0, -1);
 	for (i = 0; i < 3; i++) {
 		chip->read_buf(mtd, (uint8_t *)p, sizeof(*p));
@@ -3335,13 +3326,21 @@ static bool find_full_id_nand(struct mtd_info *mtd, struct nand_chip *chip,
  */
 static struct nand_flash_dev *nand_get_flash_type(struct mtd_info *mtd,
 						  struct nand_chip *chip,
-						  int busw,
 						  int *maf_id, int *dev_id,
 						  struct nand_flash_dev *type)
 {
 	int i, maf_idx;
+	int busw = 0;
 	u8 id_data[8];
 
+	/*
+	 * The device detection is done in 8-bit mode. The real bus width
+	 * will be autodetected (either ONFI or flash-based), the
+	 * defaults re-configured and the chip->options updated.
+	 */
+	nand_set_defaults(chip, 0);
+	chip->options &= ~NAND_BUSWIDTH_16;
+
 	/* Select the device */
 	chip->select_chip(mtd, 0);
 
@@ -3431,22 +3430,10 @@ ident_done:
 			break;
 	}
 
-	if (chip->options & NAND_BUSWIDTH_AUTO) {
-		WARN_ON(chip->options & NAND_BUSWIDTH_16);
+	/* Configure driver using detected bus-width */
+	if (busw) {
 		chip->options |= busw;
 		nand_set_defaults(chip, busw);
-	} else if (busw != (chip->options & NAND_BUSWIDTH_16)) {
-		/*
-		 * Check, if buswidth is correct. Hardware drivers should set
-		 * chip correct!
-		 */
-		pr_info("NAND device: Manufacturer ID:"
-			" 0x%02x, Chip ID: 0x%02x (%s %s)\n", *maf_id,
-			*dev_id, nand_manuf_ids[maf_idx].name, mtd->name);
-		pr_warn("NAND bus width %d instead %d bit\n",
-			   (chip->options & NAND_BUSWIDTH_16) ? 16 : 8,
-			   busw ? 16 : 8);
-		return ERR_PTR(-EINVAL);
 	}
 
 	nand_decode_bbm_options(mtd, chip, id_data);
@@ -3497,17 +3484,13 @@ ident_done:
 int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 		    struct nand_flash_dev *table)
 {
-	int i, busw, nand_maf_id, nand_dev_id;
+	int i, nand_maf_id, nand_dev_id;
 	struct nand_chip *chip = mtd->priv;
 	struct nand_flash_dev *type;
 
-	/* Get buswidth to select the correct functions */
-	busw = chip->options & NAND_BUSWIDTH_16;
-	/* Set the default functions */
-	nand_set_defaults(chip, busw);
 
 	/* Read the flash type */
-	type = nand_get_flash_type(mtd, chip, busw,
+	type = nand_get_flash_type(mtd, chip,
 				&nand_maf_id, &nand_dev_id, table);
 
 	if (IS_ERR(type)) {
-- 
1.8.1.5

