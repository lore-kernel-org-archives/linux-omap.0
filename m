From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 1/3] Fixing compilation warning for 'nand/omap2.c'
Date: Fri, 30 Oct 2009 14:12:20 +0530
Message-ID: <ce9ab5790910300142s615c7d59h15bb2d46d4f76574@mail.gmail.com>
References: <ce9ab5790910292321nf230810v353c23f9c1ce1931@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53316 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367AbZJ3Imf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 04:42:35 -0400
Received: by mail-bw0-f227.google.com with SMTP id 27so3265936bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 01:42:40 -0700 (PDT)
In-Reply-To: <ce9ab5790910292321nf230810v353c23f9c1ce1931@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

Looping Linux-omap mailing list.


From: Vimal Singh <vimalsingh@ti.com>
Date: Fri, 30 Oct 2009 11:31:34 +0530
Subject: [PATCH] Fixing compilation warning for 'nand/omap2.c'

Fixing below warning in compilation:
drivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
drivers/mtd/nand/omap2.c:508: warning: passing argument 2 of
'omap_nand_dma_transfer' discards qualifiers from pointer target type

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 drivers/mtd/nand/omap2.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 090ab87..92573d5 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -501,11 +501,13 @@ static void omap_read_buf_dma_pref(struct
mtd_info *mtd, u_char *buf, int len)
 static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 					const u_char *buf, int len)
 {
+	u_char *p = (u_char *)buf;
+
 	if (len <= mtd->oobsize)
-		omap_write_buf_pref(mtd, buf, len);
+		omap_write_buf_pref(mtd, p, len);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, buf, len, 0x1);
+		omap_nand_dma_transfer(mtd, p, len, 0x1);
 }

 /**
-- 
1.5.5
