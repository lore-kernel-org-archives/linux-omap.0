From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH 1/3] mtd nand : onfi need to be probed in 8 bits mode
Date: Tue,  6 Nov 2012 11:51:43 +0100
Message-ID: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45208 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2KFKv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 05:51:57 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so118907bkc.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 02:51:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: dedekind1@gmail.com, Matthieu CASTET <matthieu.castet@parrot.com>

- NAND_CMD_READID want an address that it is not scaled on x16 device (it is always 0x20)
- NAND_CMD_PARAM want 8 bits data

Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
---
 drivers/mtd/nand/nand_base.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 5894c2c..abeb8e9 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2851,6 +2851,8 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
 	int i;
 	int val;
 
+	/* ONFI need to be probed in 8 bits mode */
+	WARN_ON(chip->options & NAND_BUSWIDTH_16);
 	/* Try ONFI for unknown chip or LP */
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0x20, -1);
 	if (chip->read_byte(mtd) != 'O' || chip->read_byte(mtd) != 'N' ||
-- 
1.7.10.4

