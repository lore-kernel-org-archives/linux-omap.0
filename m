From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] mmc: csd version check updated to support MMC v4.41
Date: Wed, 14 Jul 2010 13:51:07 +0530
Message-ID: <1279095667-21255-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>
List-Id: linux-omap@vger.kernel.org

 CSD_STRUCTURE [127:126] describes the version of the CSD structure.
 According to the MMC specificaiton (v4.4.1), 3 is also a valid number.  

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 Tested on omap4430 ES2.0

 drivers/mmc/core/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89f7a25..525af33 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -122,7 +122,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 	 * v1.2 has extra information in bits 15, 11 and 10.
 	 */
 	csd_struct = UNSTUFF_BITS(resp, 126, 2);
-	if (csd_struct != 1 && csd_struct != 2) {
+	if (csd_struct > 3) {
 		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
 			mmc_hostname(card->host), csd_struct);
 		return -EINVAL;
