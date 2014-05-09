From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v3 2/4] mtd: nand: omap: add support for BCH16_ECC - ELM driver updates
Date: Fri, 9 May 2014 14:29:13 +0530
Message-ID: <1399625955-20882-3-git-send-email-pekon@ti.com>
References: <1399625955-20882-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42761 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbaEIJAk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 05:00:40 -0400
In-Reply-To: <1399625955-20882-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Felipe Balbi <balbi@ti.com>, Pekon Gupta <pekon@ti.com>

ELM hardware engine is used to detect ECC errors for BCHx ecc-schemes
(like BCH4/BCH8/BCH16). This patch extends configuration of ELM registers
for loading of BCH16 ECC syndrome.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/devices/elm.c         | 42 +++++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/elm.h |  3 ++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index 1fd4a0f..b4b02a1 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -213,6 +213,34 @@ static void elm_load_syndrome(struct elm_info *info,
 				val = cpu_to_be32(*(u32 *) &ecc[0]) >> 12;
 				elm_write_reg(info, offset, val);
 				break;
+			case BCH16_ECC:
+				val =	ecc[25] << 0  | ecc[24] <<  8 |
+					ecc[23] << 16 | ecc[22] << 24;
+				elm_write_reg(info, offset, val);
+				offset += 4;
+				val =	ecc[21] <<  0 | ecc[20] <<  8 |
+					ecc[19] << 16 | ecc[18] << 24;
+				elm_write_reg(info, offset, val);
+				offset += 4;
+				val =	ecc[17] <<  0 | ecc[16] <<  8 |
+					ecc[15] << 16 | ecc[14] << 24;
+				elm_write_reg(info, offset, val);
+				offset += 4;
+				val =	ecc[13] <<  0 | ecc[12] <<  8 |
+					ecc[11] << 16 | ecc[10] << 24;
+				elm_write_reg(info, offset, val);
+				offset += 4;
+				val =	ecc[9]  <<  0 | ecc[8]  <<  8 |
+					ecc[7]  << 16 | ecc[6]  << 24;
+				elm_write_reg(info, offset, val);
+				offset += 4;
+				val =	ecc[5]  <<  0 | ecc[4]  <<  8 |
+					ecc[3]  << 16 | ecc[2]  << 24;
+				elm_write_reg(info, offset, val);
+				offset += 4;
+				val =	ecc[1]  <<  0 | ecc[0]  <<  8;
+				elm_write_reg(info, offset, val);
+				break;
 			default:
 				pr_err("invalid config bch_type\n");
 			}
@@ -435,6 +463,13 @@ static int elm_context_save(struct elm_info *info)
 	for (i = 0; i < ERROR_VECTOR_MAX; i++) {
 		offset = i * SYNDROME_FRAGMENT_REG_SIZE;
 		switch (bch_type) {
+		case BCH16_ECC:
+			regs->elm_syndrome_fragment_6[i] = elm_read_reg(info,
+					ELM_SYNDROME_FRAGMENT_6 + offset);
+			regs->elm_syndrome_fragment_5[i] = elm_read_reg(info,
+					ELM_SYNDROME_FRAGMENT_5 + offset);
+			regs->elm_syndrome_fragment_4[i] = elm_read_reg(info,
+					ELM_SYNDROME_FRAGMENT_4 + offset);
 		case BCH8_ECC:
 			regs->elm_syndrome_fragment_3[i] = elm_read_reg(info,
 					ELM_SYNDROME_FRAGMENT_3 + offset);
@@ -473,6 +508,13 @@ static int elm_context_restore(struct elm_info *info)
 	for (i = 0; i < ERROR_VECTOR_MAX; i++) {
 		offset = i * SYNDROME_FRAGMENT_REG_SIZE;
 		switch (bch_type) {
+		case BCH16_ECC:
+			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_6 + offset,
+					regs->elm_syndrome_fragment_6[i]);
+			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_5 + offset,
+					regs->elm_syndrome_fragment_5[i]);
+			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_4 + offset,
+					regs->elm_syndrome_fragment_4[i]);
 		case BCH8_ECC:
 			elm_write_reg(info, ELM_SYNDROME_FRAGMENT_3 + offset,
 					regs->elm_syndrome_fragment_3[i]);
diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index 4edb406..ac2f266 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -21,6 +21,7 @@
 enum bch_ecc {
 	BCH4_ECC = 0,
 	BCH8_ECC,
+	BCH16_ECC
 };
 
 /* ELM support 8 error syndrome process */
@@ -38,7 +39,7 @@ struct elm_errorvec {
 	bool error_reported;
 	bool error_uncorrectable;
 	int error_count;
-	int error_loc[ERROR_VECTOR_MAX];
+	int error_loc[16];
 };
 
 void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
-- 
1.8.5.1.163.gd7aced9

