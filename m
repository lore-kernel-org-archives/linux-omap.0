From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: return error if kmap'd buffers passed to spi_map_buf()" to the spi tree
Date: Mon, 25 Apr 2016 18:57:02 +0100
Message-ID: <E1aukko-0007o3-5w@debutante>
References: <1461577442-8853-2-git-send-email-vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461577442-8853-2-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: return error if kmap'd buffers passed to spi_map_buf()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0569a88f3d1ffed94b15569d53872f16e2351099 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Mon, 25 Apr 2016 15:14:00 +0530
Subject: [PATCH] spi: return error if kmap'd buffers passed to spi_map_buf()

Current spi_map_buf() implementation supports creates sg_table for
vmalloc'd and kmalloc'd buffers. Therefore return error if kmap'd buffer
(or any other buffer) is passed to spi_map_buf().

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6c4c050e6b65..a50f880a5036 100644
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
2.8.0.rc3
