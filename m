From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 2/4] mtd: nand: omap: add support for BCH16_ECC - ELM driver updates
Date: Thu, 18 Jul 2013 01:22:04 +0530
Message-ID: <1374090726-9393-3-git-send-email-pekon@ti.com>
References: <1374090726-9393-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55989 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab3GQTy3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 15:54:29 -0400
In-Reply-To: <1374090726-9393-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, devicetree-discuss@lists.ozlabs.org, Pekon Gupta <pekon@ti.com>

With increase in NAND flash densities occurence of bit-flips has increased.
Thus stronger ECC schemes are required for detecting and correcting multiple
simultaneous bit-flips in same NAND page. But stronger ECC schemes have large
ECC syndrome which require more space in OOB/Spare.
This patch add support for BCH16_ECC:
(a) BCH16_ECC can correct 16 bit-flips per 512Bytes of data.
(b) BCH16_ECC generates 26-bytes of ECC syndrome / 512B.

Due to (b) this scheme can only be used with NAND devices which have enough
OOB to satisfy following equation:
OOBsize per page >= 26 * (page-size / 512)

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/devices/elm.c         | 29 +++++++++++++++++++++++++++++
 include/linux/platform_data/elm.h |  8 +-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index fca436e..f50f36b 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -217,6 +217,35 @@ static void elm_load_syndrome(struct elm_info *info,
 				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_3 +
 						 offset), cpu_to_le32(val));
 				break;
+			case BCH16_ECC:
+				val =	*(ecc + 25) << 0  | *(ecc + 24) <<  8 |
+					*(ecc + 23) << 16 | *(ecc + 22) << 24;
+				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_0 +
+						 offset), cpu_to_le32(val));
+				val =	*(ecc + 21) <<  0 | *(ecc + 20) <<  8 |
+					*(ecc + 19) << 16 | *(ecc + 18) << 24;
+				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_1 +
+						 offset), cpu_to_le32(val));
+				val =	*(ecc + 17) <<  0 | *(ecc + 16) <<  8 |
+					*(ecc + 15) << 16 | *(ecc + 14) << 24;
+				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_2 +
+						 offset), cpu_to_le32(val));
+				val =	*(ecc + 13) <<  0 | *(ecc + 12) <<  8 |
+					*(ecc + 11) << 16 | *(ecc + 10) << 24;
+				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_3 +
+						 offset), cpu_to_le32(val));
+				val =	*(ecc +  9) <<  0 | *(ecc +  8) <<  8 |
+					*(ecc +  7) << 16 | *(ecc +  6) << 24;
+				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_4 +
+						 offset), cpu_to_le32(val));
+				val =	*(ecc +  5) <<  0 | *(ecc +  4) <<  8 |
+					*(ecc +  3) << 16 | *(ecc +  2) << 24;
+				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_5 +
+						 offset), cpu_to_le32(val));
+				val =	*(ecc +  1) <<  0 | *(ecc +  0) <<  8;
+				elm_write_reg(info, (ELM_SYNDROME_FRAGMENT_6 +
+						 offset), cpu_to_le32(val));
+				break;
 			}
 		}
 	}
diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
index d16465b..18b37d8 100644
--- a/include/linux/platform_data/elm.h
+++ b/include/linux/platform_data/elm.h
@@ -21,19 +21,13 @@
 enum bch_ecc {
 	BCH4_ECC = 0,
 	BCH8_ECC,
+	BCH16_ECC
 };
 
 /* ELM support 8 error syndrome process */
 #define ERROR_VECTOR_MAX		8
 #define ELM_MAX_DETECTABLE_ERRORS	16
 
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
1.8.1

