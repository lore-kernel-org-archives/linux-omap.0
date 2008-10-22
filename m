From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: [PATCH] OMAP2 NAND: Fix __raw_readsl() length argument
Date: Wed, 22 Oct 2008 13:58:16 -0700
Message-ID: <a46a26fd0810221358l6153c0dat74f76af99fc8afaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:62240 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758878AbYJVU6R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 16:58:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so192469and.103
        for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 13:58:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

__raw_readsl() takes data length in longs so divide byte length by
four instead of two.

Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
---
 drivers/mtd/nand/omap2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 drivers/mtd/nand/omap2.c

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
old mode 100644
new mode 100755
index 2ede116..2673ae4
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -196,7 +196,7 @@ static void omap_read_buf16(struct mtd_info *mtd,
u_char *buf, int len)
 {
        struct nand_chip *nand = mtd->priv;

-       __raw_readsl(nand->IO_ADDR_R, buf, len / 2);
+       __raw_readsl(nand->IO_ADDR_R, buf, len / 4);
 }

 /*
--
1.6.0.1
