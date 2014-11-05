From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Wed, 5 Nov 2014 13:00:58 +0200
Message-ID: <1415185258-11747-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: computersforpeace@gmail.com, dwmw2@infradead.org
Cc: ezequiel@vanguardiasur.com.ar, tony@atomide.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, pekon@pek-sem.com, Roger Quadros <rogerq@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In commit 7d5929c1f343 ("mtd: nand: omap: Revert to using software ECC by default"),
we switched back to using 1-bit SW ECC scheme by default. However
commit b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")
didn't take into account the 1-bit SW scheme (i.e. OMAP_ECC_HAM1_CODE_SW)
when checking for small page devices because it was already got rid of
one commit earlier. Consider OMAP_ECC_HAM1_CODE_SW while deciding
if we can proceed with small page devices or not.

Fixes: 7d5929c1f34 ("mtd: nand: omap: Revert to using software ECC by default")

Cc: <stable@vger.kernel.org>        [3.17+]
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/omap2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 3b357e9..758e594 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1742,7 +1742,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* check for small page devices */
-	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW)) {
+	if ((mtd->oobsize < 64) && (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_HW) &&
+	    (pdata->ecc_opt != OMAP_ECC_HAM1_CODE_SW)) {
 		dev_err(&info->pdev->dev, "small page devices are not supported\n");
 		err = -EINVAL;
 		goto return_error;
-- 
1.8.3.2
