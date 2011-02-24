From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 3/3] OMAP: PM: DMA: Enable runtime pm
Date: Thu, 24 Feb 2011 15:44:35 +0530
Message-ID: <1298542475-1460-4-git-send-email-manjugk@ti.com>
References: <1298542475-1460-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35493 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755663Ab1BXKRS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 05:17:18 -0500
In-Reply-To: <1298542475-1460-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com

From: Manjunath G Kondaiah <manjugk@ti.com>

Enable runtime pm and use pm_runtime_get_sync and pm_runtime_put_autosuspend
for OMAP DMA driver.

The DMA driver uses auto suspend feature of runtime pm framework through
which the clock gets disabled automatically if there is no activity for
more than one second.

Testing:
Compile: omap1_defconfig and omap2plus_defconfig
Boot: OMAP1710(H3), OMAP2420(H4), OMAP3430LDP(Zoom2), OMAP3630(Zoom3), OMAP4(Blaze)

The DMA tests(including chaining) are executed and tested for suspend state
after each test cases.

On zoom2 core retention is tested with following steps:
echo 1 > /debug/pm_debug/sleep_while_idle
echo 1 > /debug/pm_debug/enable_off_mode
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/plat-omap/dma.c |  150 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 84879eb..92e18e3 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -35,6 +35,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/system.h>
 #include <mach/hardware.h>
@@ -60,6 +61,7 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
 static struct omap_system_dma_plat_info *p;
 static struct omap_dma_dev_attr *d;
+static struct device *dev;
 
 static int enable_1510_mode;
 static u32 errata;
@@ -172,6 +174,7 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 	unsigned long reg;
 	u32 l;
 
+	pm_runtime_get_sync(dev);
 	if (cpu_class_is_omap1()) {
 		switch (dst_port) {
 		case OMAP_DMA_PORT_OCP_T1:	/* FFFECC00 */
@@ -188,6 +191,7 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 			break;
 		default:
 			BUG();
+			pm_runtime_put_autosuspend(dev);
 			return;
 		}
 		l = omap_readl(reg);
@@ -206,6 +210,7 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 			ccr &= ~(1 << 6);
 		p->dma_write(ccr, CCR, lch);
 	}
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_priority);
 
@@ -215,6 +220,8 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 {
 	u32 l;
 
+	pm_runtime_get_sync(dev);
+
 	l = p->dma_read(CSDP, lch);
 	l &= ~0x03;
 	l |= data_type;
@@ -269,6 +276,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 
 	p->dma_write(elem_count, CEN, lch);
 	p->dma_write(frame_count, CFN, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
@@ -276,6 +284,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 {
 	BUG_ON(omap_dma_in_1510_mode());
 
+	pm_runtime_get_sync(dev);
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
@@ -329,11 +338,13 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 		color &= 0xffffff;
 		p->dma_write(color, COLOR, lch);
 	}
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_color_mode);
 
 void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 {
+	pm_runtime_get_sync(dev);
 	if (cpu_class_is_omap2()) {
 		u32 csdp;
 
@@ -342,11 +353,13 @@ void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 		csdp |= (mode << 16);
 		p->dma_write(csdp, CSDP, lch);
 	}
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_write_mode);
 
 void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
 {
+	pm_runtime_get_sync(dev);
 	if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
 		u32 l;
 
@@ -355,6 +368,7 @@ void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
 		l |= mode;
 		p->dma_write(l, LCH_CTRL, lch);
 	}
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_channel_mode);
 
@@ -365,6 +379,8 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 {
 	u32 l;
 
+	pm_runtime_get_sync(dev);
+
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
@@ -383,11 +399,13 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 
 	p->dma_write(src_ei, CSEI, lch);
 	p->dma_write(src_fi, CSFI, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
 
 void omap_set_dma_params(int lch, struct omap_dma_channel_params *params)
 {
+	pm_runtime_get_sync(dev);
 	omap_set_dma_transfer_params(lch, params->data_type,
 				     params->elem_count, params->frame_count,
 				     params->sync_mode, params->trigger,
@@ -402,6 +420,7 @@ void omap_set_dma_params(int lch, struct omap_dma_channel_params *params)
 	if (params->read_prio || params->write_prio)
 		omap_dma_set_prio_lch(lch, params->read_prio,
 				      params->write_prio);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_params);
 
@@ -410,8 +429,10 @@ void omap_set_dma_src_index(int lch, int eidx, int fidx)
 	if (cpu_class_is_omap2())
 		return;
 
+	pm_runtime_get_sync(dev);
 	p->dma_write(eidx, CSEI, lch);
 	p->dma_write(fidx, CSFI, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_src_index);
 
@@ -419,11 +440,13 @@ void omap_set_dma_src_data_pack(int lch, int enable)
 {
 	u32 l;
 
+	pm_runtime_get_sync(dev);
 	l = p->dma_read(CSDP, lch);
 	l &= ~(1 << 6);
 	if (enable)
 		l |= (1 << 6);
 	p->dma_write(l, CSDP, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_src_data_pack);
 
@@ -432,6 +455,7 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	unsigned int burst = 0;
 	u32 l;
 
+	pm_runtime_get_sync(dev);
 	l = p->dma_read(CSDP, lch);
 	l &= ~(0x03 << 7);
 
@@ -469,6 +493,7 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 
 	l |= (burst << 7);
 	p->dma_write(l, CSDP, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
 
@@ -478,6 +503,7 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 			      int dst_ei, int dst_fi)
 {
 	u32 l;
+	pm_runtime_get_sync(dev);
 
 	if (cpu_class_is_omap1()) {
 		l = p->dma_read(CSDP, lch);
@@ -495,6 +521,7 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 
 	p->dma_write(dst_ei, CDEI, lch);
 	p->dma_write(dst_fi, CDFI, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
 
@@ -502,21 +529,25 @@ void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 {
 	if (cpu_class_is_omap2())
 		return;
+	pm_runtime_get_sync(dev);
 
 	p->dma_write(eidx, CDEI, lch);
 	p->dma_write(fidx, CDFI, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_index);
 
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
 	u32 l;
+	pm_runtime_get_sync(dev);
 
 	l = p->dma_read(CSDP, lch);
 	l &= ~(1 << 13);
 	if (enable)
 		l |= 1 << 13;
 	p->dma_write(l, CSDP, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
 
@@ -524,6 +555,7 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
 	unsigned int burst = 0;
 	u32 l;
+	pm_runtime_get_sync(dev);
 
 	l = p->dma_read(CSDP, lch);
 	l &= ~(0x03 << 14);
@@ -555,10 +587,12 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	default:
 		printk(KERN_ERR "Invalid DMA burst mode\n");
 		BUG();
+		pm_runtime_put_autosuspend(dev);
 		return;
 	}
 	l |= (burst << 14);
 	p->dma_write(l, CSDP, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
@@ -566,6 +600,7 @@ static inline void omap_enable_channel_irq(int lch)
 {
 	u32 status;
 
+	pm_runtime_get_sync(dev);
 	/* Clear CSR */
 	if (cpu_class_is_omap1())
 		status = p->dma_read(CSR, lch);
@@ -574,12 +609,15 @@ static inline void omap_enable_channel_irq(int lch)
 
 	/* Enable some nice interrupts. */
 	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static void omap_disable_channel_irq(int lch)
 {
+	pm_runtime_get_sync(dev);
 	if (cpu_class_is_omap2())
 		p->dma_write(0, CICR, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 
 void omap_enable_dma_irq(int lch, u16 bits)
@@ -597,6 +635,7 @@ EXPORT_SYMBOL(omap_disable_dma_irq);
 static inline void enable_lnk(int lch)
 {
 	u32 l;
+	pm_runtime_get_sync(dev);
 
 	l = p->dma_read(CLNK_CTRL, lch);
 
@@ -614,12 +653,14 @@ static inline void enable_lnk(int lch)
 #endif
 
 	p->dma_write(l, CLNK_CTRL, lch);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static inline void disable_lnk(int lch)
 {
 	u32 l;
 
+	pm_runtime_get_sync(dev);
 	l = p->dma_read(CLNK_CTRL, lch);
 
 	/* Disable interrupts */
@@ -637,6 +678,7 @@ static inline void disable_lnk(int lch)
 
 	p->dma_write(l, CLNK_CTRL, lch);
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
+	pm_runtime_put_autosuspend(dev);
 }
 
 static inline void omap2_enable_irq_lch(int lch)
@@ -647,11 +689,13 @@ static inline void omap2_enable_irq_lch(int lch)
 	if (!cpu_class_is_omap2())
 		return;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	val = p->dma_read(IRQENABLE_L0, lch);
 	val |= 1 << lch;
 	p->dma_write(val, IRQENABLE_L0, lch);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static inline void omap2_disable_irq_lch(int lch)
@@ -662,11 +706,13 @@ static inline void omap2_disable_irq_lch(int lch)
 	if (!cpu_class_is_omap2())
 		return;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	val = p->dma_read(IRQENABLE_L0, lch);
 	val &= ~(1 << lch);
 	p->dma_write(val, IRQENABLE_L0, lch);
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
+	pm_runtime_put_autosuspend(dev);
 }
 
 int omap_request_dma(int dev_id, const char *dev_name,
@@ -677,6 +723,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	unsigned long flags;
 	struct omap_dma_lch *chan;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
@@ -687,6 +734,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	}
 	if (free_ch == -1) {
 		spin_unlock_irqrestore(&dma_chan_lock, flags);
+		pm_runtime_put_autosuspend(dev);
 		return -EBUSY;
 	}
 	chan = dma_chan + free_ch;
@@ -744,6 +792,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	}
 
 	*dma_ch_out = free_ch;
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -758,7 +807,7 @@ void omap_free_dma(int lch)
 		       lch);
 		return;
 	}
-
+	pm_runtime_get_sync(dev);
 	if (cpu_class_is_omap1()) {
 		/* Disable all DMA interrupts for the channel. */
 		p->dma_write(0, CICR, lch);
@@ -780,7 +829,7 @@ void omap_free_dma(int lch)
 		p->dma_write(0, CCR, lch);
 		omap_clear_dma(lch);
 	}
-
+	pm_runtime_put_autosuspend(dev);
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
@@ -818,7 +867,9 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 	reg |= (0x3 & tparams) << 12;
 	reg |= (arb_rate & 0xff) << 16;
 
+	pm_runtime_get_sync(dev);
 	p->dma_write(reg, GCR, 0);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_dma_set_global_params);
 
@@ -841,6 +892,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		printk(KERN_ERR "Invalid channel id\n");
 		return -EINVAL;
 	}
+	pm_runtime_get_sync(dev);
 	l = p->dma_read(CCR, lch);
 	l &= ~((1 << 6) | (1 << 26));
 	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
@@ -849,6 +901,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		l |= ((read_prio & 0x1) << 6);
 
 	p->dma_write(l, CCR, lch);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -862,9 +915,11 @@ void omap_clear_dma(int lch)
 {
 	unsigned long flags;
 
+	pm_runtime_get_sync(dev);
 	local_irq_save(flags);
 	p->clear_dma(lch);
 	local_irq_restore(flags);
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_clear_dma);
 
@@ -872,6 +927,8 @@ void omap_start_dma(int lch)
 {
 	u32 l;
 
+	pm_runtime_get_sync(dev);
+
 	/*
 	 * The CPC/CDAC register needs to be initialized to zero
 	 * before starting dma transfer.
@@ -927,6 +984,7 @@ void omap_stop_dma(int lch)
 	u32 l;
 	unsigned long flags;
 
+	pm_runtime_get_sync(dev);
 	/* Disable all interrupts on the channel */
 	if (cpu_class_is_omap1())
 		p->dma_write(0, CICR, lch);
@@ -989,6 +1047,7 @@ void omap_stop_dma(int lch)
 	}
 
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_stop_dma);
 
@@ -1031,6 +1090,7 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 {
 	dma_addr_t offset = 0;
 
+	pm_runtime_get_sync(dev);
 	if (cpu_is_omap15xx())
 		offset = p->dma_read(CPC, lch);
 	else
@@ -1042,6 +1102,7 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 	if (cpu_class_is_omap1())
 		offset |= (p->dma_read(CSSA, lch) & 0xFFFF0000);
 
+	pm_runtime_put_autosuspend(dev);
 	return offset;
 }
 EXPORT_SYMBOL(omap_get_dma_src_pos);
@@ -1058,6 +1119,7 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 {
 	dma_addr_t offset = 0;
 
+	pm_runtime_get_sync(dev);
 	if (cpu_is_omap15xx())
 		offset = p->dma_read(CPC, lch);
 	else
@@ -1073,13 +1135,20 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 	if (cpu_class_is_omap1())
 		offset |= (p->dma_read(CDSA, lch) & 0xFFFF0000);
 
+	pm_runtime_put_autosuspend(dev);
 	return offset;
 }
 EXPORT_SYMBOL(omap_get_dma_dst_pos);
 
 int omap_get_dma_active_status(int lch)
 {
-	return (p->dma_read(CCR, lch) & OMAP_DMA_CCR_EN) != 0;
+	u32 reg_data;
+
+	pm_runtime_get_sync(dev);
+	reg_data = p->dma_read(CCR, lch);
+	pm_runtime_put_autosuspend(dev);
+	reg_data &= reg_data & OMAP_DMA_CCR_EN;
+	return ((reg_data != 0) ? 1 : 0);
 }
 EXPORT_SYMBOL(omap_get_dma_active_status);
 
@@ -1087,14 +1156,20 @@ int omap_dma_running(void)
 {
 	int lch;
 
+	pm_runtime_get_sync(dev);
 	if (cpu_class_is_omap1())
-		if (omap_lcd_dma_running())
+		if (omap_lcd_dma_running()) {
+			pm_runtime_put_autosuspend(dev);
 			return 1;
+		}
 
 	for (lch = 0; lch < dma_chan_count; lch++)
-		if (p->dma_read(CCR, lch) & OMAP_DMA_CCR_EN)
+		if (p->dma_read(CCR, lch) & OMAP_DMA_CCR_EN) {
+			pm_runtime_put_autosuspend(dev);
 			return 1;
+		}
 
+	pm_runtime_put_autosuspend(dev);
 	return 0;
 }
 
@@ -1105,12 +1180,15 @@ int omap_dma_running(void)
  */
 void omap_dma_link_lch(int lch_head, int lch_queue)
 {
+	pm_runtime_get_sync(dev);
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
 			p->dma_write(p->dma_read(CCR, lch_head) | (3 << 8),
 								CCR, lch_head);
+			pm_runtime_put_autosuspend(dev);
 			return;
 		}
+		pm_runtime_put_autosuspend(dev);
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
 		BUG();
 		return;
@@ -1124,6 +1202,7 @@ void omap_dma_link_lch(int lch_head, int lch_queue)
 	}
 
 	dma_chan[lch_head].next_lch = lch_queue;
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_dma_link_lch);
 
@@ -1132,12 +1211,15 @@ EXPORT_SYMBOL(omap_dma_link_lch);
  */
 void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
+	pm_runtime_get_sync(dev);
 	if (omap_dma_in_1510_mode()) {
 		if (lch_head == lch_queue) {
 			p->dma_write(p->dma_read(CCR, lch_head) & ~(3 << 8),
 								CCR, lch_head);
+			pm_runtime_put_autosuspend(dev);
 			return;
 		}
+		pm_runtime_put_autosuspend(dev);
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
 		BUG();
 		return;
@@ -1158,6 +1240,7 @@ void omap_dma_unlink_lch(int lch_head, int lch_queue)
 	}
 
 	dma_chan[lch_head].next_lch = -1;
+	pm_runtime_put_autosuspend(dev);
 }
 EXPORT_SYMBOL(omap_dma_unlink_lch);
 
@@ -1167,6 +1250,7 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 {
 	u32 l;
 
+	pm_runtime_get_sync(dev);
 	/* Check if this is the first link in chain */
 	if (dma_chan[lch_head].next_linked_ch == -1) {
 		dma_chan[lch_head].next_linked_ch = lch_queue;
@@ -1194,6 +1278,7 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
 	l &= ~(0x1f);
 	l |= (dma_chan[lch_queue].next_linked_ch);
 	p->dma_write(l, CLNK_CTRL, lch_queue);
+	pm_runtime_put_autosuspend(dev);
 }
 
 /**
@@ -1467,6 +1552,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 	/* Increment the q_tail */
 	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
 
+	pm_runtime_get_sync(dev);
 	/* Set the params to the free channel */
 	if (src_start != 0)
 		p->dma_write(src_start, CSSA, lch);
@@ -1546,6 +1632,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
 	}
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -1586,6 +1673,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 		omap_enable_channel_irq(channels[0]);
 	}
 
+	pm_runtime_get_sync(dev);
 	l = p->dma_read(CCR, channels[0]);
 	l |= (1 << 7);
 	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
@@ -1599,6 +1687,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 
 	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
 
+	pm_runtime_put_autosuspend(dev);
 	return 0;
 }
 EXPORT_SYMBOL(omap_start_dma_chain_transfers);
@@ -1630,6 +1719,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	}
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
+	pm_runtime_get_sync(dev);
 	if (IS_DMA_ERRATA(DMA_ERRATA_i88) && p->midlemode) {
 		spin_lock_irqsave(&dma_chan_lock, flags);
 		p->midlemode(true);
@@ -1658,6 +1748,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 		p->midlemode(false);
 		spin_unlock_irqrestore(&dma_chan_lock, flags);
 	}
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -1691,16 +1782,19 @@ int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
 		printk(KERN_ERR "Chain doesn't exists\n");
 		return -EINVAL;
 	}
-	if ((!ei) || (!fi))
+	if ((!ei) || (!fi)) {
 		return -EINVAL;
+	}
 
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
+	pm_runtime_get_sync(dev);
 	*ei = p->dma_read(CCEN, lch);
 	*fi = p->dma_read(CCFN, lch);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -1719,6 +1813,7 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 {
 	int lch;
 	int *channels;
+	int reg_data;
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
@@ -1737,7 +1832,10 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return p->dma_read(CDAC, lch);
+	pm_runtime_get_sync(dev);
+	reg_data = p->dma_read(CDAC, lch);
+	pm_runtime_put_autosuspend(dev);
+	return reg_data;
 }
 EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
 
@@ -1753,6 +1851,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 {
 	int lch;
 	int *channels;
+	int reg_data;
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
@@ -1771,7 +1870,10 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	/* Get the current channel */
 	lch = channels[dma_linked_lch[chain_id].q_head];
 
-	return p->dma_read(CSAC, lch);
+	pm_runtime_get_sync(dev);
+	reg_data = p->dma_read(CSAC, lch);
+	pm_runtime_put_autosuspend(dev);
+	return reg_data;
 }
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */
@@ -1811,6 +1913,8 @@ static int omap1_dma_handle_ch(int ch)
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return 1;
 }
 
@@ -1895,8 +1999,11 @@ static int omap2_dma_handle_ch(int ch)
 						OMAP_DMA_DYNAMIC_CHAIN)
 			disable_lnk(ch);
 
-		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
+		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id)) {
 			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
+			pm_runtime_get_sync(dev);
+		}
+
 
 		status = p->dma_read(CSR, ch);
 		p->dma_write(status, CSR, ch);
@@ -1905,6 +2012,8 @@ static int omap2_dma_handle_ch(int ch)
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return 0;
 }
 
@@ -1945,17 +2054,20 @@ static struct irqaction omap24xx_dma_irq;
 
 void omap_dma_global_context_save(void)
 {
+	pm_runtime_get_sync(dev);
 	omap_dma_global_context.dma_irqenable_l0 =
 		p->dma_read(IRQENABLE_L0, 0);
 	omap_dma_global_context.dma_ocp_sysconfig =
 		p->dma_read(OCP_SYSCONFIG, 0);
 	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
+	pm_runtime_put_autosuspend(dev);
 }
 
 void omap_dma_global_context_restore(void)
 {
 	int ch;
 
+	pm_runtime_get_sync(dev);
 	p->dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
 	p->dma_write(omap_dma_global_context.dma_ocp_sysconfig,
 		OCP_SYSCONFIG, 0);
@@ -1968,6 +2080,7 @@ void omap_dma_global_context_restore(void)
 	for (ch = 0; ch < dma_chan_count; ch++)
 		if (dma_chan[ch].dev_id != -1)
 			omap_clear_dma(ch);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static int __devinit omap_system_dma_probe(struct platform_device *pdev)
@@ -1984,6 +2097,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	dev			= &pdev->dev;
 	d			= p->dma_attr;
 	errata			= p->errata;
 
@@ -2005,6 +2119,11 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	spin_lock_init(&dma_chan_lock);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
@@ -2070,6 +2189,16 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 		dma_chan[1].dev_id = 1;
 	}
 	p->show_dma_caps();
+
+	/*
+	 * Note: If dma channels are reserved through boot paramters,
+	 * then dma device is always enabled.
+	 */
+	if (omap_dma_reserve_channels)
+		pm_runtime_get(dev);
+
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 exit_dma_irq_fail:
@@ -2091,6 +2220,9 @@ static int __devexit omap_system_dma_remove(struct platform_device *pdev)
 {
 	int dma_irq;
 
+	if (omap_dma_reserve_channels)
+		pm_runtime_put_autosuspend(dev);
+
 	if (cpu_class_is_omap2()) {
 		char irq_name[4];
 		strcpy(irq_name, "0");
-- 
1.7.1

