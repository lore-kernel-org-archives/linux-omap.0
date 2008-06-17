From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/21] ARM: OMAP: DMA: Clean-up code
Date: Tue, 17 Jun 2008 10:27:11 +0300
Message-ID: <20080617072710.GC13078@atomide.com>
References: <1212802253-17797-1-git-send-email-tony@atomide.com> <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <20080614081324.GJ32122@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0lnxQi9hkpPO77W3"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55742 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYFQH0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 03:26:43 -0400
Content-Disposition: inline
In-Reply-To: <20080614081324.GJ32122@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 11:13]:
> On Fri, Jun 06, 2008 at 06:30:38PM -0700, Tony Lindgren wrote:
> > @@ -431,8 +474,8 @@ struct omap_dma_channel_params {
> >  
> >  extern void omap_set_dma_priority(int lch, int dst_port, int priority);
> >  extern int omap_request_dma(int dev_id, const char *dev_name,
> > -			    void (* callback)(int lch, u16 ch_status, void *data),
> > -			    void *data, int *dma_ch);
> > +				void (*callback)(int lch, u16 ch_status,
> > +				void *data), void *data, int *dma_ch);
> 
> This is an example where checkpatch is not entirely correct - wrapping
> the 'callback' type makes it less readable.  Just let it flow over column
> 80, or maybe use:
> 
> 				void (*callback)(int, u16, void *),
> 
> since all we actually need there is the type of the callback.

Looks like this wrapping can be avoided by decreasing the indentation
instead. Updated patch following.

Tony

--0lnxQi9hkpPO77W3
Content-Type: text/x-diff; charset=iso-8859-1
Content-Disposition: inline; filename="0006-omap-dma-clean.patch"
Content-Transfer-Encoding: 8bit

>From a3b3b29797764b0a117d52c8105738f87be18f9a Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 17 Jun 2008 10:24:57 +0300
Subject: [PATCH] ARM: OMAP: DMA: Clean-up code

DMA clean-up, mostly checkpatch.pl fixes.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 18e757a..fac8e99 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/plat-omap/dma.c
  *
- * Copyright (C) 2003 Nokia Corporation
+ * Copyright (C) 2003 - 2008 Nokia Corporation
  * Author: Juha Yrjölä <juha.yrjola@nokia.com>
  * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.com>
  * Graphics DMA and LCD DMA graphics tranformations
@@ -25,11 +25,11 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/io.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
 #include <asm/dma.h>
-#include <asm/io.h>
 
 #include <asm/arch/tc.h>
 
@@ -43,13 +43,13 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
 enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #endif
 
-#define OMAP_DMA_ACTIVE		0x01
-#define OMAP_DMA_CCR_EN		(1 << 7)
+#define OMAP_DMA_ACTIVE			0x01
+#define OMAP_DMA_CCR_EN			(1 << 7)
 #define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
 
-#define OMAP_FUNC_MUX_ARM_BASE	(0xfffe1000 + 0xec)
+#define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
 
-static int enable_1510_mode = 0;
+static int enable_1510_mode;
 
 struct omap_dma_lch {
 	int next_lch;
@@ -57,7 +57,7 @@ struct omap_dma_lch {
 	u16 saved_csr;
 	u16 enabled_irqs;
 	const char *dev_name;
-	void (* callback)(int lch, u16 ch_status, void *data);
+	void (*callback)(int lch, u16 ch_status, void *data);
 	void *data;
 
 #ifndef CONFIG_ARCH_OMAP1
@@ -245,6 +245,7 @@ void omap_set_dma_priority(int lch, int dst_port, int priority)
 		dma_write(ccr, CCR(lch));
 	}
 }
+EXPORT_SYMBOL(omap_set_dma_priority);
 
 void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 				  int frame_count, int sync_mode,
@@ -307,6 +308,7 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 	dma_write(elem_count, CEN(lch));
 	dma_write(frame_count, CFN(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
 void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 {
@@ -346,6 +348,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
 	}
 	dma_write(w, LCH_CTRL(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_color_mode);
 
 void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 {
@@ -358,6 +361,7 @@ void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 		dma_write(csdp, CSDP(lch));
 	}
 }
+EXPORT_SYMBOL(omap_set_dma_write_mode);
 
 void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
 {
@@ -377,6 +381,8 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 			     unsigned long src_start,
 			     int src_ei, int src_fi)
 {
+	u32 l;
+
 	if (cpu_class_is_omap1()) {
 		u16 w;
 
@@ -384,34 +390,27 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 		w &= ~(0x1f << 2);
 		w |= src_port << 2;
 		dma_write(w, CSDP(lch));
+	}
 
-		w = dma_read(CCR(lch));
-		w &= ~(0x03 << 12);
-		w |= src_amode << 12;
-		dma_write(w, CCR(lch));
+	l = dma_read(CCR(lch));
+	l &= ~(0x03 << 12);
+	l |= src_amode << 12;
+	dma_write(l, CCR(lch));
 
+	if (cpu_class_is_omap1()) {
 		dma_write(src_start >> 16, CSSA_U(lch));
 		dma_write((u16)src_start, CSSA_L(lch));
-
-		dma_write(src_ei, CSEI(lch));
-		dma_write(src_fi, CSFI(lch));
 	}
 
-	if (cpu_class_is_omap2()) {
-		u32 l;
-
-		l = dma_read(CCR(lch));
-		l &= ~(0x03 << 12);
-		l |= src_amode << 12;
-		dma_write(l, CCR(lch));
-
+	if (cpu_class_is_omap2())
 		dma_write(src_start, CSSA(lch));
-		dma_write(src_ei, CSEI(lch));
-		dma_write(src_fi, CSFI(lch));
-	}
+
+	dma_write(src_ei, CSEI(lch));
+	dma_write(src_fi, CSFI(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_src_params);
 
-void omap_set_dma_params(int lch, struct omap_dma_channel_params * params)
+void omap_set_dma_params(int lch, struct omap_dma_channel_params *params)
 {
 	omap_set_dma_transfer_params(lch, params->data_type,
 				     params->elem_count, params->frame_count,
@@ -428,16 +427,17 @@ void omap_set_dma_params(int lch, struct omap_dma_channel_params * params)
 		omap_dma_set_prio_lch(lch, params->read_prio,
 				      params->write_prio);
 }
+EXPORT_SYMBOL(omap_set_dma_params);
 
 void omap_set_dma_src_index(int lch, int eidx, int fidx)
 {
-	if (cpu_class_is_omap2()) {
-		REVISIT_24XX();
+	if (cpu_class_is_omap2())
 		return;
-	}
+
 	dma_write(eidx, CSEI(lch));
 	dma_write(fidx, CSFI(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_src_index);
 
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
@@ -449,6 +449,7 @@ void omap_set_dma_src_data_pack(int lch, int enable)
 		l |= (1 << 6);
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_src_data_pack);
 
 void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
@@ -491,6 +492,7 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	l |= (burst << 7);
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
 
 /* Note that dest_port is only for OMAP1 */
 void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
@@ -522,16 +524,17 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 	dma_write(dst_ei, CDEI(lch));
 	dma_write(dst_fi, CDFI(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_dest_params);
 
 void omap_set_dma_dest_index(int lch, int eidx, int fidx)
 {
-	if (cpu_class_is_omap2()) {
-		REVISIT_24XX();
+	if (cpu_class_is_omap2())
 		return;
-	}
+
 	dma_write(eidx, CDEI(lch));
 	dma_write(fidx, CDFI(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_dest_index);
 
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
@@ -543,6 +546,7 @@ void omap_set_dma_dest_data_pack(int lch, int enable)
 		l |= 1 << 13;
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
 
 void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 {
@@ -583,6 +587,7 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
 	l |= (burst << 14);
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
 
 static inline void omap_enable_channel_irq(int lch)
 {
@@ -608,11 +613,13 @@ void omap_enable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs |= bits;
 }
+EXPORT_SYMBOL(omap_enable_dma_irq);
 
 void omap_disable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs &= ~bits;
 }
+EXPORT_SYMBOL(omap_disable_dma_irq);
 
 static inline void enable_lnk(int lch)
 {
@@ -628,8 +635,9 @@ static inline void enable_lnk(int lch)
 		l = dma_chan[lch].next_lch | (1 << 15);
 
 #ifndef CONFIG_ARCH_OMAP1
-	if (dma_chan[lch].next_linked_ch != -1)
-		l = dma_chan[lch].next_linked_ch | (1 << 15);
+	if (cpu_class_is_omap2())
+		if (dma_chan[lch].next_linked_ch != -1)
+			l = dma_chan[lch].next_linked_ch | (1 << 15);
 #endif
 
 	dma_write(l, CLNK_CTRL(lch));
@@ -671,7 +679,7 @@ static inline void omap2_enable_irq_lch(int lch)
 }
 
 int omap_request_dma(int dev_id, const char *dev_name,
-		     void (* callback)(int lch, u16 ch_status, void *data),
+		     void (*callback)(int lch, u16 ch_status, void *data),
 		     void *data, int *dma_ch_out)
 {
 	int ch, free_ch = -1;
@@ -704,10 +712,14 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan->dev_name = dev_name;
 	chan->callback = callback;
 	chan->data = data;
+
 #ifndef CONFIG_ARCH_OMAP1
-	chan->chain_id = -1;
-	chan->next_linked_ch = -1;
+	if (cpu_class_is_omap2()) {
+		chan->chain_id = -1;
+		chan->next_linked_ch = -1;
+	}
 #endif
+
 	chan->enabled_irqs = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
 
 	if (cpu_class_is_omap1())
@@ -722,8 +734,10 @@ int omap_request_dma(int dev_id, const char *dev_name,
 			set_gdma_dev(free_ch + 1, dev_id);
 			dev_id = free_ch + 1;
 		}
-		/* Disable the 1510 compatibility mode and set the sync device
-		 * id. */
+		/*
+		 * Disable the 1510 compatibility mode and set the sync device
+		 * id.
+		 */
 		dma_write(dev_id | (1 << 10), CCR(free_ch));
 	} else if (cpu_is_omap730() || cpu_is_omap15xx()) {
 		dma_write(dev_id, CCR(free_ch));
@@ -731,7 +745,6 @@ int omap_request_dma(int dev_id, const char *dev_name,
 
 	if (cpu_class_is_omap2()) {
 		omap2_enable_irq_lch(free_ch);
-
 		omap_enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
 		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(free_ch));
@@ -742,6 +755,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_request_dma);
 
 void omap_free_dma(int lch)
 {
@@ -749,11 +763,12 @@ void omap_free_dma(int lch)
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	if (dma_chan[lch].dev_id == -1) {
-		printk("omap_dma: trying to free nonallocated DMA channel %d\n",
+		pr_err("omap_dma: trying to free unallocated DMA channel %d\n",
 		       lch);
 		spin_unlock_irqrestore(&dma_chan_lock, flags);
 		return;
 	}
+
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
 	dma_chan[lch].callback = NULL;
@@ -785,6 +800,7 @@ void omap_free_dma(int lch)
 		omap_clear_dma(lch);
 	}
 }
+EXPORT_SYMBOL(omap_free_dma);
 
 /**
  * @brief omap_dma_set_global_params : Set global priority settings for dma
@@ -878,6 +894,7 @@ void omap_clear_dma(int lch)
 
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(omap_clear_dma);
 
 void omap_start_dma(int lch)
 {
@@ -916,8 +933,10 @@ void omap_start_dma(int lch)
 
 	l = dma_read(CCR(lch));
 
-	/* Errata: On ES2.0 BUFFERING disable must be set.
-	 * This will always fail on ES1.0 */
+	/*
+	 * Errata: On ES2.0 BUFFERING disable must be set.
+	 * This will always fail on ES1.0
+	 */
 	if (cpu_is_omap24xx())
 		l |= OMAP_DMA_CCR_EN;
 
@@ -926,6 +945,7 @@ void omap_start_dma(int lch)
 
 	dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 }
+EXPORT_SYMBOL(omap_start_dma);
 
 void omap_stop_dma(int lch)
 {
@@ -962,13 +982,14 @@ void omap_stop_dma(int lch)
 
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
+EXPORT_SYMBOL(omap_stop_dma);
 
 /*
  * Allows changing the DMA callback function or data. This may be needed if
  * the driver shares a single DMA channel for multiple dma triggers.
  */
 int omap_set_dma_callback(int lch,
-			  void (* callback)(int lch, u16 ch_status, void *data),
+			  void (*callback)(int lch, u16 ch_status, void *data),
 			  void *data)
 {
 	unsigned long flags;
@@ -988,6 +1009,7 @@ int omap_set_dma_callback(int lch,
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_set_dma_callback);
 
 /*
  * Returns current physical source address for the given DMA channel.
@@ -1018,6 +1040,7 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 
 	return offset;
 }
+EXPORT_SYMBOL(omap_get_dma_src_pos);
 
 /*
  * Returns current physical destination address for the given DMA channel.
@@ -1048,16 +1071,7 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 
 	return offset;
 }
-
-/*
- * Returns current source transfer counting for the given DMA channel.
- * Can be used to monitor the progress of a transfer inside a block.
- * It must be called with disabled interrupts.
- */
-int omap_get_dma_src_addr_counter(int lch)
-{
-	return (dma_addr_t)dma_read(CSAC(lch));
-}
+EXPORT_SYMBOL(omap_get_dma_dst_pos);
 
 int omap_get_dma_active_status(int lch)
 {
@@ -1086,7 +1100,7 @@ int omap_dma_running(void)
  * For this DMA link to start, you still need to start (see omap_start_dma)
  * the first one. That will fire up the entire queue.
  */
-void omap_dma_link_lch (int lch_head, int lch_queue)
+void omap_dma_link_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1103,11 +1117,12 @@ void omap_dma_link_lch (int lch_head, int lch_queue)
 
 	dma_chan[lch_head].next_lch = lch_queue;
 }
+EXPORT_SYMBOL(omap_dma_link_lch);
 
 /*
  * Once the DMA queue is stopped, we can destroy it.
  */
-void omap_dma_unlink_lch (int lch_head, int lch_queue)
+void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1122,7 +1137,6 @@ void omap_dma_unlink_lch (int lch_head, int lch_queue)
 		dump_stack();
 	}
 
-
 	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
 	    (dma_chan[lch_head].flags & OMAP_DMA_ACTIVE)) {
 		printk(KERN_ERR "omap_dma: You need to stop the DMA channels "
@@ -1132,6 +1146,9 @@ void omap_dma_unlink_lch (int lch_head, int lch_queue)
 
 	dma_chan[lch_head].next_lch = -1;
 }
+EXPORT_SYMBOL(omap_dma_unlink_lch);
+
+/*----------------------------------------------------------------------------*/
 
 #ifndef CONFIG_ARCH_OMAP1
 /* Create chain of DMA channesls */
@@ -1255,6 +1272,7 @@ int omap_request_dma_chain(int dev_id, const char *dev_name,
 		for (i = 0; i < (no_of_chans - 1); i++)
 			create_dma_lch_chain(channels[i], channels[i + 1]);
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_request_dma_chain);
@@ -1297,6 +1315,7 @@ int omap_modify_dma_chain_params(int chain_id,
 		 */
 		omap_set_dma_params(channels[i], &params);
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_modify_dma_chain_params);
@@ -1340,6 +1359,7 @@ int omap_free_dma_chain(int chain_id)
 	dma_linked_lch[chain_id].linked_dmach_q = NULL;
 	dma_linked_lch[chain_id].chain_mode = -1;
 	dma_linked_lch[chain_id].chain_state = -1;
+
 	return (0);
 }
 EXPORT_SYMBOL(omap_free_dma_chain);
@@ -1370,6 +1390,7 @@ int omap_dma_chain_status(int chain_id)
 
 	if (OMAP_DMA_CHAIN_QEMPTY(chain_id))
 		return OMAP_DMA_CHAIN_INACTIVE;
+
 	return OMAP_DMA_CHAIN_ACTIVE;
 }
 EXPORT_SYMBOL(omap_dma_chain_status);
@@ -1395,8 +1416,10 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 	u32 l, lch;
 	int start_dma = 0;
 
-	/* if buffer size is less than 1 then there is
-	 * no use of starting the chain */
+	/*
+	 * if buffer size is less than 1 then there is
+	 * no use of starting the chain
+	 */
 	if (elem_count < 1) {
 		printk(KERN_ERR "Invalid buffer size\n");
 		return -EINVAL;
@@ -1441,12 +1464,16 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 	dma_write(elem_count, CEN(lch));
 	dma_write(frame_count, CFN(lch));
 
-	/* If the chain is dynamically linked,
-	 * then we may have to start the chain if its not active */
+	/*
+	 * If the chain is dynamically linked,
+	 * then we may have to start the chain if its not active
+	 */
 	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_DYNAMIC_CHAIN) {
 
-		/* In Dynamic chain, if the chain is not started,
-		 * queue the channel */
+		/*
+		 * In Dynamic chain, if the chain is not started,
+		 * queue the channel
+		 */
 		if (dma_linked_lch[chain_id].chain_state ==
 						DMA_CHAIN_NOTSTARTED) {
 			/* Enable the link in previous channel */
@@ -1456,8 +1483,10 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			dma_chan[lch].state = DMA_CH_QUEUED;
 		}
 
-		/* Chain is already started, make sure its active,
-		 * if not then start the chain */
+		/*
+		 * Chain is already started, make sure its active,
+		 * if not then start the chain
+		 */
 		else {
 			start_dma = 1;
 
@@ -1504,6 +1533,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
 		}
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_dma_chain_a_transfer);
@@ -1555,6 +1585,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 	dma_write(l, CCR(channels[0]));
 
 	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_start_dma_chain_transfers);
@@ -1586,7 +1617,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	}
 	channels = dma_linked_lch[chain_id].linked_dmach_q;
 
-	/* DMA Errata:
+	/*
+	 * DMA Errata:
 	 * Special programming model needed to disable DMA before end of block
 	 */
 	sys_cf = dma_read(OCP_SYSCONFIG);
@@ -1614,6 +1646,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 
 	/* Errata - put in the old value */
 	dma_write(sys_cf, OCP_SYSCONFIG);
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
@@ -1729,7 +1762,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	return dma_read(CSAC(lch));
 }
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
-#endif
+#endif	/* ifndef CONFIG_ARCH_OMAP1 */
 
 /*----------------------------------------------------------------------------*/
 
@@ -1765,6 +1798,7 @@ static int omap1_dma_handle_ch(int ch)
 		dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
 	if (likely(dma_chan[ch].callback != NULL))
 		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
+
 	return 1;
 }
 
@@ -1799,7 +1833,8 @@ static int omap2_dma_handle_ch(int ch)
 
 	if (!status) {
 		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n", ch);
+			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
+				ch);
 		dma_write(1 << ch, IRQSTATUS_L0);
 		return 0;
 	}
@@ -1887,7 +1922,7 @@ static struct irqaction omap24xx_dma_irq;
 static struct lcd_dma_info {
 	spinlock_t lock;
 	int reserved;
-	void (* callback)(u16 status, void *data);
+	void (*callback)(u16 status, void *data);
 	void *cb_data;
 
 	int active;
@@ -1909,6 +1944,7 @@ void omap_set_lcd_dma_b1(unsigned long addr, u16 fb_xres, u16 fb_yres,
 	lcd_dma.xres = fb_xres;
 	lcd_dma.yres = fb_yres;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1);
 
 void omap_set_lcd_dma_src_port(int port)
 {
@@ -1919,12 +1955,13 @@ void omap_set_lcd_dma_ext_controller(int external)
 {
 	lcd_dma.ext_ctrl = external;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
 
 void omap_set_lcd_dma_single_transfer(int single)
 {
 	lcd_dma.single_transfer = single;
 }
-
+EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
 
 void omap_set_lcd_dma_b1_rotation(int rotate)
 {
@@ -1935,6 +1972,7 @@ void omap_set_lcd_dma_b1_rotation(int rotate)
 	}
 	lcd_dma.rotate = rotate;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
 
 void omap_set_lcd_dma_b1_mirror(int mirror)
 {
@@ -1944,6 +1982,7 @@ void omap_set_lcd_dma_b1_mirror(int mirror)
 	}
 	lcd_dma.mirror = mirror;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
 
 void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
 {
@@ -1954,6 +1993,7 @@ void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
 	}
 	lcd_dma.vxres = vxres;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
 
 void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscale)
 {
@@ -1964,6 +2004,7 @@ void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscale)
 	lcd_dma.xscale = xscale;
 	lcd_dma.yscale = yscale;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
 
 static void set_b1_regs(void)
 {
@@ -1994,8 +2035,11 @@ static void set_b1_regs(void)
 	xscale = lcd_dma.xscale ? lcd_dma.xscale : 1;
 	yscale = lcd_dma.yscale ? lcd_dma.yscale : 1;
 	BUG_ON(vxres < lcd_dma.xres);
-#define PIXADDR(x,y) (lcd_dma.addr + ((y) * vxres * yscale + (x) * xscale) * es)
+
+#define PIXADDR(x, y) (lcd_dma.addr +					\
+		((y) * vxres * yscale + (x) * xscale) * es)
 #define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) - es + 1)
+
 	switch (lcd_dma.rotate) {
 	case 0:
 		if (!lcd_dma.mirror) {
@@ -2004,8 +2048,8 @@ static void set_b1_regs(void)
 			/* 1510 DMA requires the bottom address to be 2 more
 			 * than the actual last memory access location. */
 			if (omap_dma_in_1510_mode() &&
-			    lcd_dma.data_type == OMAP_DMA_DATA_TYPE_S32)
-				bottom += 2;
+				lcd_dma.data_type == OMAP_DMA_DATA_TYPE_S32)
+					bottom += 2;
 			ei = PIXSTEP(0, 0, 1, 0);
 			fi = PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
 		} else {
@@ -2132,7 +2176,7 @@ static irqreturn_t lcd_dma_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-int omap_request_lcd_dma(void (* callback)(u16 status, void *data),
+int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
 			 void *data)
 {
 	spin_lock_irq(&lcd_dma.lock);
@@ -2158,6 +2202,7 @@ int omap_request_lcd_dma(void (* callback)(u16 status, void *data),
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_request_lcd_dma);
 
 void omap_free_lcd_dma(void)
 {
@@ -2174,12 +2219,14 @@ void omap_free_lcd_dma(void)
 	lcd_dma.reserved = 0;
 	spin_unlock(&lcd_dma.lock);
 }
+EXPORT_SYMBOL(omap_free_lcd_dma);
 
 void omap_enable_lcd_dma(void)
 {
 	u16 w;
 
-	/* Set the Enable bit only if an external controller is
+	/*
+	 * Set the Enable bit only if an external controller is
 	 * connected. Otherwise the OMAP internal controller will
 	 * start the transfer when it gets enabled.
 	 */
@@ -2196,6 +2243,7 @@ void omap_enable_lcd_dma(void)
 	w |= 1 << 7;
 	omap_writew(w, OMAP1610_DMA_LCD_CCR);
 }
+EXPORT_SYMBOL(omap_enable_lcd_dma);
 
 void omap_setup_lcd_dma(void)
 {
@@ -2211,16 +2259,18 @@ void omap_setup_lcd_dma(void)
 		u16 w;
 
 		w = omap_readw(OMAP1610_DMA_LCD_CCR);
-		/* If DMA was already active set the end_prog bit to have
+		/*
+		 * If DMA was already active set the end_prog bit to have
 		 * the programmed register set loaded into the active
 		 * register set.
 		 */
 		w |= 1 << 11;		/* End_prog */
 		if (!lcd_dma.single_transfer)
-	        	w |= (3 << 8);	/* Auto_init, repeat */
+			w |= (3 << 8);	/* Auto_init, repeat */
 		omap_writew(w, OMAP1610_DMA_LCD_CCR);
 	}
 }
+EXPORT_SYMBOL(omap_setup_lcd_dma);
 
 void omap_stop_lcd_dma(void)
 {
@@ -2238,6 +2288,7 @@ void omap_stop_lcd_dma(void)
 	w &= ~(1 << 8);
 	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
 }
+EXPORT_SYMBOL(omap_stop_lcd_dma);
 
 /*----------------------------------------------------------------------------*/
 
@@ -2327,8 +2378,10 @@ static int __init omap_init_dma(void)
 			continue;
 
 		if (cpu_class_is_omap1()) {
-			/* request_irq() doesn't like dev_id (ie. ch) being
-			 * zero, so we have to kludge around this. */
+			/*
+			 * request_irq() doesn't like dev_id (ie. ch) being
+			 * zero, so we have to kludge around this.
+			 */
 			r = request_irq(omap1_dma_irq[ch],
 					omap1_dma_irq_handler, 0, "DMA",
 					(void *) (ch + 1));
@@ -2373,48 +2426,4 @@ static int __init omap_init_dma(void)
 
 arch_initcall(omap_init_dma);
 
-EXPORT_SYMBOL(omap_get_dma_src_pos);
-EXPORT_SYMBOL(omap_get_dma_dst_pos);
-EXPORT_SYMBOL(omap_get_dma_src_addr_counter);
-EXPORT_SYMBOL(omap_clear_dma);
-EXPORT_SYMBOL(omap_set_dma_priority);
-EXPORT_SYMBOL(omap_request_dma);
-EXPORT_SYMBOL(omap_free_dma);
-EXPORT_SYMBOL(omap_start_dma);
-EXPORT_SYMBOL(omap_stop_dma);
-EXPORT_SYMBOL(omap_set_dma_callback);
-EXPORT_SYMBOL(omap_enable_dma_irq);
-EXPORT_SYMBOL(omap_disable_dma_irq);
-
-EXPORT_SYMBOL(omap_set_dma_transfer_params);
-EXPORT_SYMBOL(omap_set_dma_color_mode);
-EXPORT_SYMBOL(omap_set_dma_write_mode);
-
-EXPORT_SYMBOL(omap_set_dma_src_params);
-EXPORT_SYMBOL(omap_set_dma_src_index);
-EXPORT_SYMBOL(omap_set_dma_src_data_pack);
-EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
-
-EXPORT_SYMBOL(omap_set_dma_dest_params);
-EXPORT_SYMBOL(omap_set_dma_dest_index);
-EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
-EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
-
-EXPORT_SYMBOL(omap_set_dma_params);
-
-EXPORT_SYMBOL(omap_dma_link_lch);
-EXPORT_SYMBOL(omap_dma_unlink_lch);
-
-EXPORT_SYMBOL(omap_request_lcd_dma);
-EXPORT_SYMBOL(omap_free_lcd_dma);
-EXPORT_SYMBOL(omap_enable_lcd_dma);
-EXPORT_SYMBOL(omap_setup_lcd_dma);
-EXPORT_SYMBOL(omap_stop_lcd_dma);
-EXPORT_SYMBOL(omap_set_lcd_dma_b1);
-EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
-EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
-EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
 
diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-omap/dma.h
index d188100..f4dcb95 100644
--- a/include/asm-arm/arch-omap/dma.h
+++ b/include/asm-arm/arch-omap/dma.h
@@ -216,63 +216,98 @@
 #define OMAP24XX_DMA_GPMC		4	/* S_DMA_3 */
 #define OMAP24XX_DMA_GFX		5	/* S_DMA_4 */
 #define OMAP24XX_DMA_DSS		6	/* S_DMA_5 */
-#define OMAP24XX_DMA_VLYNQ_TX		7	/* S_DMA_6 */
+#define OMAP242X_DMA_VLYNQ_TX		7	/* S_DMA_6 */
+#define OMAP24XX_DMA_EXT_DMAREQ2	7	/* S_DMA_6 */
 #define OMAP24XX_DMA_CWT		8	/* S_DMA_7 */
 #define OMAP24XX_DMA_AES_TX		9	/* S_DMA_8 */
 #define OMAP24XX_DMA_AES_RX		10	/* S_DMA_9 */
 #define OMAP24XX_DMA_DES_TX		11	/* S_DMA_10 */
 #define OMAP24XX_DMA_DES_RX		12	/* S_DMA_11 */
 #define OMAP24XX_DMA_SHA1MD5_RX		13	/* S_DMA_12 */
-#define OMAP24XX_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
-#define OMAP24XX_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
-#define OMAP24XX_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
-#define OMAP24XX_DMA_EAC_AC_RD		17	/* S_DMA_16 */
-#define OMAP24XX_DMA_EAC_AC_WR		18	/* S_DMA_17 */
-#define OMAP24XX_DMA_EAC_MD_UL_RD	19	/* S_DMA_18 */
-#define OMAP24XX_DMA_EAC_MD_UL_WR	20	/* S_DMA_19 */
-#define OMAP24XX_DMA_EAC_MD_DL_RD	21	/* S_DMA_20 */
-#define OMAP24XX_DMA_EAC_MD_DL_WR	22	/* S_DMA_21 */
-#define OMAP24XX_DMA_EAC_BT_UL_RD	23	/* S_DMA_22 */
-#define OMAP24XX_DMA_EAC_BT_UL_WR	24	/* S_DMA_23 */
-#define OMAP24XX_DMA_EAC_BT_DL_RD	25	/* S_DMA_24 */
-#define OMAP24XX_DMA_EAC_BT_DL_WR	26	/* S_DMA_25 */
+#define OMAP34XX_DMA_SHA2MD5_RX		13	/* S_DMA_12 */
+#define OMAP242X_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
+#define OMAP242X_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
+#define OMAP242X_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
+#define OMAP242X_DMA_EAC_AC_RD		17	/* S_DMA_16 */
+#define OMAP242X_DMA_EAC_AC_WR		18	/* S_DMA_17 */
+#define OMAP242X_DMA_EAC_MD_UL_RD	19	/* S_DMA_18 */
+#define OMAP242X_DMA_EAC_MD_UL_WR	20	/* S_DMA_19 */
+#define OMAP242X_DMA_EAC_MD_DL_RD	21	/* S_DMA_20 */
+#define OMAP242X_DMA_EAC_MD_DL_WR	22	/* S_DMA_21 */
+#define OMAP242X_DMA_EAC_BT_UL_RD	23	/* S_DMA_22 */
+#define OMAP242X_DMA_EAC_BT_UL_WR	24	/* S_DMA_23 */
+#define OMAP242X_DMA_EAC_BT_DL_RD	25	/* S_DMA_24 */
+#define OMAP242X_DMA_EAC_BT_DL_WR	26	/* S_DMA_25 */
+#define OMAP243X_DMA_EXT_DMAREQ3	14	/* S_DMA_13 */
+#define OMAP24XX_DMA_SPI3_TX0		15	/* S_DMA_14 */
+#define OMAP24XX_DMA_SPI3_RX0		16	/* S_DMA_15 */
+#define OMAP24XX_DMA_MCBSP3_TX		17	/* S_DMA_16 */
+#define OMAP24XX_DMA_MCBSP3_RX		18	/* S_DMA_17 */
+#define OMAP24XX_DMA_MCBSP4_TX		19	/* S_DMA_18 */
+#define OMAP24XX_DMA_MCBSP4_RX		20	/* S_DMA_19 */
+#define OMAP24XX_DMA_MCBSP5_TX		21	/* S_DMA_20 */
+#define OMAP24XX_DMA_MCBSP5_RX		22	/* S_DMA_21 */
+#define OMAP24XX_DMA_SPI3_TX1		23	/* S_DMA_22 */
+#define OMAP24XX_DMA_SPI3_RX1		24	/* S_DMA_23 */
+#define OMAP243X_DMA_EXT_DMAREQ4	25	/* S_DMA_24 */
+#define OMAP243X_DMA_EXT_DMAREQ5	26	/* S_DMA_25 */
+#define OMAP34XX_DMA_I2C3_TX		25	/* S_DMA_24 */
+#define OMAP34XX_DMA_I2C3_RX		26	/* S_DMA_25 */
 #define OMAP24XX_DMA_I2C1_TX		27	/* S_DMA_26 */
 #define OMAP24XX_DMA_I2C1_RX		28	/* S_DMA_27 */
 #define OMAP24XX_DMA_I2C2_TX		29	/* S_DMA_28 */
 #define OMAP24XX_DMA_I2C2_RX		30	/* S_DMA_29 */
-#define OMAP24XX_DMA_MCBSP1_TX		31	/* SDMA_30 */
-#define OMAP24XX_DMA_MCBSP1_RX		32	/* SDMA_31 */
-#define OMAP24XX_DMA_MCBSP2_TX		33	/* SDMA_32 */
-#define OMAP24XX_DMA_MCBSP2_RX		34	/* SDMA_33 */
-#define OMAP24XX_DMA_SPI1_TX0		35	/* SDMA_34 */
-#define OMAP24XX_DMA_SPI1_RX0		36	/* SDMA_35 */
-#define OMAP24XX_DMA_SPI1_TX1		37	/* SDMA_36 */
-#define OMAP24XX_DMA_SPI1_RX1		38	/* SDMA_37 */
-#define OMAP24XX_DMA_SPI1_TX2		39	/* SDMA_38 */
-#define OMAP24XX_DMA_SPI1_RX2		40	/* SDMA_39 */
-#define OMAP24XX_DMA_SPI1_TX3		41	/* SDMA_40 */
-#define OMAP24XX_DMA_SPI1_RX3		42	/* SDMA_41 */
-#define OMAP24XX_DMA_SPI2_TX0		43	/* SDMA_42 */
-#define OMAP24XX_DMA_SPI2_RX0		44	/* SDMA_43 */
-#define OMAP24XX_DMA_SPI2_TX1		45	/* SDMA_44 */
-#define OMAP24XX_DMA_SPI2_RX1		46	/* SDMA_45 */
-
-#define OMAP24XX_DMA_UART1_TX		49	/* SDMA_48 */
-#define OMAP24XX_DMA_UART1_RX		50	/* SDMA_49 */
-#define OMAP24XX_DMA_UART2_TX		51	/* SDMA_50 */
-#define OMAP24XX_DMA_UART2_RX		52	/* SDMA_51 */
-#define OMAP24XX_DMA_UART3_TX		53	/* SDMA_52 */
-#define OMAP24XX_DMA_UART3_RX		54	/* SDMA_53 */
-#define OMAP24XX_DMA_USB_W2FC_TX0	55	/* SDMA_54 */
-#define OMAP24XX_DMA_USB_W2FC_RX0	56	/* SDMA_55 */
-#define OMAP24XX_DMA_USB_W2FC_TX1	57	/* SDMA_56 */
-#define OMAP24XX_DMA_USB_W2FC_RX1	58	/* SDMA_57 */
-#define OMAP24XX_DMA_USB_W2FC_TX2	59	/* SDMA_58 */
-#define OMAP24XX_DMA_USB_W2FC_RX2	60	/* SDMA_59 */
-#define OMAP24XX_DMA_MMC1_TX		61	/* SDMA_60 */
-#define OMAP24XX_DMA_MMC1_RX		62	/* SDMA_61 */
-#define OMAP24XX_DMA_MS			63	/* SDMA_62 */
-#define OMAP24XX_DMA_EXT_DMAREQ5	64	/* S_DMA_63 */
+#define OMAP24XX_DMA_MCBSP1_TX		31	/* S_DMA_30 */
+#define OMAP24XX_DMA_MCBSP1_RX		32	/* S_DMA_31 */
+#define OMAP24XX_DMA_MCBSP2_TX		33	/* S_DMA_32 */
+#define OMAP24XX_DMA_MCBSP2_RX		34	/* S_DMA_33 */
+#define OMAP24XX_DMA_SPI1_TX0		35	/* S_DMA_34 */
+#define OMAP24XX_DMA_SPI1_RX0		36	/* S_DMA_35 */
+#define OMAP24XX_DMA_SPI1_TX1		37	/* S_DMA_36 */
+#define OMAP24XX_DMA_SPI1_RX1		38	/* S_DMA_37 */
+#define OMAP24XX_DMA_SPI1_TX2		39	/* S_DMA_38 */
+#define OMAP24XX_DMA_SPI1_RX2		40	/* S_DMA_39 */
+#define OMAP24XX_DMA_SPI1_TX3		41	/* S_DMA_40 */
+#define OMAP24XX_DMA_SPI1_RX3		42	/* S_DMA_41 */
+#define OMAP24XX_DMA_SPI2_TX0		43	/* S_DMA_42 */
+#define OMAP24XX_DMA_SPI2_RX0		44	/* S_DMA_43 */
+#define OMAP24XX_DMA_SPI2_TX1		45	/* S_DMA_44 */
+#define OMAP24XX_DMA_SPI2_RX1		46	/* S_DMA_45 */
+#define OMAP24XX_DMA_MMC2_TX		47	/* S_DMA_46 */
+#define OMAP24XX_DMA_MMC2_RX		48	/* S_DMA_47 */
+#define OMAP24XX_DMA_UART1_TX		49	/* S_DMA_48 */
+#define OMAP24XX_DMA_UART1_RX		50	/* S_DMA_49 */
+#define OMAP24XX_DMA_UART2_TX		51	/* S_DMA_50 */
+#define OMAP24XX_DMA_UART2_RX		52	/* S_DMA_51 */
+#define OMAP24XX_DMA_UART3_TX		53	/* S_DMA_52 */
+#define OMAP24XX_DMA_UART3_RX		54	/* S_DMA_53 */
+#define OMAP24XX_DMA_USB_W2FC_TX0	55	/* S_DMA_54 */
+#define OMAP24XX_DMA_USB_W2FC_RX0	56	/* S_DMA_55 */
+#define OMAP24XX_DMA_USB_W2FC_TX1	57	/* S_DMA_56 */
+#define OMAP24XX_DMA_USB_W2FC_RX1	58	/* S_DMA_57 */
+#define OMAP24XX_DMA_USB_W2FC_TX2	59	/* S_DMA_58 */
+#define OMAP24XX_DMA_USB_W2FC_RX2	60	/* S_DMA_59 */
+#define OMAP24XX_DMA_MMC1_TX		61	/* S_DMA_60 */
+#define OMAP24XX_DMA_MMC1_RX		62	/* S_DMA_61 */
+#define OMAP24XX_DMA_MS			63	/* S_DMA_62 */
+#define OMAP242X_DMA_EXT_DMAREQ5	64	/* S_DMA_63 */
+#define OMAP243X_DMA_EXT_DMAREQ6	64	/* S_DMA_63 */
+#define OMAP34XX_DMA_EXT_DMAREQ3	64	/* S_DMA_63 */
+#define OMAP34XX_DMA_AES2_TX		65	/* S_DMA_64 */
+#define OMAP34XX_DMA_AES2_RX		66	/* S_DMA_65 */
+#define OMAP34XX_DMA_DES2_TX		67	/* S_DMA_66 */
+#define OMAP34XX_DMA_DES2_RX		68	/* S_DMA_67 */
+#define OMAP34XX_DMA_SHA1MD5_RX		69	/* S_DMA_68 */
+#define OMAP34XX_DMA_SPI4_TX0		70	/* S_DMA_69 */
+#define OMAP34XX_DMA_SPI4_RX0		71	/* S_DMA_70 */
+#define OMAP34XX_DSS_DMA0		72	/* S_DMA_71 */
+#define OMAP34XX_DSS_DMA1		73	/* S_DMA_72 */
+#define OMAP34XX_DSS_DMA2		74	/* S_DMA_73 */
+#define OMAP34XX_DSS_DMA3		75	/* S_DMA_74 */
+#define OMAP34XX_DMA_MMC3_TX		77	/* S_DMA_76 */
+#define OMAP34XX_DMA_MMC3_RX		78	/* S_DMA_77 */
+#define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
+#define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */
 
 /*----------------------------------------------------------------------------*/
 
@@ -378,6 +413,11 @@ enum omap_dma_burst_mode {
 	OMAP_DMA_DATA_BURST_16,
 };
 
+enum end_type {
+	OMAP_DMA_LITTLE_ENDIAN = 0,
+	OMAP_DMA_BIG_ENDIAN
+};
+
 enum omap_dma_color_mode {
 	OMAP_DMA_COLOR_DIS = 0,
 	OMAP_DMA_CONSTANT_FILL,
@@ -403,18 +443,21 @@ struct omap_dma_channel_params {
 	int frame_count;	/* number of frames in a element */
 
 	int src_port;		/* Only on OMAP1 REVISIT: Is this needed? */
-	int src_amode;		/* constant , post increment, indexed , double indexed */
+	int src_amode;		/* constant, post increment, indexed,
+					double indexed */
 	unsigned long src_start;	/* source address : physical */
 	int src_ei;		/* source element index */
 	int src_fi;		/* source frame index */
 
 	int dst_port;		/* Only on OMAP1 REVISIT: Is this needed? */
-	int dst_amode;		/* constant , post increment, indexed , double indexed */
+	int dst_amode;		/* constant, post increment, indexed,
+					double indexed */
 	unsigned long dst_start;	/* source address : physical */
 	int dst_ei;		/* source element index */
 	int dst_fi;		/* source frame index */
 
-	int trigger;		/* trigger attached if the channel is synchronized */
+	int trigger;		/* trigger attached if the channel is
+					synchronized */
 	int sync_mode;		/* sycn on element, frame , block or packet */
 	int src_or_dst_synch;	/* source synch(1) or destination synch(0) */
 
@@ -431,8 +474,8 @@ struct omap_dma_channel_params {
 
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
-			    void (* callback)(int lch, u16 ch_status, void *data),
-			    void *data, int *dma_ch);
+			void (*callback)(int lch, u16 ch_status, void *data),
+			void *data, int *dma_ch);
 extern void omap_enable_dma_irq(int ch, u16 irq_bits);
 extern void omap_disable_dma_irq(int ch, u16 irq_bits);
 extern void omap_free_dma(int ch);
@@ -464,17 +507,16 @@ extern void omap_set_dma_dest_burst_mode(int lch,
 					 enum omap_dma_burst_mode burst_mode);
 
 extern void omap_set_dma_params(int lch,
-				struct omap_dma_channel_params * params);
+				struct omap_dma_channel_params *params);
 
-extern void omap_dma_link_lch (int lch_head, int lch_queue);
-extern void omap_dma_unlink_lch (int lch_head, int lch_queue);
+extern void omap_dma_link_lch(int lch_head, int lch_queue);
+extern void omap_dma_unlink_lch(int lch_head, int lch_queue);
 
 extern int omap_set_dma_callback(int lch,
-			void (* callback)(int lch, u16 ch_status, void *data),
+			void (*callback)(int lch, u16 ch_status, void *data),
 			void *data);
 extern dma_addr_t omap_get_dma_src_pos(int lch);
 extern dma_addr_t omap_get_dma_dst_pos(int lch);
-extern int omap_get_dma_src_addr_counter(int lch);
 extern void omap_clear_dma(int lch);
 extern int omap_get_dma_active_status(int lch);
 extern int omap_dma_running(void);
@@ -482,6 +524,9 @@ extern void omap_dma_set_global_params(int arb_rate, int max_fifo_depth,
 				       int tparams);
 extern int omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 				 unsigned char write_prio);
+extern void omap_set_dma_dst_endian_type(int lch, enum end_type etype);
+extern void omap_set_dma_src_endian_type(int lch, enum end_type etype);
+extern int omap_get_dma_index(int lch, int *ei, int *fi);
 
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
@@ -507,7 +552,7 @@ extern int omap_dma_chain_status(int chain_id);
 #endif
 
 /* LCD DMA functions */
-extern int omap_request_lcd_dma(void (* callback)(u16 status, void *data),
+extern int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
 				void *data);
 extern void omap_free_lcd_dma(void);
 extern void omap_setup_lcd_dma(void);

--0lnxQi9hkpPO77W3--
