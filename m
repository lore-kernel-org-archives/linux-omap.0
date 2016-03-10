From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v4 6/7] mtd: nand: omap2: Fix high memory dma prefetch transfer
Date: Thu, 10 Mar 2016 17:56:42 -0600
Message-ID: <1457654203-20856-7-git-send-email-fcooper@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457654203-20856-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, dwmw2@infradead.org, computersforpeace@gmail.com, rogerq@ti.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Based on DMA documentation and testing using high memory buffer when
doing dma transfers can lead to various issues including kernel
panics.

To workaround this simply use cpu copy. The amount of high memory
buffers used are very uncommon so no noticeable performance hit should
be seen.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/mtd/nand/omap2.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 0863a83..22b0112 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -467,17 +467,8 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	int ret;
 	u32 val;
 
-	if (addr >= high_memory) {
-		struct page *p1;
-
-		if (((size_t)addr & PAGE_MASK) !=
-			((size_t)(addr + len - 1) & PAGE_MASK))
-			goto out_copy;
-		p1 = vmalloc_to_page(addr);
-		if (!p1)
-			goto out_copy;
-		addr = page_address(p1) + ((size_t)addr & ~PAGE_MASK);
-	}
+	if (addr >= high_memory)
+		goto out_copy;
 
 	sg_init_one(&sg, addr, len);
 	n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
@@ -534,6 +525,7 @@ out_copy:
 	else
 		is_write == 0 ? omap_read_buf8(mtd, (u_char *) addr, len)
 			: omap_write_buf8(mtd, (u_char *) addr, len);
+
 	return 0;
 }
 
-- 
2.7.0
