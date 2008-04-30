From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: OMAP: DMA clean-up
Date: Wed, 30 Apr 2008 10:14:01 -0700
Message-ID: <1209575641-25613-4-git-send-email-tony@atomide.com>
References: omap-dma-2008-04-30
 <1209575641-25613-1-git-send-email-tony@atomide.com>
 <1209575641-25613-2-git-send-email-tony@atomide.com>
 <1209575641-25613-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61632 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757065AbYD3ROL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 13:14:11 -0400
In-Reply-To: <1209575641-25613-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

DMA clean-up, mostly checkpatch.pl fixes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c        |  246 +++++++++++++++++++++----------=
--------
 include/asm-arm/arch-omap/dma.h |   23 ++--
 2 files changed, 146 insertions(+), 123 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 5a8e0e0..3222476 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1,7 +1,7 @@
 /*
  * linux/arch/arm/plat-omap/dma.c
  *
- * Copyright (C) 2003 Nokia Corporation
+ * Copyright (C) 2003 - 2008 Nokia Corporation
  * Author: Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
  * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.co=
m>
  * Graphics DMA and LCD DMA graphics tranformations
@@ -25,11 +25,11 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/io.h>
=20
 #include <asm/system.h>
 #include <asm/hardware.h>
 #include <asm/dma.h>
-#include <asm/io.h>
=20
 #include <asm/arch/tc.h>
=20
@@ -43,13 +43,13 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, D=
MA_CH_STARTED,
 enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #endif
=20
-#define OMAP_DMA_ACTIVE		0x01
-#define OMAP_DMA_CCR_EN		(1 << 7)
+#define OMAP_DMA_ACTIVE			0x01
+#define OMAP_DMA_CCR_EN			(1 << 7)
 #define OMAP2_DMA_CSR_CLEAR_MASK	0xffe
=20
-#define OMAP_FUNC_MUX_ARM_BASE	(0xfffe1000 + 0xec)
+#define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
=20
-static int enable_1510_mode =3D 0;
+static int enable_1510_mode;
=20
 struct omap_dma_lch {
 	int next_lch;
@@ -57,7 +57,7 @@ struct omap_dma_lch {
 	u16 saved_csr;
 	u16 enabled_irqs;
 	const char *dev_name;
-	void (* callback)(int lch, u16 ch_status, void *data);
+	void (*callback)(int lch, u16 ch_status, void *data);
 	void *data;
=20
 #ifndef CONFIG_ARCH_OMAP1
@@ -245,6 +245,7 @@ void omap_set_dma_priority(int lch, int dst_port, i=
nt priority)
 		dma_write(ccr, CCR(lch));
 	}
 }
+EXPORT_SYMBOL(omap_set_dma_priority);
=20
 void omap_set_dma_transfer_params(int lch, int data_type, int elem_cou=
nt,
 				  int frame_count, int sync_mode,
@@ -307,6 +308,7 @@ void omap_set_dma_transfer_params(int lch, int data=
_type, int elem_count,
 	dma_write(elem_count, CEN(lch));
 	dma_write(frame_count, CFN(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_transfer_params);
=20
 void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u=
32 color)
 {
@@ -346,6 +348,7 @@ void omap_set_dma_color_mode(int lch, enum omap_dma=
_color_mode mode, u32 color)
 	}
 	dma_write(w, LCH_CTRL(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_color_mode);
=20
 void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 {
@@ -358,12 +361,15 @@ void omap_set_dma_write_mode(int lch, enum omap_d=
ma_write_mode mode)
 		dma_write(csdp, CSDP(lch));
 	}
 }
+EXPORT_SYMBOL(omap_set_dma_write_mode);
=20
 /* Note that src_port is only for omap1 */
 void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 			     unsigned long src_start,
 			     int src_ei, int src_fi)
 {
+	u32 l;
+
 	if (cpu_class_is_omap1()) {
 		u16 w;
=20
@@ -371,34 +377,27 @@ void omap_set_dma_src_params(int lch, int src_por=
t, int src_amode,
 		w &=3D ~(0x1f << 2);
 		w |=3D src_port << 2;
 		dma_write(w, CSDP(lch));
+	}
=20
-		w =3D dma_read(CCR(lch));
-		w &=3D ~(0x03 << 12);
-		w |=3D src_amode << 12;
-		dma_write(w, CCR(lch));
+	l =3D dma_read(CCR(lch));
+	l &=3D ~(0x03 << 12);
+	l |=3D src_amode << 12;
+	dma_write(l, CCR(lch));
=20
+	if (cpu_class_is_omap1()) {
 		dma_write(src_start >> 16, CSSA_U(lch));
 		dma_write((u16)src_start, CSSA_L(lch));
-
-		dma_write(src_ei, CSEI(lch));
-		dma_write(src_fi, CSFI(lch));
 	}
=20
-	if (cpu_class_is_omap2()) {
-		u32 l;
-
-		l =3D dma_read(CCR(lch));
-		l &=3D ~(0x03 << 12);
-		l |=3D src_amode << 12;
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
=20
-void omap_set_dma_params(int lch, struct omap_dma_channel_params * par=
ams)
+void omap_set_dma_params(int lch, struct omap_dma_channel_params *para=
ms)
 {
 	omap_set_dma_transfer_params(lch, params->data_type,
 				     params->elem_count, params->frame_count,
@@ -415,16 +414,17 @@ void omap_set_dma_params(int lch, struct omap_dma=
_channel_params * params)
 		omap_dma_set_prio_lch(lch, params->read_prio,
 				      params->write_prio);
 }
+EXPORT_SYMBOL(omap_set_dma_params);
=20
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
=20
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
@@ -436,6 +436,7 @@ void omap_set_dma_src_data_pack(int lch, int enable=
)
 		l |=3D (1 << 6);
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_src_data_pack);
=20
 void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode bur=
st_mode)
 {
@@ -478,6 +479,7 @@ void omap_set_dma_src_burst_mode(int lch, enum omap=
_dma_burst_mode burst_mode)
 	l |=3D (burst << 7);
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_src_burst_mode);
=20
 /* Note that dest_port is only for OMAP1 */
 void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
@@ -509,16 +511,17 @@ void omap_set_dma_dest_params(int lch, int dest_p=
ort, int dest_amode,
 	dma_write(dst_ei, CDEI(lch));
 	dma_write(dst_fi, CDFI(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_dest_params);
=20
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
=20
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
@@ -530,6 +533,7 @@ void omap_set_dma_dest_data_pack(int lch, int enabl=
e)
 		l |=3D 1 << 13;
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_dest_data_pack);
=20
 void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode bu=
rst_mode)
 {
@@ -570,6 +574,7 @@ void omap_set_dma_dest_burst_mode(int lch, enum oma=
p_dma_burst_mode burst_mode)
 	l |=3D (burst << 14);
 	dma_write(l, CSDP(lch));
 }
+EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
=20
 static inline void omap_enable_channel_irq(int lch)
 {
@@ -597,11 +602,13 @@ void omap_enable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs |=3D bits;
 }
+EXPORT_SYMBOL(omap_enable_dma_irq);
=20
 void omap_disable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs &=3D ~bits;
 }
+EXPORT_SYMBOL(omap_disable_dma_irq);
=20
 static inline void enable_lnk(int lch)
 {
@@ -617,8 +624,9 @@ static inline void enable_lnk(int lch)
 		l =3D dma_chan[lch].next_lch | (1 << 15);
=20
 #ifndef CONFIG_ARCH_OMAP1
-	if (dma_chan[lch].next_linked_ch !=3D -1)
-		l =3D dma_chan[lch].next_linked_ch | (1 << 15);
+	if (cpu_class_is_omap2())
+		if (dma_chan[lch].next_linked_ch !=3D -1)
+			l =3D dma_chan[lch].next_linked_ch | (1 << 15);
 #endif
=20
 	dma_write(l, CLNK_CTRL(lch));
@@ -660,7 +668,7 @@ static inline void omap2_enable_irq_lch(int lch)
 }
=20
 int omap_request_dma(int dev_id, const char *dev_name,
-		     void (* callback)(int lch, u16 ch_status, void *data),
+		     void (*callback)(int lch, u16 ch_status, void *data),
 		     void *data, int *dma_ch_out)
 {
 	int ch, free_ch =3D -1;
@@ -693,10 +701,14 @@ int omap_request_dma(int dev_id, const char *dev_=
name,
 	chan->dev_name =3D dev_name;
 	chan->callback =3D callback;
 	chan->data =3D data;
+
 #ifndef CONFIG_ARCH_OMAP1
-	chan->chain_id =3D -1;
-	chan->next_linked_ch =3D -1;
+	if (cpu_class_is_omap2()) {
+		chan->chain_id =3D -1;
+		chan->next_linked_ch =3D -1;
+	}
 #endif
+
 	chan->enabled_irqs =3D OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
=20
 	if (cpu_class_is_omap1())
@@ -711,8 +723,10 @@ int omap_request_dma(int dev_id, const char *dev_n=
ame,
 			set_gdma_dev(free_ch + 1, dev_id);
 			dev_id =3D free_ch + 1;
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
@@ -720,7 +734,6 @@ int omap_request_dma(int dev_id, const char *dev_na=
me,
=20
 	if (cpu_class_is_omap2()) {
 		omap2_enable_irq_lch(free_ch);
-
 		omap_enable_channel_irq(free_ch);
 		/* Clear the CSR register and IRQ status register */
 		dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(free_ch));
@@ -731,6 +744,7 @@ int omap_request_dma(int dev_id, const char *dev_na=
me,
=20
 	return 0;
 }
+EXPORT_SYMBOL(omap_request_dma);
=20
 void omap_free_dma(int lch)
 {
@@ -738,11 +752,12 @@ void omap_free_dma(int lch)
=20
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	if (dma_chan[lch].dev_id =3D=3D -1) {
-		printk("omap_dma: trying to free nonallocated DMA channel %d\n",
+		pr_err("omap_dma: trying to free unallocated DMA channel %d\n",
 		       lch);
 		spin_unlock_irqrestore(&dma_chan_lock, flags);
 		return;
 	}
+
 	dma_chan[lch].dev_id =3D -1;
 	dma_chan[lch].next_lch =3D -1;
 	dma_chan[lch].callback =3D NULL;
@@ -774,6 +789,7 @@ void omap_free_dma(int lch)
 		omap_clear_dma(lch);
 	}
 }
+EXPORT_SYMBOL(omap_free_dma);
=20
 /**
  * @brief omap_dma_set_global_params : Set global priority settings fo=
r dma
@@ -867,6 +883,7 @@ void omap_clear_dma(int lch)
=20
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(omap_clear_dma);
=20
 void omap_start_dma(int lch)
 {
@@ -905,8 +922,10 @@ void omap_start_dma(int lch)
=20
 	l =3D dma_read(CCR(lch));
=20
-	/* Errata: On ES2.0 BUFFERING disable must be set.
-	 * This will always fail on ES1.0 */
+	/*
+	 * Errata: On ES2.0 BUFFERING disable must be set.
+	 * This will always fail on ES1.0
+	 */
 	if (cpu_is_omap24xx())
 		l |=3D OMAP_DMA_CCR_EN;
=20
@@ -915,6 +934,7 @@ void omap_start_dma(int lch)
=20
 	dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
 }
+EXPORT_SYMBOL(omap_start_dma);
=20
 void omap_stop_dma(int lch)
 {
@@ -951,13 +971,14 @@ void omap_stop_dma(int lch)
=20
 	dma_chan[lch].flags &=3D ~OMAP_DMA_ACTIVE;
 }
+EXPORT_SYMBOL(omap_stop_dma);
=20
 /*
  * Allows changing the DMA callback function or data. This may be need=
ed if
  * the driver shares a single DMA channel for multiple dma triggers.
  */
 int omap_set_dma_callback(int lch,
-			  void (* callback)(int lch, u16 ch_status, void *data),
+			  void (*callback)(int lch, u16 ch_status, void *data),
 			  void *data)
 {
 	unsigned long flags;
@@ -977,6 +998,7 @@ int omap_set_dma_callback(int lch,
=20
 	return 0;
 }
+EXPORT_SYMBOL(omap_set_dma_callback);
=20
 /*
  * Returns current physical source address for the given DMA channel.
@@ -1007,6 +1029,7 @@ dma_addr_t omap_get_dma_src_pos(int lch)
=20
 	return offset;
 }
+EXPORT_SYMBOL(omap_get_dma_src_pos);
=20
 /*
  * Returns current physical destination address for the given DMA chan=
nel.
@@ -1037,6 +1060,7 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
=20
 	return offset;
 }
+EXPORT_SYMBOL(omap_get_dma_dst_pos);
=20
 /*
  * Returns current source transfer counting for the given DMA channel.
@@ -1047,6 +1071,7 @@ int omap_get_dma_src_addr_counter(int lch)
 {
 	return (dma_addr_t)dma_read(CSAC(lch));
 }
+EXPORT_SYMBOL(omap_get_dma_src_addr_counter);
=20
 int omap_get_dma_active_status(int lch)
 {
@@ -1075,7 +1100,7 @@ int omap_dma_running(void)
  * For this DMA link to start, you still need to start (see omap_start=
_dma)
  * the first one. That will fire up the entire queue.
  */
-void omap_dma_link_lch (int lch_head, int lch_queue)
+void omap_dma_link_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1092,11 +1117,12 @@ void omap_dma_link_lch (int lch_head, int lch_q=
ueue)
=20
 	dma_chan[lch_head].next_lch =3D lch_queue;
 }
+EXPORT_SYMBOL(omap_dma_link_lch);
=20
 /*
  * Once the DMA queue is stopped, we can destroy it.
  */
-void omap_dma_unlink_lch (int lch_head, int lch_queue)
+void omap_dma_unlink_lch(int lch_head, int lch_queue)
 {
 	if (omap_dma_in_1510_mode()) {
 		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
@@ -1111,7 +1137,6 @@ void omap_dma_unlink_lch (int lch_head, int lch_q=
ueue)
 		dump_stack();
 	}
=20
-
 	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
 	    (dma_chan[lch_head].flags & OMAP_DMA_ACTIVE)) {
 		printk(KERN_ERR "omap_dma: You need to stop the DMA channels "
@@ -1121,6 +1146,9 @@ void omap_dma_unlink_lch (int lch_head, int lch_q=
ueue)
=20
 	dma_chan[lch_head].next_lch =3D -1;
 }
+EXPORT_SYMBOL(omap_dma_unlink_lch);
+
+/*--------------------------------------------------------------------=
--------*/
=20
 #ifndef CONFIG_ARCH_OMAP1
 /* Create chain of DMA channesls */
@@ -1244,6 +1272,7 @@ int omap_request_dma_chain(int dev_id, const char=
 *dev_name,
 		for (i =3D 0; i < (no_of_chans - 1); i++)
 			create_dma_lch_chain(channels[i], channels[i + 1]);
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_request_dma_chain);
@@ -1286,6 +1315,7 @@ int omap_modify_dma_chain_params(int chain_id,
 		 */
 		omap_set_dma_params(channels[i], &params);
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_modify_dma_chain_params);
@@ -1329,6 +1359,7 @@ int omap_free_dma_chain(int chain_id)
 	dma_linked_lch[chain_id].linked_dmach_q =3D NULL;
 	dma_linked_lch[chain_id].chain_mode =3D -1;
 	dma_linked_lch[chain_id].chain_state =3D -1;
+
 	return (0);
 }
 EXPORT_SYMBOL(omap_free_dma_chain);
@@ -1359,6 +1390,7 @@ int omap_dma_chain_status(int chain_id)
=20
 	if (OMAP_DMA_CHAIN_QEMPTY(chain_id))
 		return OMAP_DMA_CHAIN_INACTIVE;
+
 	return OMAP_DMA_CHAIN_ACTIVE;
 }
 EXPORT_SYMBOL(omap_dma_chain_status);
@@ -1384,8 +1416,10 @@ int omap_dma_chain_a_transfer(int chain_id, int =
src_start, int dest_start,
 	u32 l, lch;
 	int start_dma =3D 0;
=20
-	/* if buffer size is less than 1 then there is
-	 * no use of starting the chain */
+	/*
+	 * if buffer size is less than 1 then there is
+	 * no use of starting the chain
+	 */
 	if (elem_count < 1) {
 		printk(KERN_ERR "Invalid buffer size\n");
 		return -EINVAL;
@@ -1430,12 +1464,16 @@ int omap_dma_chain_a_transfer(int chain_id, int=
 src_start, int dest_start,
 	dma_write(elem_count, CEN(lch));
 	dma_write(frame_count, CFN(lch));
=20
-	/* If the chain is dynamically linked,
-	 * then we may have to start the chain if its not active */
+	/*
+	 * If the chain is dynamically linked,
+	 * then we may have to start the chain if its not active
+	 */
 	if (dma_linked_lch[chain_id].chain_mode =3D=3D OMAP_DMA_DYNAMIC_CHAIN=
) {
=20
-		/* In Dynamic chain, if the chain is not started,
-		 * queue the channel */
+		/*
+		 * In Dynamic chain, if the chain is not started,
+		 * queue the channel
+		 */
 		if (dma_linked_lch[chain_id].chain_state =3D=3D
 						DMA_CHAIN_NOTSTARTED) {
 			/* Enable the link in previous channel */
@@ -1445,8 +1483,10 @@ int omap_dma_chain_a_transfer(int chain_id, int =
src_start, int dest_start,
 			dma_chan[lch].state =3D DMA_CH_QUEUED;
 		}
=20
-		/* Chain is already started, make sure its active,
-		 * if not then start the chain */
+		/*
+		 * Chain is already started, make sure its active,
+		 * if not then start the chain
+		 */
 		else {
 			start_dma =3D 1;
=20
@@ -1493,6 +1533,7 @@ int omap_dma_chain_a_transfer(int chain_id, int s=
rc_start, int dest_start,
 			dma_chan[lch].flags |=3D OMAP_DMA_ACTIVE;
 		}
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_dma_chain_a_transfer);
@@ -1544,6 +1585,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 	dma_write(l, CCR(channels[0]));
=20
 	dma_chan[channels[0]].flags |=3D OMAP_DMA_ACTIVE;
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_start_dma_chain_transfers);
@@ -1575,7 +1617,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	}
 	channels =3D dma_linked_lch[chain_id].linked_dmach_q;
=20
-	/* DMA Errata:
+	/*
+	 * DMA Errata:
 	 * Special programming model needed to disable DMA before end of bloc=
k
 	 */
 	sys_cf =3D dma_read(OCP_SYSCONFIG);
@@ -1603,6 +1646,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
=20
 	/* Errata - put in the old value */
 	dma_write(sys_cf, OCP_SYSCONFIG);
+
 	return 0;
 }
 EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
@@ -1718,7 +1762,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	return dma_read(CSAC(lch));
 }
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
-#endif
+#endif	/* ifndef CONFIG_ARCH_OMAP1 */
=20
 /*--------------------------------------------------------------------=
--------*/
=20
@@ -1754,6 +1798,7 @@ static int omap1_dma_handle_ch(int ch)
 		dma_chan[ch].flags &=3D ~OMAP_DMA_ACTIVE;
 	if (likely(dma_chan[ch].callback !=3D NULL))
 		dma_chan[ch].callback(ch, csr, dma_chan[ch].data);
+
 	return 1;
 }
=20
@@ -1788,7 +1833,8 @@ static int omap2_dma_handle_ch(int ch)
=20
 	if (!status) {
 		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n", ch);
+			printk(KERN_WARNING "Spurious DMA IRQ for lch %d\n",
+				ch);
 		dma_write(1 << ch, IRQSTATUS_L0);
 		return 0;
 	}
@@ -1876,7 +1922,7 @@ static struct irqaction omap24xx_dma_irq;
 static struct lcd_dma_info {
 	spinlock_t lock;
 	int reserved;
-	void (* callback)(u16 status, void *data);
+	void (*callback)(u16 status, void *data);
 	void *cb_data;
=20
 	int active;
@@ -1898,6 +1944,7 @@ void omap_set_lcd_dma_b1(unsigned long addr, u16 =
fb_xres, u16 fb_yres,
 	lcd_dma.xres =3D fb_xres;
 	lcd_dma.yres =3D fb_yres;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1);
=20
 void omap_set_lcd_dma_src_port(int port)
 {
@@ -1908,12 +1955,13 @@ void omap_set_lcd_dma_ext_controller(int extern=
al)
 {
 	lcd_dma.ext_ctrl =3D external;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_ext_controller);
=20
 void omap_set_lcd_dma_single_transfer(int single)
 {
 	lcd_dma.single_transfer =3D single;
 }
-
+EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
=20
 void omap_set_lcd_dma_b1_rotation(int rotate)
 {
@@ -1924,6 +1972,7 @@ void omap_set_lcd_dma_b1_rotation(int rotate)
 	}
 	lcd_dma.rotate =3D rotate;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
=20
 void omap_set_lcd_dma_b1_mirror(int mirror)
 {
@@ -1933,6 +1982,7 @@ void omap_set_lcd_dma_b1_mirror(int mirror)
 	}
 	lcd_dma.mirror =3D mirror;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
=20
 void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
 {
@@ -1943,6 +1993,7 @@ void omap_set_lcd_dma_b1_vxres(unsigned long vxre=
s)
 	}
 	lcd_dma.vxres =3D vxres;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
=20
 void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscal=
e)
 {
@@ -1953,6 +2004,7 @@ void omap_set_lcd_dma_b1_scale(unsigned int xscal=
e, unsigned int yscale)
 	lcd_dma.xscale =3D xscale;
 	lcd_dma.yscale =3D yscale;
 }
+EXPORT_SYMBOL(omap_set_lcd_dma_b1_scale);
=20
 static void set_b1_regs(void)
 {
@@ -1983,8 +2035,11 @@ static void set_b1_regs(void)
 	xscale =3D lcd_dma.xscale ? lcd_dma.xscale : 1;
 	yscale =3D lcd_dma.yscale ? lcd_dma.yscale : 1;
 	BUG_ON(vxres < lcd_dma.xres);
-#define PIXADDR(x,y) (lcd_dma.addr + ((y) * vxres * yscale + (x) * xsc=
ale) * es)
+
+#define PIXADDR(x, y) (lcd_dma.addr +					\
+		((y) * vxres * yscale + (x) * xscale) * es)
 #define PIXSTEP(sx, sy, dx, dy) (PIXADDR(dx, dy) - PIXADDR(sx, sy) - e=
s + 1)
+
 	switch (lcd_dma.rotate) {
 	case 0:
 		if (!lcd_dma.mirror) {
@@ -1993,8 +2048,8 @@ static void set_b1_regs(void)
 			/* 1510 DMA requires the bottom address to be 2 more
 			 * than the actual last memory access location. */
 			if (omap_dma_in_1510_mode() &&
-			    lcd_dma.data_type =3D=3D OMAP_DMA_DATA_TYPE_S32)
-				bottom +=3D 2;
+				lcd_dma.data_type =3D=3D OMAP_DMA_DATA_TYPE_S32)
+					bottom +=3D 2;
 			ei =3D PIXSTEP(0, 0, 1, 0);
 			fi =3D PIXSTEP(lcd_dma.xres - 1, 0, 0, 1);
 		} else {
@@ -2121,7 +2176,7 @@ static irqreturn_t lcd_dma_irq_handler(int irq, v=
oid *dev_id)
 	return IRQ_HANDLED;
 }
=20
-int omap_request_lcd_dma(void (* callback)(u16 status, void *data),
+int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
 			 void *data)
 {
 	spin_lock_irq(&lcd_dma.lock);
@@ -2147,6 +2202,7 @@ int omap_request_lcd_dma(void (* callback)(u16 st=
atus, void *data),
=20
 	return 0;
 }
+EXPORT_SYMBOL(omap_request_lcd_dma);
=20
 void omap_free_lcd_dma(void)
 {
@@ -2163,12 +2219,14 @@ void omap_free_lcd_dma(void)
 	lcd_dma.reserved =3D 0;
 	spin_unlock(&lcd_dma.lock);
 }
+EXPORT_SYMBOL(omap_free_lcd_dma);
=20
 void omap_enable_lcd_dma(void)
 {
 	u16 w;
=20
-	/* Set the Enable bit only if an external controller is
+	/*
+	 * Set the Enable bit only if an external controller is
 	 * connected. Otherwise the OMAP internal controller will
 	 * start the transfer when it gets enabled.
 	 */
@@ -2185,6 +2243,7 @@ void omap_enable_lcd_dma(void)
 	w |=3D 1 << 7;
 	omap_writew(w, OMAP1610_DMA_LCD_CCR);
 }
+EXPORT_SYMBOL(omap_enable_lcd_dma);
=20
 void omap_setup_lcd_dma(void)
 {
@@ -2200,16 +2259,18 @@ void omap_setup_lcd_dma(void)
 		u16 w;
=20
 		w =3D omap_readw(OMAP1610_DMA_LCD_CCR);
-		/* If DMA was already active set the end_prog bit to have
+		/*
+		 * If DMA was already active set the end_prog bit to have
 		 * the programmed register set loaded into the active
 		 * register set.
 		 */
 		w |=3D 1 << 11;		/* End_prog */
 		if (!lcd_dma.single_transfer)
-	        	w |=3D (3 << 8);	/* Auto_init, repeat */
+			w |=3D (3 << 8);	/* Auto_init, repeat */
 		omap_writew(w, OMAP1610_DMA_LCD_CCR);
 	}
 }
+EXPORT_SYMBOL(omap_setup_lcd_dma);
=20
 void omap_stop_lcd_dma(void)
 {
@@ -2227,6 +2288,7 @@ void omap_stop_lcd_dma(void)
 	w &=3D ~(1 << 8);
 	omap_writew(w, OMAP1610_DMA_LCD_CTRL);
 }
+EXPORT_SYMBOL(omap_stop_lcd_dma);
=20
 /*--------------------------------------------------------------------=
--------*/
=20
@@ -2316,8 +2378,10 @@ static int __init omap_init_dma(void)
 			continue;
=20
 		if (cpu_class_is_omap1()) {
-			/* request_irq() doesn't like dev_id (ie. ch) being
-			 * zero, so we have to kludge around this. */
+			/*
+			 * request_irq() doesn't like dev_id (ie. ch) being
+			 * zero, so we have to kludge around this.
+			 */
 			r =3D request_irq(omap1_dma_irq[ch],
 					omap1_dma_irq_handler, 0, "DMA",
 					(void *) (ch + 1));
@@ -2362,48 +2426,4 @@ static int __init omap_init_dma(void)
=20
 arch_initcall(omap_init_dma);
=20
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
=20
diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-oma=
p/dma.h
index e62eb6e..00b1f68 100644
--- a/include/asm-arm/arch-omap/dma.h
+++ b/include/asm-arm/arch-omap/dma.h
@@ -435,18 +435,21 @@ struct omap_dma_channel_params {
 	int frame_count;	/* number of frames in a element */
=20
 	int src_port;		/* Only on OMAP1 REVISIT: Is this needed? */
-	int src_amode;		/* constant , post increment, indexed , double indexe=
d */
+	int src_amode;		/* constant, post increment, indexed,
+					double indexed */
 	unsigned long src_start;	/* source address : physical */
 	int src_ei;		/* source element index */
 	int src_fi;		/* source frame index */
=20
 	int dst_port;		/* Only on OMAP1 REVISIT: Is this needed? */
-	int dst_amode;		/* constant , post increment, indexed , double indexe=
d */
+	int dst_amode;		/* constant, post increment, indexed,
+					double indexed */
 	unsigned long dst_start;	/* source address : physical */
 	int dst_ei;		/* source element index */
 	int dst_fi;		/* source frame index */
=20
-	int trigger;		/* trigger attached if the channel is synchronized */
+	int trigger;		/* trigger attached if the channel is
+					synchronized */
 	int sync_mode;		/* sycn on element, frame , block or packet */
 	int src_or_dst_synch;	/* source synch(1) or destination synch(0) */
=20
@@ -463,8 +466,8 @@ struct omap_dma_channel_params {
=20
 extern void omap_set_dma_priority(int lch, int dst_port, int priority)=
;
 extern int omap_request_dma(int dev_id, const char *dev_name,
-			    void (* callback)(int lch, u16 ch_status, void *data),
-			    void *data, int *dma_ch);
+				void (*callback)(int lch, u16 ch_status,
+				void *data), void *data, int *dma_ch);
 extern void omap_enable_dma_irq(int ch, u16 irq_bits);
 extern void omap_disable_dma_irq(int ch, u16 irq_bits);
 extern void omap_free_dma(int ch);
@@ -495,13 +498,13 @@ extern void omap_set_dma_dest_burst_mode(int lch,
 					 enum omap_dma_burst_mode burst_mode);
=20
 extern void omap_set_dma_params(int lch,
-				struct omap_dma_channel_params * params);
+				struct omap_dma_channel_params *params);
=20
-extern void omap_dma_link_lch (int lch_head, int lch_queue);
-extern void omap_dma_unlink_lch (int lch_head, int lch_queue);
+extern void omap_dma_link_lch(int lch_head, int lch_queue);
+extern void omap_dma_unlink_lch(int lch_head, int lch_queue);
=20
 extern int omap_set_dma_callback(int lch,
-			void (* callback)(int lch, u16 ch_status, void *data),
+			void (*callback)(int lch, u16 ch_status, void *data),
 			void *data);
 extern dma_addr_t omap_get_dma_src_pos(int lch);
 extern dma_addr_t omap_get_dma_dst_pos(int lch);
@@ -541,7 +544,7 @@ extern int omap_dma_chain_status(int chain_id);
 #endif
=20
 /* LCD DMA functions */
-extern int omap_request_lcd_dma(void (* callback)(u16 status, void *da=
ta),
+extern int omap_request_lcd_dma(void (*callback)(u16 status, void *dat=
a),
 				void *data);
 extern void omap_free_lcd_dma(void);
 extern void omap_setup_lcd_dma(void);
--=20
1.5.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
