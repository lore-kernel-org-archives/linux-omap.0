From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add support to handle kmap'd buffers in spi_map_buf()" to the spi tree
Date: Wed, 17 Aug 2016 12:25:03 +0100
Message-ID: <E1bZyxz-00068K-Ed@debutante>
References: <20160817095237.13101-2-vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160817095237.13101-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: Add support to handle kmap'd buffers in spi_map_buf()

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

>From b1b8153cf0aeeb7ae6d4f012b8beb2dcfc92c68a Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Wed, 17 Aug 2016 15:22:36 +0530
Subject: [PATCH] spi: Add support to handle kmap'd buffers in spi_map_buf()

JFFS2 FS might sometime provide kmap'd buffers as destination
buffers to read data from flash. Update spi_map_buf() function to
generate sg_list for such buffers, so that SPI controllers drivers can
use DMA to read data into such buffers.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51ad42fad567..2a5dd22efa34 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -37,6 +37,7 @@
 #include <linux/kthread.h>
 #include <linux/ioport.h>
 #include <linux/acpi.h>
+#include <linux/highmem.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -709,6 +710,13 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
 	unsigned int max_seg_size = dma_get_max_seg_size(dev);
+#ifdef CONFIG_HIGHMEM
+	const bool kmap_buf = ((unsigned long)buf >= PKMAP_BASE &&
+				(unsigned long)buf < (PKMAP_BASE +
+					(LAST_PKMAP * PAGE_SIZE)));
+#else
+	const bool kmap_buf = false;
+#endif
 	int desc_len;
 	int sgs;
 	struct page *vm_page;
@@ -716,7 +724,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	size_t min;
 	int i, ret;
 
-	if (vmalloced_buf) {
+	if (vmalloced_buf || kmap_buf) {
 		desc_len = min_t(int, max_seg_size, PAGE_SIZE);
 		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
 	} else if (virt_addr_valid(buf)) {
@@ -732,10 +740,13 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 
 	for (i = 0; i < sgs; i++) {
 
-		if (vmalloced_buf) {
+		if (vmalloced_buf || kmap_buf) {
 			min = min_t(size_t,
 				    len, desc_len - offset_in_page(buf));
-			vm_page = vmalloc_to_page(buf);
+			if (vmalloced_buf)
+				vm_page = vmalloc_to_page(buf);
+			else
+				vm_page = kmap_to_page(buf);
 			if (!vm_page) {
 				sg_free_table(sgt);
 				return -ENOMEM;
-- 
2.8.1
