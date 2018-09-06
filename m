From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 16/19] mtd: rawnand: Keep all internal stuff private
Date: Fri,  7 Sep 2018 00:38:48 +0200
Message-ID: <20180906223851.6964-17-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Clouter <alex@digriz.org.uk>, devel@driverdev.osuosl.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Marek Vasut <marek.vasut@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Krzysztof Halasa <khalasa@piap.pl>, linux-omap@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Ryan Mallon <rmallon@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

A lot of things defined in rawnand.h should not be exposed to NAND
controller drivers and should only be shared by core files.

Create the drivers/mtd/nand/rawn/internals.h header to store such
definitions, and move all private defs to this header.

Also remove EXPORT_SYMBOLS() on functions that are not supposed to be
exposed.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/internals.h     | 98 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_amd.c      |  2 +-
 drivers/mtd/nand/raw/nand_base.c     | 21 ++++----
 drivers/mtd/nand/raw/nand_bbt.c      |  3 +-
 drivers/mtd/nand/raw/nand_hynix.c    |  3 +-
 drivers/mtd/nand/raw/nand_ids.c      |  4 +-
 drivers/mtd/nand/raw/nand_macronix.c |  2 +-
 drivers/mtd/nand/raw/nand_micron.c   |  3 +-
 drivers/mtd/nand/raw/nand_samsung.c  |  2 +-
 drivers/mtd/nand/raw/nand_timings.c  |  4 +-
 drivers/mtd/nand/raw/nand_toshiba.c  |  2 +-
 include/linux/mtd/rawnand.h          | 96 -----------------------------------
 12 files changed, 123 insertions(+), 117 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/internals.h

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
new file mode 100644
index 000000000000..1d2edddb6127
--- /dev/null
+++ b/drivers/mtd/nand/raw/internals.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 - Bootlin
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ *
+ * Header containing internal definitions to be used only by core files.
+ * NAND controller drivers should not include this file.
+ */
+
+#ifndef __LINUX_RAWNAND_INTERNALS
+#define __LINUX_RAWNAND_INTERNALS
+
+#include <linux/mtd/rawnand.h>
+
+/*
+ * NAND Flash Manufacturer ID Codes
+ */
+#define NAND_MFR_TOSHIBA	0x98
+#define NAND_MFR_ESMT		0xc8
+#define NAND_MFR_SAMSUNG	0xec
+#define NAND_MFR_FUJITSU	0x04
+#define NAND_MFR_NATIONAL	0x8f
+#define NAND_MFR_RENESAS	0x07
+#define NAND_MFR_STMICRO	0x20
+#define NAND_MFR_HYNIX		0xad
+#define NAND_MFR_MICRON		0x2c
+#define NAND_MFR_AMD		0x01
+#define NAND_MFR_MACRONIX	0xc2
+#define NAND_MFR_EON		0x92
+#define NAND_MFR_SANDISK	0x45
+#define NAND_MFR_INTEL		0x89
+#define NAND_MFR_ATO		0x9b
+#define NAND_MFR_WINBOND	0xef
+
+/**
+ * struct nand_manufacturer_ops - NAND Manufacturer operations
+ * @detect: detect the NAND memory organization and capabilities
+ * @init: initialize all vendor specific fields (like the ->read_retry()
+ *	  implementation) if any.
+ * @cleanup: the ->init() function may have allocated resources, ->cleanup()
+ *	     is here to let vendor specific code release those resources.
+ * @fixup_onfi_param_page: apply vendor specific fixups to the ONFI parameter
+ *			   page. This is called after the checksum is verified.
+ */
+struct nand_manufacturer_ops {
+	void (*detect)(struct nand_chip *chip);
+	int (*init)(struct nand_chip *chip);
+	void (*cleanup)(struct nand_chip *chip);
+	void (*fixup_onfi_param_page)(struct nand_chip *chip,
+				      struct nand_onfi_params *p);
+};
+
+/**
+ * struct nand_manufacturer - NAND Flash Manufacturer structure
+ * @name: Manufacturer name
+ * @id: manufacturer ID code of device.
+ * @ops: manufacturer operations
+ */
+struct nand_manufacturer {
+	int id;
+	char *name;
+	const struct nand_manufacturer_ops *ops;
+};
+
+
+extern struct nand_flash_dev nand_flash_ids[];
+
+extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
+extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
+extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
+extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
+extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
+extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
+
+/* Core functions */
+const struct nand_manufacturer *nand_get_manufacturer(u8 id);
+int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
+int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
+		    int allowbbt);
+int onfi_fill_data_interface(struct nand_chip *chip,
+			     enum nand_data_interface_type type,
+			     int timing_mode);
+int nand_get_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
+int nand_set_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
+int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
+			       int oob_required, int page);
+int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
+				int oob_required, int page);
+int nand_exit_status_op(struct nand_chip *chip);
+void nand_decode_ext_id(struct nand_chip *chip);
+
+/* BBT functions */
+int nand_markbad_bbt(struct nand_chip *chip, loff_t offs);
+int nand_isreserved_bbt(struct nand_chip *chip, loff_t offs);
+int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
+
+#endif /* __LINUX_RAWNAND_INTERNALS */
diff --git a/drivers/mtd/nand/raw/nand_amd.c b/drivers/mtd/nand/raw/nand_amd.c
index 22f060f38123..890c5b43e03c 100644
--- a/drivers/mtd/nand/raw/nand_amd.c
+++ b/drivers/mtd/nand/raw/nand_amd.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/rawnand.h>
+#include "internals.h"
 
 static void amd_nand_decode_id(struct nand_chip *chip)
 {
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 136ccdc61a06..d48c588d1abe 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -39,7 +39,6 @@
 #include <linux/nmi.h>
 #include <linux/types.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/nand_bch.h>
 #include <linux/interrupt.h>
@@ -48,6 +47,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
 
+#include "internals.h"
+
 static int nand_get_device(struct mtd_info *mtd, int new_state);
 
 static int nand_do_write_oob(struct mtd_info *mtd, loff_t to,
@@ -1319,7 +1320,6 @@ static int nand_init_data_interface(struct nand_chip *chip)
 		modes = GENMASK(chip->onfi_timing_mode_default, 0);
 	}
 
-
 	for (mode = fls(modes) - 1; mode >= 0; mode--) {
 		ret = onfi_fill_data_interface(chip, NAND_SDR_IFACE, mode);
 		if (ret)
@@ -2043,7 +2043,6 @@ int nand_exit_status_op(struct nand_chip *chip)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nand_exit_status_op);
 
 /**
  * nand_erase_op - Do an erase operation
@@ -2816,7 +2815,6 @@ int nand_get_features(struct nand_chip *chip, int addr,
 
 	return nand_get_features_op(chip, addr, subfeature_param);
 }
-EXPORT_SYMBOL_GPL(nand_get_features);
 
 /**
  * nand_set_features - wrapper to perform a SET_FEATURE
@@ -2838,7 +2836,6 @@ int nand_set_features(struct nand_chip *chip, int addr,
 
 	return nand_set_features_op(chip, addr, subfeature_param);
 }
-EXPORT_SYMBOL_GPL(nand_set_features);
 
 /**
  * nand_check_erased_buf - check if a buffer contains (almost) only 0xff data
@@ -2985,7 +2982,6 @@ int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
 {
 	return -ENOTSUPP;
 }
-EXPORT_SYMBOL(nand_read_page_raw_notsupp);
 
 /**
  * nand_read_page_raw - [INTERN] read raw page data without ecc
@@ -3729,7 +3725,7 @@ EXPORT_SYMBOL(nand_read_oob_std);
  * @chip: nand chip info structure
  * @page: page number to read
  */
-int nand_read_oob_syndrome(struct nand_chip *chip, int page)
+static int nand_read_oob_syndrome(struct nand_chip *chip, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int length = mtd->oobsize;
@@ -3776,7 +3772,6 @@ int nand_read_oob_syndrome(struct nand_chip *chip, int page)
 
 	return 0;
 }
-EXPORT_SYMBOL(nand_read_oob_syndrome);
 
 /**
  * nand_write_oob_std - [REPLACEABLE] the most common OOB data write function
@@ -3798,7 +3793,7 @@ EXPORT_SYMBOL(nand_write_oob_std);
  * @chip: nand chip info structure
  * @page: page number to write
  */
-int nand_write_oob_syndrome(struct nand_chip *chip, int page)
+static int nand_write_oob_syndrome(struct nand_chip *chip, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	int chunk = chip->ecc.bytes + chip->ecc.prepad + chip->ecc.postpad;
@@ -3864,7 +3859,6 @@ int nand_write_oob_syndrome(struct nand_chip *chip, int page)
 
 	return nand_prog_page_end_op(chip);
 }
-EXPORT_SYMBOL(nand_write_oob_syndrome);
 
 /**
  * nand_do_read_oob - [INTERN] NAND read out-of-band
@@ -3989,7 +3983,6 @@ int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
 {
 	return -ENOTSUPP;
 }
-EXPORT_SYMBOL(nand_write_page_raw_notsupp);
 
 /**
  * nand_write_page_raw - [INTERN] raw page write function
@@ -5579,6 +5572,12 @@ static void nand_manufacturer_cleanup(struct nand_chip *chip)
 		chip->manufacturer.desc->ops->cleanup(chip);
 }
 
+static const char *
+nand_manufacturer_name(const struct nand_manufacturer *manufacturer)
+{
+	return manufacturer ? manufacturer->name : "Unknown";
+}
+
 /*
  * Get the flash and manufacturer id and lookup if the type is supported.
  */
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index b838ecdde8fb..98a826838b60 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -61,13 +61,14 @@
 #include <linux/types.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/bbm.h>
-#include <linux/mtd/rawnand.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
 #include <linux/export.h>
 #include <linux/string.h>
 
+#include "internals.h"
+
 #define BBT_BLOCK_GOOD		0x00
 #define BBT_BLOCK_WORN		0x01
 #define BBT_BLOCK_RESERVED	0x02
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 7eec0d96909a..ac1b5c103968 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -15,10 +15,11 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/rawnand.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
+#include "internals.h"
+
 #define NAND_HYNIX_CMD_SET_PARAMS	0x36
 #define NAND_HYNIX_CMD_APPLY_PARAMS	0x16
 
diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 5423c3bb388e..12d39ccd1cff 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -6,9 +6,11 @@
  * published by the Free Software Foundation.
  *
  */
-#include <linux/mtd/rawnand.h>
+
 #include <linux/sizes.h>
 
+#include "internals.h"
+
 #define LP_OPTIONS 0
 #define LP_OPTIONS16 (LP_OPTIONS | NAND_BUSWIDTH_16)
 
diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 49c546c97c6f..358dcc957bb2 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/rawnand.h>
+#include "internals.h"
 
 /*
  * Macronix AC series does not support using SET/GET_FEATURES to change
diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 1a5505ccbe54..b85e1c13b79e 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -15,9 +15,10 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/rawnand.h>
 #include <linux/slab.h>
 
+#include "internals.h"
+
 /*
  * Special Micron status bit 3 indicates that the block has been
  * corrected by on-die ECC and should be rewritten.
diff --git a/drivers/mtd/nand/raw/nand_samsung.c b/drivers/mtd/nand/raw/nand_samsung.c
index ef022f62f74c..e46d4c492ad8 100644
--- a/drivers/mtd/nand/raw/nand_samsung.c
+++ b/drivers/mtd/nand/raw/nand_samsung.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/rawnand.h>
+#include "internals.h"
 
 static void samsung_nand_decode_id(struct nand_chip *chip)
 {
diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index cb4f0007b65c..bea3062d71d6 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -11,7 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/mtd/rawnand.h>
+
+#include "internals.h"
 
 #define ONFI_DYN_TIMING_MAX U16_MAX
 
@@ -325,4 +326,3 @@ int onfi_fill_data_interface(struct nand_chip *chip,
 
 	return 0;
 }
-EXPORT_SYMBOL(onfi_fill_data_interface);
diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
index 952fe9e62ab4..941ddc615190 100644
--- a/drivers/mtd/nand/raw/nand_toshiba.c
+++ b/drivers/mtd/nand/raw/nand_toshiba.c
@@ -15,7 +15,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/mtd/rawnand.h>
+#include "internals.h"
 
 /* Bit for detecting BENAND */
 #define TOSHIBA_NAND_ID4_IS_BENAND		BIT(7)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 7f0e3dc222ed..fbe7686cfc59 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -775,24 +775,6 @@ nand_get_sdr_timings(const struct nand_data_interface *conf)
 	return &conf->timings.sdr;
 }
 
-/**
- * struct nand_manufacturer_ops - NAND Manufacturer operations
- * @detect: detect the NAND memory organization and capabilities
- * @init: initialize all vendor specific fields (like the ->read_retry()
- *	  implementation) if any.
- * @cleanup: the ->init() function may have allocated resources, ->cleanup()
- *	     is here to let vendor specific code release those resources.
- * @fixup_onfi_param_page: apply vendor specific fixups to the ONFI parameter
- *			   page. This is called after the checksum is verified.
- */
-struct nand_manufacturer_ops {
-	void (*detect)(struct nand_chip *chip);
-	int (*init)(struct nand_chip *chip);
-	void (*cleanup)(struct nand_chip *chip);
-	void (*fixup_onfi_param_page)(struct nand_chip *chip,
-				      struct nand_onfi_params *p);
-};
-
 /**
  * struct nand_op_cmd_instr - Definition of a command instruction
  * @opcode: the command to issue in one cycle
@@ -1403,27 +1385,6 @@ static inline void *nand_get_manufacturer_data(struct nand_chip *chip)
 	return chip->manufacturer.priv;
 }
 
-/*
- * NAND Flash Manufacturer ID Codes
- */
-#define NAND_MFR_TOSHIBA	0x98
-#define NAND_MFR_ESMT		0xc8
-#define NAND_MFR_SAMSUNG	0xec
-#define NAND_MFR_FUJITSU	0x04
-#define NAND_MFR_NATIONAL	0x8f
-#define NAND_MFR_RENESAS	0x07
-#define NAND_MFR_STMICRO	0x20
-#define NAND_MFR_HYNIX		0xad
-#define NAND_MFR_MICRON		0x2c
-#define NAND_MFR_AMD		0x01
-#define NAND_MFR_MACRONIX	0xc2
-#define NAND_MFR_EON		0x92
-#define NAND_MFR_SANDISK	0x45
-#define NAND_MFR_INTEL		0x89
-#define NAND_MFR_ATO		0x9b
-#define NAND_MFR_WINBOND	0xef
-
-
 /*
  * A helper for defining older NAND chips where the second ID byte fully
  * defined the chip, including the geometry (chip size, eraseblock size, page
@@ -1503,46 +1464,7 @@ struct nand_flash_dev {
 	int onfi_timing_mode_default;
 };
 
-/**
- * struct nand_manufacturer - NAND Flash Manufacturer structure
- * @name:	Manufacturer name
- * @id:		manufacturer ID code of device.
- * @ops:	manufacturer operations
-*/
-struct nand_manufacturer {
-	int id;
-	char *name;
-	const struct nand_manufacturer_ops *ops;
-};
-
-const struct nand_manufacturer *nand_get_manufacturer(u8 id);
-
-static inline const char *
-nand_manufacturer_name(const struct nand_manufacturer *manufacturer)
-{
-	return manufacturer ? manufacturer->name : "Unknown";
-}
-
-extern struct nand_flash_dev nand_flash_ids[];
-
-extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
-extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
-extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
-extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
-extern const struct nand_manufacturer_ops amd_nand_manuf_ops;
-extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
-
 int nand_create_bbt(struct nand_chip *chip);
-int nand_markbad_bbt(struct nand_chip *chip, loff_t offs);
-int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
-int nand_isreserved_bbt(struct nand_chip *chip, loff_t offs);
-int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
-int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
-		    int allowbbt);
-
-int onfi_fill_data_interface(struct nand_chip *chip,
-			     enum nand_data_interface_type type,
-			     int timing_mode);
 
 /*
  * Check if it is a SLC nand.
@@ -1574,7 +1496,6 @@ static inline int nand_opcode_8bits(unsigned int command)
 	return 0;
 }
 
-
 int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
 				void *extraoob, int extraooblen,
@@ -1586,18 +1507,9 @@ int nand_ecc_choose_conf(struct nand_chip *chip,
 /* Default write_oob implementation */
 int nand_write_oob_std(struct nand_chip *chip, int page);
 
-/* Default write_oob syndrome implementation */
-int nand_write_oob_syndrome(struct nand_chip *chip, int page);
-
 /* Default read_oob implementation */
 int nand_read_oob_std(struct nand_chip *chip, int page);
 
-/* Default read_oob syndrome implementation */
-int nand_read_oob_syndrome(struct nand_chip *chip, int page);
-
-/* Wrapper to use in order for controllers/vendors to GET/SET FEATURES */
-int nand_get_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
-int nand_set_features(struct nand_chip *chip, int addr, u8 *subfeature_param);
 /* Stub used by drivers that do not support GET/SET FEATURES operations */
 int nand_get_set_features_notsupp(struct nand_chip *chip, int addr,
 				  u8 *subfeature_param);
@@ -1605,14 +1517,10 @@ int nand_get_set_features_notsupp(struct nand_chip *chip, int addr,
 /* Default read_page_raw implementation */
 int nand_read_page_raw(struct nand_chip *chip, uint8_t *buf, int oob_required,
 		       int page);
-int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
-			       int oob_required, int page);
 
 /* Default write_page_raw implementation */
 int nand_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 			int oob_required, int page);
-int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
-				int oob_required, int page);
 
 /* Reset and initialize a NAND device */
 int nand_reset(struct nand_chip *chip, int chipnr);
@@ -1622,7 +1530,6 @@ int nand_reset_op(struct nand_chip *chip);
 int nand_readid_op(struct nand_chip *chip, u8 addr, void *buf,
 		   unsigned int len);
 int nand_status_op(struct nand_chip *chip, u8 *status);
-int nand_exit_status_op(struct nand_chip *chip);
 int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock);
 int nand_read_page_op(struct nand_chip *chip, unsigned int page,
 		      unsigned int offset_in_page, void *buf, unsigned int len);
@@ -1666,9 +1573,6 @@ void nand_cleanup(struct nand_chip *chip);
 /* Unregister the MTD device and calls nand_cleanup() */
 void nand_release(struct nand_chip *chip);
 
-/* Default extended ID decoding function */
-void nand_decode_ext_id(struct nand_chip *chip);
-
 /*
  * External helper for controller drivers that have to implement the WAITRDY
  * instruction and have no physical pin to check it.
-- 
2.14.1
