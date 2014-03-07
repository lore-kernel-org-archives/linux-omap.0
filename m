From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v2 2/4] mtd: nand: omap: add support for BCH16_ECC - ELM
 driver updates
Date: Fri, 7 Mar 2014 18:54:51 +0530
Message-ID: <1394198693-8003-3-git-send-email-pekon@ti.com>
References: <1394198693-8003-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1394198693-8003-1-git-send-email-pekon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Jon Cormier <jcormier@criticallink.com>, linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, linux-mtd <linux-mtd@lists.infradead.org>, Pekon Gupta <pekon@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>
List-Id: linux-omap@vger.kernel.org

ELM hardware engine is used to detect ECC errors for BCHx ecc-schemes
(like BCH4/BCH8/BCH16). This patch extends configuration of ELM registers
for loading of BCH16 ECC syndrome.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/devices/elm.c         | 42 +++++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/elm.h |  3 ++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index 16e62ae..c6465d6 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -216,6 +216,34 @@ static void elm_load_syndrome(struct elm_info *info,
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
@@ -438,6 +466,13 @@ static int elm_context_save(struct elm_info *info)
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
@@ -476,6 +511,13 @@ static int elm_context_restore(struct elm_info *info)
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
index dc0218d..51312f0 100644
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


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
