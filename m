From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 08/16] mtd: nand: omap: Fix build warning
Date: Wed, 21 May 2014 14:20:56 +0300
Message-ID: <1400671264-10702-9-git-send-email-rogerq@ti.com>
References: <1400671264-10702-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400671264-10702-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: pekon@ti.com, ezequiel.garcia@free-electrons.com, robertcnelson@gmail.com, jg1.han@samsung.com, dwmw2@infradead.org, javier@dowhile0.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

=46ix the following warning when CONFIG_MTD_NAND_OMAP_BCH is disabled.
warning: =E2=80=98erased_sector_bitflips=E2=80=99 defined but not used =
[-Wunused-function]

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/omap2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1ff49b8..1b800bc 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1237,6 +1237,7 @@ static int __maybe_unused omap_calculate_ecc_bch(=
struct mtd_info *mtd,
 	return 0;
 }
=20
+#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * erased_sector_bitflips - count bit flips
  * @data:	data sector buffer
@@ -1276,7 +1277,6 @@ static int erased_sector_bitflips(u_char *data, u=
_char *oob,
 	return flip_bits;
 }
=20
-#ifdef CONFIG_MTD_NAND_OMAP_BCH
 /**
  * omap_elm_correct_data - corrects page data area in case error repor=
ted
  * @mtd:	MTD device structure
--=20
1.8.3.2
