From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] ARM: OMAP: Get available DMA channels from cmdline
Date: Wed, 04 Mar 2009 13:53:38 -0800
Message-ID: <20090304215338.21101.39176.stgit@localhost>
References: <20090304214540.21101.72079.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59503 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbZCDVxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 16:53:43 -0500
In-Reply-To: <20090304214540.21101.72079.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Nishant Kamat <nskamat@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch set up a cmdline option for omap dma for masking the
available channels. It is needed since the OMAP DMA is a system wide
resource and can be used by another software apart from the kernel.

To reserve the omap SDMA channels for kernel dma usage, use cmdline
bootarg "omap_dma_reserve_ch=". The valid range is 1 to 32.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Nishant Kamat <nskamat@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 47ec77a..eca43bb 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -123,6 +123,7 @@ static struct dma_link_info *dma_linked_lch;
 
 static int dma_lch_count;
 static int dma_chan_count;
+static int omap_dma_reserve_channels;
 
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
@@ -2321,6 +2322,10 @@ static int __init omap_init_dma(void)
 		return -ENODEV;
 	}
 
+	if (cpu_class_is_omap2() && omap_dma_reserve_channels
+			&& (omap_dma_reserve_channels <= dma_lch_count))
+		dma_lch_count = omap_dma_reserve_channels;
+
 	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
 				GFP_KERNEL);
 	if (!dma_chan)
@@ -2371,7 +2376,7 @@ static int __init omap_init_dma(void)
 		u8 revision = dma_read(REVISION) & 0xff;
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
-		dma_chan_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+		dma_chan_count = dma_lch_count;
 	} else {
 		dma_chan_count = 0;
 		return 0;
@@ -2437,4 +2442,17 @@ static int __init omap_init_dma(void)
 
 arch_initcall(omap_init_dma);
 
+/*
+ * Reserve the omap SDMA channels using cmdline bootarg
+ * "omap_dma_reserve_ch=". The valid range is 1 to 32
+ */
+static int __init omap_dma_cmdline_reserve_ch(char *str)
+{
+	if (get_option(&str, &omap_dma_reserve_channels) != 1)
+		omap_dma_reserve_channels = 0;
+	return 1;
+}
+
+__setup("omap_dma_reserve_ch=", omap_dma_cmdline_reserve_ch);
+
 

