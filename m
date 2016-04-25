From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 1/3] spi: return error if kmap'd buffers passed to spi_map_buf()
Date: Mon, 25 Apr 2016 15:14:00 +0530
Message-ID: <1461577442-8853-2-git-send-email-vigneshr@ti.com>
References: <1461577442-8853-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461577442-8853-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Current spi_map_buf() implementation supports creates sg_table for
vmalloc'd and kmalloc'd buffers. Therefore return error if kmap'd buffer
(or any other buffer) is passed to spi_map_buf().

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: New patch

 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a7ab330d0640..82126bbe69cf 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -717,9 +717,11 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	if (vmalloced_buf) {
 		desc_len = min_t(int, max_seg_size, PAGE_SIZE);
 		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
-	} else {
+	} else if (virt_addr_valid(buf)) {
 		desc_len = min_t(int, max_seg_size, master->max_dma_len);
 		sgs = DIV_ROUND_UP(len, desc_len);
+	} else {
+		return -EINVAL;
 	}
 
 	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
-- 
2.8.1
