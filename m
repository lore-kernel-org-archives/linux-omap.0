From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 02/10] mmc: debugfs: Print ext_csd in ascending order
Date: Sat, 18 Aug 2012 00:22:22 +0530
Message-ID: <1345229550-8672-3-git-send-email-svenkatr@ti.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>
List-Id: linux-omap@vger.kernel.org

ext_csd exported through debugfs is printed in reverse order (from
byte 511 to 0), which causes confusion.
Fix the for loop to print ext_csd in natural order.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/core/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 9ab5b17..d96c643 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -281,7 +281,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 	if (err)
 		goto out_free;
 
-	for (i = 511; i >= 0; i--)
+	for (i = 0; i < 512; i++)
 		n += sprintf(buf + n, "%02x", ext_csd[i]);
 	n += sprintf(buf + n, "\n");
 	BUG_ON(n != EXT_CSD_STR_LEN);
-- 
1.7.11.1.25.g0e18bef

