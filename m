From: Christopher Harvey <charvey@matrox.com>
Subject: [PATCH v3] mtd: omap: nand: Remove 0xFF's that prefixed 16bit NAND
 addresses
Date: Mon, 29 Oct 2012 15:51:27 -0400
Message-ID: <20121029195127.GA32749@harvey-pc.matrox.com>
References: <20121026193410.GA21474@harvey-pc.matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mtxmxout5.matrox.com ([138.11.2.95]:56115 "EHLO
	mtxmxout5.matrox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2J2Trn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 15:47:43 -0400
Content-Disposition: inline
In-Reply-To: <20121026193410.GA21474@harvey-pc.matrox.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ivan Djelic <ivan.djelic@parrot.com>

In 16bit NAND mode the GPMC would send the address 0xNN as 0xFFNN
instead of 0x00NN on the bus. The 0xFFs were actually uninitialized
bits that were left unset in the GPMC command output register. The
reason they weren't initialized in 16bit mode is that if the same code
that writes to this register was used in 8bit mode then 2 commands
would be output in 8bit mode. One for the low byte, and an extra 0x0
command for the high byte. This commit uses writew if we're using
16bit NAND. This commit also changes the high byte in the command
output register, but they are ignored by NAND chips anyway.

Most chips seem fine with the extra 0xFFs, but the ONFI spec says
otherwise.

Signed-off-by: Christopher Harvey <charvey@matrox.com>
---
 drivers/mtd/nand/omap2.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5b31386..ae6738f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -225,16 +225,20 @@ static void omap_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct omap_nand_info *info = container_of(mtd,
 					struct omap_nand_info, mtd);
+	void __iomem *reg;
 
 	if (cmd != NAND_CMD_NONE) {
 		if (ctrl & NAND_CLE)
-			writeb(cmd, info->reg.gpmc_nand_command);
-
+			reg = info->reg.gpmc_nand_command;
 		else if (ctrl & NAND_ALE)
-			writeb(cmd, info->reg.gpmc_nand_address);
-
+			reg = info->reg.gpmc_nand_address;
 		else /* NAND_NCE */
-			writeb(cmd, info->reg.gpmc_nand_data);
+			reg = info->reg.gpmc_nand_data;
+
+		if (info->nand.options & NAND_BUSWIDTH_16)
+			writew(cmd, reg);
+		else
+			writeb(cmd, reg);
 	}
 }
 
-- 
1.7.8.6
