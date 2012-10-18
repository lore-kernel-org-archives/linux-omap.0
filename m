From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
Date: Thu, 18 Oct 2012 15:20:46 -0700
Message-ID: <20121018222046.GA28541@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:51205 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab2JRWUr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 18:20:47 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Enable DMA prefetching by setting the 'OMAP_DMA_DST_SYNC_PREFETCH'
flag whenever there is a destination synchronized DMA transfer.
Prefetching is not allowed on source synchronized DMA transfers.

Enabling prefetch significantly improves DMA performance.
For example, running 'modprobe tcrypt sec=2 mode=403' which
exercises the omap-sham driver on an am37x EVM yeilds the
following results:

a) With prefetch disabled

testing speed of async sha1
test  0 (   16 byte blocks,   16 bytes per update,   1 updates):  24049 opers/sec,    384784 bytes/sec
test  1 (   64 byte blocks,   16 bytes per update,   4 updates):  22030 opers/sec,   1409920 bytes/sec
test  2 (   64 byte blocks,   64 bytes per update,   1 updates):  24055 opers/sec,   1539520 bytes/sec
test  3 (  256 byte blocks,   16 bytes per update,  16 updates):   7648 opers/sec,   1958016 bytes/sec
test  4 (  256 byte blocks,   64 bytes per update,   4 updates):   7918 opers/sec,   2027008 bytes/sec
test  5 (  256 byte blocks,  256 bytes per update,   1 updates):   8000 opers/sec,   2048000 bytes/sec
test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates):   3295 opers/sec,   3374080 bytes/sec
test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates):   3602 opers/sec,   3688960 bytes/sec
test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates):   3753 opers/sec,   3843072 bytes/sec
test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates):   3239 opers/sec,   6633472 bytes/sec
test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates):   3557 opers/sec,   7284736 bytes/sec
test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates):   3591 opers/sec,   7354368 bytes/sec
test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates):   3598 opers/sec,   7369728 bytes/sec
test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates):   1751 opers/sec,   7174144 bytes/sec
test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates):   2302 opers/sec,   9431040 bytes/sec
test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates):   2087 opers/sec,   8548352 bytes/sec
test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates):   2050 opers/sec,   8398848 bytes/sec
test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates):    864 opers/sec,   7077888 bytes/sec
test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates):    993 opers/sec,   8138752 bytes/sec
test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates):    936 opers/sec,   7671808 bytes/sec
test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates):   1048 opers/sec,   8589312 bytes/sec
test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates):   1274 opers/sec,  10436608 bytes/sec

b) With prefetch enabled

testing speed of async sha1
test  0 (   16 byte blocks,   16 bytes per update,   1 updates):  23868 opers/sec,    381888 bytes/sec
test  1 (   64 byte blocks,   16 bytes per update,   4 updates):  21928 opers/sec,   1403424 bytes/sec
test  2 (   64 byte blocks,   64 bytes per update,   1 updates):  23910 opers/sec,   1530272 bytes/sec
test  3 (  256 byte blocks,   16 bytes per update,  16 updates):   7664 opers/sec,   1962112 bytes/sec
test  4 (  256 byte blocks,   64 bytes per update,   4 updates):   7924 opers/sec,   2028672 bytes/sec
test  5 (  256 byte blocks,  256 bytes per update,   1 updates):   8006 opers/sec,   2049536 bytes/sec
test  6 ( 1024 byte blocks,   16 bytes per update,  64 updates):   3276 opers/sec,   3355136 bytes/sec
test  7 ( 1024 byte blocks,  256 bytes per update,   4 updates):   3856 opers/sec,   3949056 bytes/sec
test  8 ( 1024 byte blocks, 1024 bytes per update,   1 updates):   3634 opers/sec,   3721728 bytes/sec
test  9 ( 2048 byte blocks,   16 bytes per update, 128 updates):   3257 opers/sec,   6670336 bytes/sec
test 10 ( 2048 byte blocks,  256 bytes per update,   8 updates):   3604 opers/sec,   7380992 bytes/sec
test 11 ( 2048 byte blocks, 1024 bytes per update,   2 updates):   3604 opers/sec,   7380992 bytes/sec
test 12 ( 2048 byte blocks, 2048 bytes per update,   1 updates):   3624 opers/sec,   7422976 bytes/sec
test 13 ( 4096 byte blocks,   16 bytes per update, 256 updates):   2698 opers/sec,  11051008 bytes/sec
test 14 ( 4096 byte blocks,  256 bytes per update,  16 updates):   3500 opers/sec,  14336000 bytes/sec
test 15 ( 4096 byte blocks, 1024 bytes per update,   4 updates):   3596 opers/sec,  14729216 bytes/sec
test 16 ( 4096 byte blocks, 4096 bytes per update,   1 updates):   3588 opers/sec,  14698496 bytes/sec
test 17 ( 8192 byte blocks,   16 bytes per update, 512 updates):   1319 opers/sec,  10809344 bytes/sec
test 18 ( 8192 byte blocks,  256 bytes per update,  32 updates):   1550 opers/sec,  12701696 bytes/sec
test 19 ( 8192 byte blocks, 1024 bytes per update,   8 updates):   1164 opers/sec,   9539584 bytes/sec
test 20 ( 8192 byte blocks, 4096 bytes per update,   2 updates):   1802 opers/sec,  14766080 bytes/sec
test 21 ( 8192 byte blocks, 8192 bytes per update,   1 updates):   1720 opers/sec,  14094336 bytes/sec

CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---

This patch seems fairly stable but I've only tested omap-sham (crypto)
and omap_hsmmc (mmc) on an am37x EVM.  I also enabled burst mode but
that made the system unstable when exercising either omap-sham or
omap_hsmmc.  I'm unaware of any errata that would make this an unwanted
modification but I haven't checked all of the SoCs.  Are there other
reasons that this should be applied??

The different types of hardware that I have is somewhat limited so if
you have some different platforms/SoCs, please give this patch a try.
It should apply cleanly against recent k.o. kernels.

Note that the current omap-sham driver doesn't use the dmaengine API
but I have a set of patches to convert it which is what I used when
testing.  I will submit those patches once they're ready (next day or so).
Also note that an am37xx GP actually does have sham hardware and yours
might too if you look closely.  If so, you'll have hack omap_sham_mod_init()
to use it.

Thanks,

Mark

 drivers/dma/omap-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bb2d8e7..aadddb2 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		dev_addr = c->cfg.dst_addr;
 		dev_width = c->cfg.dst_addr_width;
 		burst = c->cfg.dst_maxburst;
-		sync_type = OMAP_DMA_DST_SYNC;
+		sync_type = OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;
 	} else {
 		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
 		return NULL;
@@ -387,7 +387,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 		dev_addr = c->cfg.dst_addr;
 		dev_width = c->cfg.dst_addr_width;
 		burst = c->cfg.dst_maxburst;
-		sync_type = OMAP_DMA_DST_SYNC;
+		sync_type = OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;
 	} else {
 		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
 		return NULL;
-- 
1.7.12

