From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v2 3/5] mtd: nand: omap2: Fix high memory dma prefetch transfer
Date: Thu, 15 Oct 2015 12:37:26 -0500
Message-ID: <1444930648-19313-4-git-send-email-fcooper@ti.com>
References: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, rogerq@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
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
V2 Changes:
None

 drivers/mtd/nand/omap2.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1f58420..0d2cbb0 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -479,17 +479,8 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
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
@@ -546,6 +537,7 @@ out_copy:
 	else
 		is_write == 0 ? omap_read_buf8(mtd, (u_char *) addr, len)
 			: omap_write_buf8(mtd, (u_char *) addr, len);
+
 	return 0;
 }
 
-- 
2.6.1
