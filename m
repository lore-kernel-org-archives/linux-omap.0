From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v8 2/4] mtd: devices: elm: clean elm_load_syndrome
Date: Thu, 20 Mar 2014 18:43:06 +0530
Message-ID: <1395321188-4123-3-git-send-email-pekon@ti.com>
References: <1395321188-4123-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33752 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756610AbaCTNN1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2014 09:13:27 -0400
In-Reply-To: <1395321188-4123-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Pekon Gupta <pekon@ti.com>

This patch refactors elm_load_syndrome() to make it scalable for newer
ECC schemes by removing scheme specific macros (like ECC_BYTES*xx),
and instead using ECC control information passed during elm_config.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/devices/elm.c         | 18 +++++++++++-------
 include/linux/platform_data/elm.h |  7 -------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index c51752a..4fbfaf6 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -84,6 +84,7 @@ struct elm_info {
 	struct list_head list;
 	enum bch_ecc bch_type;
 	struct elm_registers elm_regs;
+	int ecc_syndrome_size;
 };
 
 static LIST_HEAD(elm_devices);
@@ -126,7 +127,8 @@ int elm_config(struct device *dev, enum bch_ecc bch_type,
 
 	reg_val = (bch_type & ECC_BCH_LEVEL_MASK) | (ELM_ECC_SIZE << 16);
 	elm_write_reg(info, ELM_LOCATION_CONFIG, reg_val);
-	info->bch_type = bch_type;
+	info->bch_type		= bch_type;
+	info->ecc_syndrome_size	= ecc_syndrome_size;
 
 	return 0;
 }
@@ -175,10 +177,8 @@ static void elm_load_syndrome(struct elm_info *info,
 			elm_configure_page_mode(info, i, true);
 			offset = ELM_SYNDROME_FRAGMENT_0 +
 				SYNDROME_FRAGMENT_REG_SIZE * i;
-
-			/* BCH8 */
-			if (info->bch_type) {
-
+			switch (info->bch_type) {
+			case BCH8_ECC:
 				/* syndrome fragment 0 = ecc[9-12B] */
 				val = cpu_to_be32(*(u32 *) &ecc[9]);
 				elm_write_reg(info, offset, val);
@@ -197,7 +197,8 @@ static void elm_load_syndrome(struct elm_info *info,
 				offset += 4;
 				val = ecc[0];
 				elm_write_reg(info, offset, val);
-			} else {
+				break;
+			case BCH4_ECC:
 				/* syndrome fragment 0 = ecc[20-52b] bits */
 				val = (cpu_to_be32(*(u32 *) &ecc[3]) >> 4) |
 					((ecc[2] & 0xf) << 28);
@@ -207,11 +208,14 @@ static void elm_load_syndrome(struct elm_info *info,
 				offset += 4;
 				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 12;
 				elm_write_reg(info, offset, val);
+				break;
+			default:
+				pr_err("invalid config bch_type\n");
 			}
 		}
 
 		/* Update ecc pointer with ecc byte size */
-		ecc += info->bch_type ? BCH8_SIZE : BCH4_SIZE;
+		ecc += info->ecc_syndrome_size;
 	}
 }
 
diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index 6e37156..4edb406 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -26,13 +26,6 @@ enum bch_ecc {
 /* ELM support 8 error syndrome process */
 #define ERROR_VECTOR_MAX		8
 
-#define BCH8_ECC_OOB_BYTES		13
-#define BCH4_ECC_OOB_BYTES		7
-/* RBL requires 14 byte even though BCH8 uses only 13 byte */
-#define BCH8_SIZE			(BCH8_ECC_OOB_BYTES + 1)
-/* Uses 1 extra byte to handle erased pages */
-#define BCH4_SIZE			(BCH4_ECC_OOB_BYTES + 1)
-
 /**
  * struct elm_errorvec - error vector for elm
  * @error_reported:		set true for vectors error is reported
-- 
1.8.5.1.163.gd7aced9

