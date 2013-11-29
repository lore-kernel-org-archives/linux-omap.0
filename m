From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RFC/PATCH] mtd: nand: auto-detection of NAND bus-width from ONFI param or nand_id[]
Date: Fri, 29 Nov 2013 10:40:56 -0300
Message-ID: <1385732456-32696-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42483 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755108Ab3K2Nl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 08:41:29 -0500
In-Reply-To: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, shc_work@mail.ru, Artem Bityutskiy <dedekind1@gmail.com>, David Woodhouse <dwmw2@infradead.org>, swarren@wwwdotorg.org, rob.herring@calxeda.com, mark.rutland@arm.com, Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

From: Pekon Gupta <pekon@ti.com>

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
 include/linux/mtd/nand.h     |  7 -------
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index bd39f7b..2fff3d0 100644
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
@@ -3335,13 +3326,20 @@ static bool find_full_id_nand(struct mtd_info *mtd, struct nand_chip *chip,
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
+
 	/* Select the device */
 	chip->select_chip(mtd, 0);
 
@@ -3431,22 +3429,11 @@ ident_done:
 			break;
 	}
 
-	if (chip->options & NAND_BUSWIDTH_AUTO) {
-		WARN_ON(chip->options & NAND_BUSWIDTH_16);
+	/* re-configure driver using detected bus-width */
+	if (busw) {
+		pr_debug("reconfiguring bus width to %d bit\n", busw ? 16 : 8);
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
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 9e6c8f9..d5cc642 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -183,13 +183,6 @@ typedef enum {
 #define NAND_OWN_BUFFERS	0x00020000
 /* Chip may not exist, so silence any errors in scan */
 #define NAND_SCAN_SILENT_NODEV	0x00040000
-/*
- * Autodetect nand buswidth with readid/onfi.
- * This suppose the driver will configure the hardware in 8 bits mode
- * when calling nand_scan_ident, and update its configuration
- * before calling nand_scan_tail.
- */
-#define NAND_BUSWIDTH_AUTO      0x00080000
 
 /* Options set by nand scan */
 /* Nand scan has allocated controller struct */
-- 
1.8.1.5

