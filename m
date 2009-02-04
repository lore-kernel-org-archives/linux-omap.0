From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP: sDMA: DMA channel reservation using bootargs
Date: Wed, 4 Feb 2009 14:38:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A3E3D868@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48398 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZBDJJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 04:09:13 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,
Here is the first patch as promised.

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

    This patch set up a cmdline option for omap dma for masking the
    available channels. It is needed since the OMAP DMA is a system wide
    resource and can be used by another software apart from the kernel.

    To reserve the omap SDMA channels for kernel dma usage, use cmdline
    bootarg "omap_dma_reserve_ch=". The valid range is 1 to 32.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked By: Nishant Kamat <nskamat@ti.com>
cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletion(-)

Index: omapkernel/arch/arm/plat-omap/dma.c
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/dma.c	2009-02-04 12:11:55.779687209 +0530
+++ omapkernel/arch/arm/plat-omap/dma.c	2009-02-04 14:05:32.971853579 +0530
@@ -131,6 +131,7 @@ static struct dma_link_info *dma_linked_
 
 static int dma_lch_count;
 static int dma_chan_count;
+static int omap_dma_reserve_channels;
 
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch *dma_chan;
@@ -2409,6 +2410,10 @@ static int __init omap_init_dma(void)
 		return -ENODEV;
 	}
 
+	if (cpu_class_is_omap2() && omap_dma_reserve_channels
+			&& (omap_dma_reserve_channels <= dma_lch_count))
+		dma_lch_count = omap_dma_reserve_channels;
+
 	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
 				GFP_KERNEL);
 	if (!dma_chan)
@@ -2459,7 +2464,7 @@ static int __init omap_init_dma(void)
 		u8 revision = dma_read(REVISION) & 0xff;
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
-		dma_chan_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+		dma_chan_count = dma_lch_count;
 	} else {
 		dma_chan_count = 0;
 		return 0;
@@ -2525,4 +2530,17 @@ static int __init omap_init_dma(void)
 
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
 

Regards,
Santosh
