From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 2/2] mtd: nand: omap2: Fix high memory dma prefetch transfer
Date: Fri, 15 Apr 2016 15:28:59 -0500
Message-ID: <1460752139-12742-3-git-send-email-fcooper@ti.com>
References: <1460752139-12742-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460752139-12742-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@free-electrons.com, dwmw2@infradead.org, computersforpeace@gmail.com, tony@atomide.com, rogerq@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: "Cooper Jr., Franklin" <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "Cooper Jr., Franklin" <fcooper@ti.com>

Based on DMA documentation and testing using high memory buffer when doing
dma transfers can lead to various issues including kernel panics.

To workaround this simply use cpu copy.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/mtd/nand/omap2.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 762e0ed..8d0ae3a 100644
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
+	if (!virt_addr_valid(addr))
+		goto out_copy;
 
 	sg_init_one(&sg, addr, len);
 	n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
-- 
2.7.0
