From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 2/3] mtd nand : add NAND_BUSWIDTH_AUTO to autodetect bus width
Date: Tue,  6 Nov 2012 11:51:44 +0100
Message-ID: <1352199105-30215-2-git-send-email-matthieu.castet@parrot.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45208 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab2KFKv6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 05:51:58 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so118907bkc.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 02:51:57 -0800 (PST)
In-Reply-To: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, Matthieu CASTET <matthieu.castet@parrot.com>

The driver call nand_scan_ident in 8 bit mode, then
readid or onfi detection are done (and detect bus width).
The driver should update its bus width before calling nand_scan_tail.

This work because readid and onfi are read work 8 byte mode.

Note that nand_scan_ident send command (NAND_CMD_RESET, NAND_CMD_READID, NAND_CMD_PARAM), address and read data
The ONFI specificication is not very clear for x16 device if high byte of address should be driven to 0,
but according to [1] it should be ok to not drive it during autodetection.

[1]
3.3.2. Target Initialization

[...]
The Read ID and Read Parameter Page commands only use the lower 8-bits of the data bus.
The host shall not issue commands that use a word data width on x16 devices until the host
determines the device supports a 16-bit data bus width in the parameter page.

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 drivers/mtd/nand/nand_base.c |   14 +++++++++-----
 include/linux/mtd/nand.h     |    7 +++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index abeb8e9..c90ef66 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3245,11 +3245,15 @@ ident_done:
 			break;
 	}
 
-	/*
-	 * Check, if buswidth is correct. Hardware drivers should set
-	 * chip correct!
-	 */
-	if (busw != (chip->options & NAND_BUSWIDTH_16)) {
+	if (chip->options & NAND_BUSWIDTH_AUTO) {
+		WARN_ON(chip->options & NAND_BUSWIDTH_16);
+		chip->options |= busw;
+		nand_set_defaults(chip, busw);
+	} else if (busw != (chip->options & NAND_BUSWIDTH_16)) {
+		/*
+		 * Check, if buswidth is correct. Hardware drivers should set
+		 * chip correct!
+		 */
 		pr_info("NAND device: Manufacturer ID:"
 			" 0x%02x, Chip ID: 0x%02x (%s %s)\n", *maf_id,
 			*dev_id, nand_manuf_ids[maf_idx].name, mtd->name);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 24e9159..c8518d4 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -219,6 +219,13 @@ typedef enum {
 #define NAND_OWN_BUFFERS	0x00020000
 /* Chip may not exist, so silence any errors in scan */
 #define NAND_SCAN_SILENT_NODEV	0x00040000
+/*
+ * Autodetect nand buswidth with readid/onfi.
+ * This suppose the driver will configure the hardware in 8 bits mode
+ * when calling nand_scan_ident, and update its configuration
+ * before calling nand_scan_tail.
+ */
+#define NAND_BUSWIDTH_AUTO      0x00080000
 
 /* Options set by nand scan */
 /* Nand scan has allocated controller struct */
-- 
1.7.10.4

