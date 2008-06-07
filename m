From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/21] ARM: OMAP: McBSP: Coding style cleanup on arch/arm/plat-omap/mcbsp.c
Date: Fri,  6 Jun 2008 18:30:42 -0700
Message-ID: <1212802253-17797-11-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
 <1212802253-17797-5-git-send-email-tony@atomide.com>
 <1212802253-17797-6-git-send-email-tony@atomide.com>
 <1212802253-17797-7-git-send-email-tony@atomide.com>
 <1212802253-17797-8-git-send-email-tony@atomide.com>
 <1212802253-17797-9-git-send-email-tony@atomide.com>
 <1212802253-17797-10-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53323 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760774AbYFGBbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:17 -0400
In-Reply-To: <1212802253-17797-10-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>, Tony Lindgren <tony@atomide.com>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This patch fix lots of warnings and errors reported by
scripts/checkpatch.pl on arch/arm/plat-omap/mcbsp.c.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 9cf83c4..053de31 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -21,9 +21,8 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
+#include <linux/io.h>
+#include <linux/irq.h>
 
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
@@ -61,20 +60,21 @@ struct omap_mcbsp {
 	struct completion            tx_dma_completion;
 	struct completion            rx_dma_completion;
 
+	/* Protect the field .free, while checking if the mcbsp is in use */
 	spinlock_t                   lock;
 };
 
 static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
 #ifdef CONFIG_ARCH_OMAP1
-static struct clk *mcbsp_dsp_ck = 0;
-static struct clk *mcbsp_api_ck = 0;
-static struct clk *mcbsp_dspxor_ck = 0;
+static struct clk *mcbsp_dsp_ck;
+static struct clk *mcbsp_api_ck;
+static struct clk *mcbsp_dspxor_ck;
 #endif
 #ifdef CONFIG_ARCH_OMAP2
-static struct clk *mcbsp1_ick = 0;
-static struct clk *mcbsp1_fck = 0;
-static struct clk *mcbsp2_ick = 0;
-static struct clk *mcbsp2_fck = 0;
+static struct clk *mcbsp1_ick;
+static struct clk *mcbsp1_fck;
+static struct clk *mcbsp2_ick;
+static struct clk *mcbsp2_fck;
 #endif
 
 static void omap_mcbsp_dump_reg(u8 id)
@@ -104,6 +104,7 @@ static irqreturn_t omap_mcbsp_tx_irq_handler(int irq, void *dev_id)
 	    OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2));
 
 	complete(&mcbsp_tx->tx_irq_completion);
+
 	return IRQ_HANDLED;
 }
 
@@ -115,6 +116,7 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
 	    OMAP_MCBSP_READ(mcbsp_rx->io_base, SPCR2));
 
 	complete(&mcbsp_rx->rx_irq_completion);
+
 	return IRQ_HANDLED;
 }
 
@@ -146,19 +148,17 @@ static void omap_mcbsp_rx_dma_callback(int lch, u16 ch_status, void *data)
 	complete(&mcbsp_dma_rx->rx_dma_completion);
 }
 
-
 /*
  * omap_mcbsp_config simply write a config to the
  * appropriate McBSP.
  * You either call this function or set the McBSP registers
  * by yourself before calling omap_mcbsp_start().
  */
-
-void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config)
+void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 {
 	u32 io_base = mcbsp[id].io_base;
 
-	DBG("OMAP-McBSP: McBSP%d  io_base: 0x%8x\n", id+1, io_base);
+	DBG("OMAP-McBSP: McBSP%d  io_base: 0x%8x\n", id + 1, io_base);
 
 	/* We write the given config */
 	OMAP_MCBSP_WRITE(io_base, SPCR2, config->spcr2);
@@ -173,14 +173,14 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config
 	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
 	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
 }
-
-
+EXPORT_SYMBOL(omap_mcbsp_config);
 
 static int omap_mcbsp_check(unsigned int id)
 {
 	if (cpu_is_omap730()) {
 		if (id > OMAP_MAX_MCBSP_COUNT - 1) {
-		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
+		       printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
+				id + 1);
 		       return -1;
 		}
 		return 0;
@@ -188,7 +188,8 @@ static int omap_mcbsp_check(unsigned int id)
 
 	if (cpu_is_omap15xx() || cpu_is_omap16xx() || cpu_is_omap24xx()) {
 		if (id > OMAP_MAX_MCBSP_COUNT) {
-			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n", id + 1);
+			printk(KERN_ERR "OMAP-McBSP: McBSP%d doesn't exist\n",
+				id + 1);
 			return -1;
 		}
 		return 0;
@@ -263,7 +264,8 @@ int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type)
 	spin_lock(&mcbsp[id].lock);
 
 	if (!mcbsp[id].free) {
-		printk (KERN_ERR "OMAP-McBSP: McBSP%d is currently in use\n", id + 1);
+		printk(KERN_ERR "OMAP-McBSP: McBSP%d is currently in use\n",
+			id + 1);
 		spin_unlock(&mcbsp[id].lock);
 		return -EINVAL;
 	}
@@ -274,6 +276,7 @@ int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_mcbsp_set_io_type);
 
 int omap_mcbsp_request(unsigned int id)
 {
@@ -305,7 +308,8 @@ int omap_mcbsp_request(unsigned int id)
 
 	spin_lock(&mcbsp[id].lock);
 	if (!mcbsp[id].free) {
-		printk (KERN_ERR "OMAP-McBSP: McBSP%d is currently in use\n", id + 1);
+		printk(KERN_ERR "OMAP-McBSP: McBSP%d is currently in use\n",
+			id + 1);
 		spin_unlock(&mcbsp[id].lock);
 		return -1;
 	}
@@ -315,24 +319,23 @@ int omap_mcbsp_request(unsigned int id)
 
 	if (mcbsp[id].io_type == OMAP_MCBSP_IRQ_IO) {
 		/* We need to get IRQs here */
-		err = request_irq(mcbsp[id].tx_irq, omap_mcbsp_tx_irq_handler, 0,
-				  "McBSP",
-				  (void *) (&mcbsp[id]));
+		err = request_irq(mcbsp[id].tx_irq, omap_mcbsp_tx_irq_handler,
+					0, "McBSP", (void *) (&mcbsp[id]));
 		if (err != 0) {
-			printk(KERN_ERR "OMAP-McBSP: Unable to request TX IRQ %d for McBSP%d\n",
-			       mcbsp[id].tx_irq, mcbsp[id].id);
+			printk(KERN_ERR "OMAP-McBSP: Unable to "
+					"request TX IRQ %d for McBSP%d\n",
+					mcbsp[id].tx_irq, mcbsp[id].id);
 			return err;
 		}
 
 		init_completion(&(mcbsp[id].tx_irq_completion));
 
-
-		err = request_irq(mcbsp[id].rx_irq, omap_mcbsp_rx_irq_handler, 0,
-				  "McBSP",
-				  (void *) (&mcbsp[id]));
+		err = request_irq(mcbsp[id].rx_irq, omap_mcbsp_rx_irq_handler,
+					0, "McBSP", (void *) (&mcbsp[id]));
 		if (err != 0) {
-			printk(KERN_ERR "OMAP-McBSP: Unable to request RX IRQ %d for McBSP%d\n",
-			       mcbsp[id].rx_irq, mcbsp[id].id);
+			printk(KERN_ERR "OMAP-McBSP: Unable to "
+					"request RX IRQ %d for McBSP%d\n",
+					mcbsp[id].rx_irq, mcbsp[id].id);
 			free_irq(mcbsp[id].tx_irq, (void *) (&mcbsp[id]));
 			return err;
 		}
@@ -341,8 +344,8 @@ int omap_mcbsp_request(unsigned int id)
 	}
 
 	return 0;
-
 }
+EXPORT_SYMBOL(omap_mcbsp_request);
 
 void omap_mcbsp_free(unsigned int id)
 {
@@ -370,7 +373,8 @@ void omap_mcbsp_free(unsigned int id)
 
 	spin_lock(&mcbsp[id].lock);
 	if (mcbsp[id].free) {
-		printk (KERN_ERR "OMAP-McBSP: McBSP%d was not reserved\n", id + 1);
+		printk(KERN_ERR "OMAP-McBSP: McBSP%d was not reserved\n",
+			id + 1);
 		spin_unlock(&mcbsp[id].lock);
 		return;
 	}
@@ -384,6 +388,7 @@ void omap_mcbsp_free(unsigned int id)
 		free_irq(mcbsp[id].tx_irq, (void *) (&mcbsp[id]));
 	}
 }
+EXPORT_SYMBOL(omap_mcbsp_free);
 
 /*
  * Here we start the McBSP, by enabling the sample
@@ -400,8 +405,8 @@ void omap_mcbsp_start(unsigned int id)
 
 	io_base = mcbsp[id].io_base;
 
-	mcbsp[id].rx_word_length = ((OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7);
-	mcbsp[id].tx_word_length = ((OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7);
+	mcbsp[id].rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
+	mcbsp[id].tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
 
 	/* Start the sample generator */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
@@ -422,8 +427,8 @@ void omap_mcbsp_start(unsigned int id)
 
 	/* Dump McBSP Regs */
 	omap_mcbsp_dump_reg(id);
-
 }
+EXPORT_SYMBOL(omap_mcbsp_start);
 
 void omap_mcbsp_stop(unsigned int id)
 {
@@ -435,7 +440,7 @@ void omap_mcbsp_stop(unsigned int id)
 
 	io_base = mcbsp[id].io_base;
 
-        /* Reset transmitter */
+	/* Reset transmitter */
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
 	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1));
 
@@ -447,7 +452,7 @@ void omap_mcbsp_stop(unsigned int id)
 	w = OMAP_MCBSP_READ(io_base, SPCR2);
 	OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
 }
-
+EXPORT_SYMBOL(omap_mcbsp_stop);
 
 /* polled mcbsp i/o operations */
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
@@ -480,10 +485,12 @@ int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
 			}
 		}
 	}
+
 	return 0;
 }
+EXPORT_SYMBOL(omap_mcbsp_pollwrite);
 
-int omap_mcbsp_pollread(unsigned int id, u16 * buf)
+int omap_mcbsp_pollread(unsigned int id, u16 *buf)
 {
 	u32 base = mcbsp[id].io_base;
 	/* if frame sync error - clear the error */
@@ -513,8 +520,10 @@ int omap_mcbsp_pollread(unsigned int id, u16 * buf)
 		}
 	}
 	*buf = readw(base + OMAP_MCBSP_REG_DRR1);
+
 	return 0;
 }
+EXPORT_SYMBOL(omap_mcbsp_pollread);
 
 /*
  * IRQ based word transmission.
@@ -535,6 +544,7 @@ void omap_mcbsp_xmit_word(unsigned int id, u32 word)
 		OMAP_MCBSP_WRITE(io_base, DXR2, word >> 16);
 	OMAP_MCBSP_WRITE(io_base, DXR1, word & 0xffff);
 }
+EXPORT_SYMBOL(omap_mcbsp_xmit_word);
 
 u32 omap_mcbsp_recv_word(unsigned int id)
 {
@@ -555,7 +565,7 @@ u32 omap_mcbsp_recv_word(unsigned int id)
 
 	return (word_lsb | (word_msb << 16));
 }
-
+EXPORT_SYMBOL(omap_mcbsp_recv_word);
 
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 {
@@ -577,7 +587,7 @@ int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
 			udelay(10);
-			printk("McBSP transmitter not ready\n");
+			printk(KERN_ERR "McBSP transmitter not ready\n");
 			return -EAGAIN;
 		}
 	}
@@ -597,7 +607,7 @@ int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
 			udelay(10);
-			printk("McBSP receiver not ready\n");
+			printk(KERN_ERR "McBSP receiver not ready\n");
 			return -EAGAIN;
 		}
 	}
@@ -609,8 +619,9 @@ int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
 
-int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word)
+int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 *word)
 {
 	u32 io_base = mcbsp[id].io_base, clock_word = 0;
 	omap_mcbsp_word_length tx_word_length = mcbsp[id].tx_word_length;
@@ -630,7 +641,7 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR2, spcr2 | XRST);
 			udelay(10);
-			printk("McBSP transmitter not ready\n");
+			printk(KERN_ERR "McBSP transmitter not ready\n");
 			return -EAGAIN;
 		}
 	}
@@ -650,7 +661,7 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word)
 			udelay(10);
 			OMAP_MCBSP_WRITE(io_base, SPCR1, spcr1 | RRST);
 			udelay(10);
-			printk("McBSP receiver not ready\n");
+			printk(KERN_ERR "McBSP receiver not ready\n");
 			return -EAGAIN;
 		}
 	}
@@ -664,7 +675,7 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word)
 
 	return 0;
 }
-
+EXPORT_SYMBOL(omap_mcbsp_spi_master_recv_word_poll);
 
 /*
  * Simple DMA based buffer rx/tx routines.
@@ -673,7 +684,8 @@ int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word)
  * For anything fancier, you should use your own customized DMA
  * routines and callbacks.
  */
-int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer, unsigned int length)
+int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer,
+				unsigned int length)
 {
 	int dma_tx_ch;
 	int src_port = 0;
@@ -683,10 +695,12 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 	if (omap_mcbsp_check(id) < 0)
 		return -EINVAL;
 
-	if (omap_request_dma(mcbsp[id].dma_tx_sync, "McBSP TX", omap_mcbsp_tx_dma_callback,
-			     &mcbsp[id],
-			     &dma_tx_ch)) {
-		printk("OMAP-McBSP: Unable to request DMA channel for McBSP%d TX. Trying IRQ based TX\n", id+1);
+	if (omap_request_dma(mcbsp[id].dma_tx_sync, "McBSP TX",
+				omap_mcbsp_tx_dma_callback,
+				&mcbsp[id],
+				&dma_tx_ch)) {
+		printk(KERN_ERR "OMAP-McBSP: Unable to request DMA channel for"
+				" McBSP%d TX. Trying IRQ based TX\n", id + 1);
 		return -EAGAIN;
 	}
 	mcbsp[id].dma_tx_lch = dma_tx_ch;
@@ -722,11 +736,13 @@ int omap_mcbsp_xmit_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 
 	omap_start_dma(mcbsp[id].dma_tx_lch);
 	wait_for_completion(&(mcbsp[id].tx_dma_completion));
+
 	return 0;
 }
+EXPORT_SYMBOL(omap_mcbsp_xmit_buffer);
 
-
-int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int length)
+int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer,
+				unsigned int length)
 {
 	int dma_rx_ch;
 	int src_port = 0;
@@ -736,10 +752,12 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 	if (omap_mcbsp_check(id) < 0)
 		return -EINVAL;
 
-	if (omap_request_dma(mcbsp[id].dma_rx_sync, "McBSP RX", omap_mcbsp_rx_dma_callback,
-			     &mcbsp[id],
-			     &dma_rx_ch)) {
-		printk("Unable to request DMA channel for McBSP%d RX. Trying IRQ based RX\n", id+1);
+	if (omap_request_dma(mcbsp[id].dma_rx_sync, "McBSP RX",
+				omap_mcbsp_rx_dma_callback,
+				&mcbsp[id],
+				&dma_rx_ch)) {
+		printk(KERN_ERR "Unable to request DMA channel for McBSP%d RX."
+				" Trying IRQ based RX\n", id + 1);
 		return -EAGAIN;
 	}
 	mcbsp[id].dma_rx_lch = dma_rx_ch;
@@ -756,10 +774,10 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 		sync_dev = mcbsp[id].dma_rx_sync;
 
 	omap_set_dma_transfer_params(mcbsp[id].dma_rx_lch,
-				     OMAP_DMA_DATA_TYPE_S16,
-				     length >> 1, 1,
-				     OMAP_DMA_SYNC_ELEMENT,
-	 sync_dev, 0);
+					OMAP_DMA_DATA_TYPE_S16,
+					length >> 1, 1,
+					OMAP_DMA_SYNC_ELEMENT,
+					sync_dev, 0);
 
 	omap_set_dma_src_params(mcbsp[id].dma_rx_lch,
 				src_port,
@@ -768,16 +786,17 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 				0, 0);
 
 	omap_set_dma_dest_params(mcbsp[id].dma_rx_lch,
-				 dest_port,
-				 OMAP_DMA_AMODE_POST_INC,
-				 buffer,
-				 0, 0);
+					dest_port,
+					OMAP_DMA_AMODE_POST_INC,
+					buffer,
+					0, 0);
 
 	omap_start_dma(mcbsp[id].dma_rx_lch);
 	wait_for_completion(&(mcbsp[id].rx_dma_completion));
+
 	return 0;
 }
-
+EXPORT_SYMBOL(omap_mcbsp_recv_buffer);
 
 /*
  * SPI wrapper.
@@ -785,7 +804,8 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
  * this wrapper just need an omap_mcbsp_spi_cfg structure as an input.
  * Once this is done, you can call omap_mcbsp_start().
  */
-void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg * spi_cfg)
+void omap_mcbsp_set_spi_mode(unsigned int id,
+				const struct omap_mcbsp_spi_cfg *spi_cfg)
 {
 	struct omap_mcbsp_reg_cfg mcbsp_cfg;
 
@@ -798,7 +818,7 @@ void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg *
 	mcbsp_cfg.rcr1 |= (RWDLEN1(spi_cfg->word_length) | RFRLEN1(0));
 	mcbsp_cfg.xcr1 |= (XWDLEN1(spi_cfg->word_length) | XFRLEN1(0));
 
-        /* Clock stop mode */
+	/* Clock stop mode */
 	if (spi_cfg->clk_stp_mode == OMAP_MCBSP_CLK_STP_MODE_NO_DELAY)
 		mcbsp_cfg.spcr1 |= (1 << 12);
 	else
@@ -827,13 +847,12 @@ void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg *
 
 	if (spi_cfg->spi_mode == OMAP_MCBSP_SPI_MASTER) {
 		mcbsp_cfg.pcr0 |= CLKXM;
-		mcbsp_cfg.srgr1 |= CLKGDV(spi_cfg->clk_div -1);
+		mcbsp_cfg.srgr1 |= CLKGDV(spi_cfg->clk_div - 1);
 		mcbsp_cfg.pcr0 |= FSXM;
 		mcbsp_cfg.srgr2 &= ~FSGM;
 		mcbsp_cfg.xcr2 |= XDATDLY(1);
 		mcbsp_cfg.rcr2 |= RDATDLY(1);
-	}
-	else {
+	} else {
 		mcbsp_cfg.pcr0 &= ~CLKXM;
 		mcbsp_cfg.srgr1 |= CLKGDV(1);
 		mcbsp_cfg.pcr0 &= ~FSXM;
@@ -846,7 +865,7 @@ void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg *
 
 	omap_mcbsp_config(id, &mcbsp_cfg);
 }
-
+EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
 
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
@@ -935,7 +954,7 @@ static int __init omap_mcbsp_init(void)
 	int mcbsp_count = 0, i;
 	static const struct omap_mcbsp_info *mcbsp_info;
 
-	printk("Initializing OMAP McBSP system\n");
+	printk(KERN_INFO "Initializing OMAP McBSP system\n");
 
 #ifdef CONFIG_ARCH_OMAP1
 	mcbsp_dsp_ck = clk_get(0, "dsp_ck");
@@ -957,22 +976,26 @@ static int __init omap_mcbsp_init(void)
 #ifdef CONFIG_ARCH_OMAP2
 	mcbsp1_ick = clk_get(0, "mcbsp1_ick");
 	if (IS_ERR(mcbsp1_ick)) {
-		printk(KERN_ERR "mcbsp: could not acquire mcbsp1_ick handle.\n");
+		printk(KERN_ERR "mcbsp: could not acquire "
+				"mcbsp1_ick handle.\n");
 		return PTR_ERR(mcbsp1_ick);
 	}
 	mcbsp1_fck = clk_get(0, "mcbsp1_fck");
 	if (IS_ERR(mcbsp1_fck)) {
-		printk(KERN_ERR "mcbsp: could not acquire mcbsp1_fck handle.\n");
+		printk(KERN_ERR "mcbsp: could not acquire "
+				"mcbsp1_fck handle.\n");
 		return PTR_ERR(mcbsp1_fck);
 	}
 	mcbsp2_ick = clk_get(0, "mcbsp2_ick");
 	if (IS_ERR(mcbsp2_ick)) {
-		printk(KERN_ERR "mcbsp: could not acquire mcbsp2_ick handle.\n");
+		printk(KERN_ERR "mcbsp: could not acquire "
+				"mcbsp2_ick handle.\n");
 		return PTR_ERR(mcbsp2_ick);
 	}
 	mcbsp2_fck = clk_get(0, "mcbsp2_fck");
 	if (IS_ERR(mcbsp2_fck)) {
-		printk(KERN_ERR "mcbsp: could not acquire mcbsp2_fck handle.\n");
+		printk(KERN_ERR "mcbsp: could not acquire "
+				"mcbsp2_fck handle.\n");
 		return PTR_ERR(mcbsp2_fck);
 	}
 #endif
@@ -1006,7 +1029,7 @@ static int __init omap_mcbsp_init(void)
 		if (i >= mcbsp_count) {
 			mcbsp[i].io_base = 0;
 			mcbsp[i].free = 0;
-                        continue;
+			continue;
 		}
 		mcbsp[i].id = i + 1;
 		mcbsp[i].free = 1;
@@ -1014,7 +1037,8 @@ static int __init omap_mcbsp_init(void)
 		mcbsp[i].dma_rx_lch = -1;
 
 		mcbsp[i].io_base = mcbsp_info[i].virt_base;
-		mcbsp[i].io_type = OMAP_MCBSP_IRQ_IO; /* Default I/O is IRQ based */
+		/* Default I/O is IRQ based */
+		mcbsp[i].io_type = OMAP_MCBSP_IRQ_IO;
 		mcbsp[i].tx_irq = mcbsp_info[i].tx_irq;
 		mcbsp[i].rx_irq = mcbsp_info[i].rx_irq;
 		mcbsp[i].dma_rx_sync = mcbsp_info[i].dma_rx_sync;
@@ -1026,19 +1050,3 @@ static int __init omap_mcbsp_init(void)
 }
 
 arch_initcall(omap_mcbsp_init);
-
-EXPORT_SYMBOL(omap_mcbsp_config);
-EXPORT_SYMBOL(omap_mcbsp_request);
-EXPORT_SYMBOL(omap_mcbsp_set_io_type);
-EXPORT_SYMBOL(omap_mcbsp_free);
-EXPORT_SYMBOL(omap_mcbsp_start);
-EXPORT_SYMBOL(omap_mcbsp_stop);
-EXPORT_SYMBOL(omap_mcbsp_pollread);
-EXPORT_SYMBOL(omap_mcbsp_pollwrite);
-EXPORT_SYMBOL(omap_mcbsp_xmit_word);
-EXPORT_SYMBOL(omap_mcbsp_recv_word);
-EXPORT_SYMBOL(omap_mcbsp_xmit_buffer);
-EXPORT_SYMBOL(omap_mcbsp_recv_buffer);
-EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
-EXPORT_SYMBOL(omap_mcbsp_spi_master_recv_word_poll);
-EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
