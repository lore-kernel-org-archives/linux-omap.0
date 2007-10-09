From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/6] OMAP1: CAMERA: Changed omap16xxcam.c to the coding
	style standard
Date: Tue,  9 Oct 2007 08:52:28 -0400
Message-ID: <1191934353-24072-2-git-send-email-edubezval@gmail.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

- Executed Lindent on omap16xxcam.c
- Removed extra blank spaces
- Lines with more than 80 columns were broken
- Added KERN_* flags on printk calls

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/video/omap/omap16xxcam.c |  441 ++++++++++++++++----------------
 1 files changed, 215 insertions(+), 226 deletions(-)

diff --git a/drivers/media/video/omap/omap16xxcam.c b/drivers/media/video/omap/omap16xxcam.c
index 34cf1a6..82c006b 100644
--- a/drivers/media/video/omap/omap16xxcam.c
+++ b/drivers/media/video/omap/omap16xxcam.c
@@ -1,23 +1,23 @@
 /*
  * drivers/media/video/omap/omap16xxcam.c
  *
- * Copyright (C) 2004 Texas Instruments, Inc. 
- * 
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
  * Video-for-Linux (Version 2) camera capture driver for
  * the OMAP H2 and H3 camera controller.
  *
- * leverage some code from CEE distribution 
+ * leverage some code from CEE distribution
  * Copyright (C) 2003-2004 MontaVista Software, Inc.
- * 
- * This package is free software; you can redistribute it and/or modify 
+ *
+ * This package is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. 
- * 
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR 
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED 
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
- 
+
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
@@ -38,7 +38,6 @@
 #include "omap16xxcam.h"
 #include "camera_hw_if.h"
 #include "camera_core.h"
- 
 
 #define CONF_CAMERAIF_RESET_R 5
 #define EN_PER	  0
@@ -49,13 +48,13 @@
 #define NUM_CAMDMA_CHANNELS 2
 
 typedef struct {
-        unsigned int ctrlclock;     /* 00 */
-        unsigned int it_status;     /* 04 */
-        unsigned int mode;          /* 08 */
-        unsigned int status;        /* 0C */
-        unsigned int camdata;       /* 10 */
-        unsigned int gpio;   	    /* 14 */
-        unsigned int peak_counter;  /* 18 */
+	unsigned int ctrlclock;		/* 00 */
+	unsigned int it_status;		/* 04 */
+	unsigned int mode;		/* 08 */
+	unsigned int status;		/* 0C */
+	unsigned int camdata;		/* 10 */
+	unsigned int gpio;		/* 14 */
+	unsigned int peak_counter;	/* 18 */
 } camera_regs_t;
 
 struct camdma_state {
@@ -68,12 +67,12 @@ struct omap16xxcam {
 	camera_regs_t *camera_regs;
 	unsigned long iobase_phys;
 
-	/* frequncy (in Hz) of camera interface functional clock (ocp_clk) */
+	/* Frequency (in Hz) of camera interface functional clock (ocp_clk) */
 	unsigned long ocp_clk;
 
 	struct clk *func_clk;
 
-	/* dma related stuff */
+	/* DMA related stuff */
 	spinlock_t dma_lock;
 	int free_dmach;
 	int next_dmach;
@@ -86,22 +85,21 @@ struct omap16xxcam {
 	int new;
 };
 static struct omap16xxcam hardware_data;
-   
+
 static int omap16xxcam_set_xclk(int, void *);
 static void omap16xx_cam_dma_link_callback(int, unsigned short, void *);
 
 /* Clears the camera data FIFO by setting RAZ_FIFO bit in MODE configuration
-   register. */
-static void
-omap16xx_cam_clear_fifo(struct omap16xxcam *data)
+ * register.
+ */
+static void omap16xx_cam_clear_fifo(struct omap16xxcam *data)
 {
 	data->camera_regs->mode |= RAZ_FIFO;
 	udelay(10);
 	data->camera_regs->mode &= ~RAZ_FIFO;
 }
-  
-static void
-omap16xx_cam_reset(struct omap16xxcam *data, int yes)
+
+static void omap16xx_cam_reset(struct omap16xxcam *data, int yes)
 {
 	if (machine_is_omap_h3())
 		data->camera_regs->gpio = yes ? 0 : 1;
@@ -109,93 +107,96 @@ omap16xx_cam_reset(struct omap16xxcam *data, int yes)
 		data->camera_regs->gpio = yes ? 1 : 0;
 }
 
-static void 
-omap16xx_cam_init(void)
+static void omap16xx_cam_init(void)
 {
 	/*
 	 * FIXME - Use mux API's instead of directly writing in to MUX registers
 	 */
-	omap_writel(omap_readl(FUNC_MUX_CTRL_4) & ~(0x1ff << 21), FUNC_MUX_CTRL_4);
+	omap_writel(omap_readl(FUNC_MUX_CTRL_4) & ~(0x1ff << 21),
+		    FUNC_MUX_CTRL_4);
 	omap_writel(0, FUNC_MUX_CTRL_5);
-	omap_writel(omap_readl(PULL_DWN_CTRL_0) & ~(0x1FFF << 17), PULL_DWN_CTRL_0);
+	omap_writel(omap_readl(PULL_DWN_CTRL_0) & ~(0x1FFF << 17),
+		    PULL_DWN_CTRL_0);
 	omap_writel(omap_readl(PU_PD_SEL_0) & ~(0x1FFF << 17), PU_PD_SEL_0);
 
 	omap_writel(0xeaef, COMP_MODE_CTRL_0);
-	omap_writel(omap_readl(OMAP1610_RESET_CONTROL) & ~(1 << CONF_CAMERAIF_RESET_R),
-			OMAP1610_RESET_CONTROL);
-	omap_writel(omap_readl(OMAP1610_RESET_CONTROL) | (1 << CONF_CAMERAIF_RESET_R),
-			OMAP1610_RESET_CONTROL);
-    
+	omap_writel(omap_readl(OMAP1610_RESET_CONTROL) &
+		    ~(1 << CONF_CAMERAIF_RESET_R), OMAP1610_RESET_CONTROL);
+	omap_writel(omap_readl(OMAP1610_RESET_CONTROL) |
+		    (1 << CONF_CAMERAIF_RESET_R), OMAP1610_RESET_CONTROL);
+
 	/* Enable peripheral reset */
 	omap_writew(omap_readw(ARM_RSTCT2) | (1 << EN_PER), ARM_RSTCT2);
 
-	/* enable peripheral clock */
+	/* Enable peripheral clock */
 	clk_enable(hardware_data.func_clk);
 }
 
-static void
-omap16xx_cam_waitfor_syncedge(struct omap16xxcam *data, u32 edge_mask)
+static void omap16xx_cam_waitfor_syncedge(struct omap16xxcam *data,
+					  u32 edge_mask)
 {
-	data->camera_regs->mode = (FIFO_TRIGGER_LVL << THRESHOLD_BIT) | edge_mask;
+	data->camera_regs->mode =
+	    (FIFO_TRIGGER_LVL << THRESHOLD_BIT) | edge_mask;
 	do {
 		interruptible_sleep_on(&data->vsync_wait);
 	} while (signal_pending(current));
 }
 
-static void
-omap16xx_cam_configure_dma(struct omap16xxcam *data)
+static void omap16xx_cam_configure_dma(struct omap16xxcam *data)
 {
 
 	data->camera_regs->mode = (FIFO_TRIGGER_LVL << THRESHOLD_BIT)
-			 | EN_DMA | EN_FIFO_FULL;
-	data->camera_regs->ctrlclock |= LCLK_EN; 
+	    | EN_DMA | EN_FIFO_FULL;
+	data->camera_regs->ctrlclock |= LCLK_EN;
 }
 
-/* acquire h/w resources DMA */
-static int
-omap16xx_cam_link_open(struct omap16xxcam *data)
+/* Acquire h/w resources DMA */
+static int omap16xx_cam_link_open(struct omap16xxcam *data)
 {
 	int ret;
 
-	/* Acquire first dma channel */
-	if ((ret = omap_request_dma(OMAP_DMA_CAMERA_IF_RX, 
-				"camera dma 1", omap16xx_cam_dma_link_callback,
-				(void *)data, &data->dma_channel_number1))) {
-                return ret;
+	/* Acquire first DMA channel */
+	ret = omap_request_dma(OMAP_DMA_CAMERA_IF_RX,
+			       "camera dma 1",
+			       omap16xx_cam_dma_link_callback,
+			       (void *)data, &data->dma_channel_number1);
+	if (ret)
+		return ret;
+
+	/* Acquire second DMA channel */
+	ret = omap_request_dma(OMAP_DMA_CAMERA_IF_RX,
+			       "camera dma 2",
+			       omap16xx_cam_dma_link_callback,
+			       (void *)data, &data->dma_channel_number2);
+	if (ret) {
+		printk(KERN_ERR "No DMA available for camera\n");
+		return ret;
 	}
-	/* Acquire second dma channel */
-	if ((ret = omap_request_dma(OMAP_DMA_CAMERA_IF_RX, 
-				"camera dma 2", omap16xx_cam_dma_link_callback,
-				(void *)data, &data->dma_channel_number2))) {
-                printk ("No DMA available for camera\n");
-                return ret;
-        }
- 	data->next_dmach = data->dma_channel_number1;
+	data->next_dmach = data->dma_channel_number1;
 	OMAP_DMA_CLNK_CTRL_REG(data->dma_channel_number1) =
-		data->dma_channel_number2;
+	    data->dma_channel_number2;
 	OMAP_DMA_CLNK_CTRL_REG(data->dma_channel_number2) =
-		data->dma_channel_number1;
+	    data->dma_channel_number1;
 
 	return 0;
 }
 
-/* free h/w resources, stop i/f */
-static int
-omap16xx_cam_link_close(struct omap16xxcam *data)
+/* Free h/w resources, stop i/f */
+static int omap16xx_cam_link_close(struct omap16xxcam *data)
 {
-	/* free dma channels */
+	/* Free DMA channels */
 	omap_stop_dma(data->dma_channel_number1);
 	omap_stop_dma(data->dma_channel_number2);
 
-	omap_free_dma (data->dma_channel_number1);
-	omap_free_dma (data->dma_channel_number2);
+	omap_free_dma(data->dma_channel_number1);
+	omap_free_dma(data->dma_channel_number2);
 
 	return 0;
 }
 
-/* dma callback routine. */
-static void
-omap16xx_cam_dma_link_callback(int lch, unsigned short ch_status, void *data)
+/* DMA callback routine. */
+static void omap16xx_cam_dma_link_callback(int lch, unsigned short ch_status,
+					   void *data)
 {
 	int count;
 	void *arg1, *arg2;
@@ -204,52 +205,51 @@ omap16xx_cam_dma_link_callback(int lch, unsigned short ch_status, void *data)
 	dma_callback_t callback;
 
 	spin_lock(&cam->dma_lock);
-	if (cam->free_dmach == 2)
-	{
-		printk("callback all CHANNELS WERE IDLE \n");
+	if (cam->free_dmach == 2) {
+		printk(KERN_ERR "callback all CHANNELS WERE IDLE \n");
 		spin_unlock(&cam->dma_lock);
 		return;
 	}
 	if (cam->free_dmach == 0) {
 		lch = cam->next_dmach;
 	} else {
-		lch = cam->next_dmach == cam->dma_channel_number1 ? 
-			cam->dma_channel_number2 : cam->dma_channel_number1;
+		lch = cam->next_dmach == cam->dma_channel_number1 ?
+		    cam->dma_channel_number2 : cam->dma_channel_number1;
 	}
 
-	while (cam->free_dmach < 2)
-	{
+	while (cam->free_dmach < 2) {
 		if (OMAP_DMA_CCR_REG(lch) & (1 << 7))
-			break;	
+			break;
 
 		count = (lch == cam->dma_channel_number2) ? 1 : 0;
 
 		callback = cam->camdma[count].callback;
- 		arg1 = cam->camdma[count].arg1;
+		arg1 = cam->camdma[count].arg1;
 		arg2 = cam->camdma[count].arg2;
 		cam->free_dmach++;
 
-		spin_unlock(&cam->dma_lock);		
- 		callback(arg1, arg2);
+		spin_unlock(&cam->dma_lock);
+		callback(arg1, arg2);
 		spin_lock(&cam->dma_lock);
 
-		lch = (lch == cam->dma_channel_number2) ? cam->dma_channel_number1 :
-							cam->dma_channel_number2;
+		lch =
+		    (lch ==
+		     cam->dma_channel_number2) ? cam->
+		    dma_channel_number1 : cam->dma_channel_number2;
 	}
 	spin_unlock(&cam->dma_lock);
-	
+
 }
 
-static irqreturn_t
-omap16xx_cam_isr(int irq, void *client_data)
+static irqreturn_t omap16xx_cam_isr(int irq, void *client_data)
 {
 	struct omap16xxcam *data = (struct omap16xxcam *)client_data;
 	unsigned int itstat = data->camera_regs->it_status;
 
 	/* VSYNC UP interrupt, start filling FIFO and enabling DMA */
-	if (itstat & V_UP) {		
+	if (itstat & V_UP) {
 		data->camera_regs->mode &= ~EN_V_UP;
-	 	omap16xx_cam_clear_fifo(data);	
+		omap16xx_cam_clear_fifo(data);
 		omap16xx_cam_configure_dma(data);
 		omap_start_dma(data->next_dmach);
 		wake_up_interruptible(&data->vsync_wait);
@@ -261,29 +261,29 @@ omap16xx_cam_isr(int irq, void *client_data)
 	}
 
 	if (itstat & H_UP)
-		printk("H_UP\n");
-	
+		printk(KERN_INFO "H_UP\n");
+
 	if (itstat & H_DOWN)
-		printk("H_DOWN\n");
-	
+		printk(KERN_INFO "H_DOWN\n");
+
 	if (itstat & FIFO_FULL) {
-		omap16xx_cam_clear_fifo(data);	
-		printk("FIFO_FULL\n");
+		omap16xx_cam_clear_fifo(data);
+		printk(KERN_INFO "FIFO_FULL\n");
 	}
-	
+
 	if (itstat & DATA_XFER)
-		printk("DATA_TRANS\n");
-	
+		printk(KERN_INFO "DATA_TRANS\n");
+
 	return IRQ_HANDLED;
 }
- 
-/* ------------- below are interface functions ----------------- */
-/* ------------- these functions are named omap16xxcam_<name> -- */
-static int
-omap16xxcam_init_dma(void *priv)
+
+/* ------------- Below are interface functions -----------------
+ * ------------- These functions are named omap16xxcam_<name> --
+ */
+static int omap16xxcam_init_dma(void *priv)
 {
 	int ch;
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 
 	data->free_dmach = 2;
 	for (ch = 0; ch < 2; ++ch) {
@@ -295,12 +295,12 @@ omap16xxcam_init_dma(void *priv)
 	return 0;
 }
 
-/* start the dma of chains */
-static int 
-omap16xxcam_start_dma(struct sgdma_state *sgdma,
-		dma_callback_t callback, void *arg1, void *arg2, void *priv)
+/* Start the DMA of chains */
+static int omap16xxcam_start_dma(struct sgdma_state *sgdma,
+				 dma_callback_t callback, void *arg1,
+				 void *arg2, void *priv)
 {
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 	struct scatterlist *sglist;
 	unsigned long irqflags;
 	int dmach;
@@ -313,37 +313,37 @@ omap16xxcam_start_dma(struct sgdma_state *sgdma,
 	if (!data->free_dmach) {
 		spin_unlock_irqrestore(&data->dma_lock, irqflags);
 		return -EBUSY;
-	} 
+	}
 	dmach = data->next_dmach;
-	count = (dmach == data->dma_channel_number2) ? 1:0;
+	count = (dmach == data->dma_channel_number2) ? 1 : 0;
 	data->camdma[count].callback = callback;
 	data->camdma[count].arg1 = arg1;
 	data->camdma[count].arg2 = arg2;
 
 	if (cpu_is_omap1710())
 		omap_set_dma_src_params(dmach, OMAP_DMA_PORT_OCP_T1,
-			    OMAP_DMA_AMODE_CONSTANT, CAM_CAMDATA_REG,
-			    0, 0);
+					OMAP_DMA_AMODE_CONSTANT,
+					CAM_CAMDATA_REG, 0, 0);
 	else
 		omap_set_dma_src_params(dmach, OMAP_DMA_PORT_TIPB,
-			    OMAP_DMA_AMODE_CONSTANT, CAM_CAMDATA_REG,
-			    0, 0);
+					OMAP_DMA_AMODE_CONSTANT,
+					CAM_CAMDATA_REG, 0, 0);
 
 	omap_set_dma_dest_params(dmach, OMAP_DMA_PORT_EMIFF,
-	                     OMAP_DMA_AMODE_POST_INC, sg_dma_address(sglist),
-			     0, 0);
+				 OMAP_DMA_AMODE_POST_INC,
+				 sg_dma_address(sglist), 0, 0);
 
 	omap_set_dma_transfer_params(dmach, OMAP_DMA_DATA_TYPE_S32,
-			FIFO_TRIGGER_LVL, 
-			sg_dma_len(sglist)/(4 * FIFO_TRIGGER_LVL), 
- 			OMAP_DMA_SYNC_FRAME,
-			0, 0);
+				     FIFO_TRIGGER_LVL,
+				     sg_dma_len(sglist) / (4 *
+							   FIFO_TRIGGER_LVL),
+				     OMAP_DMA_SYNC_FRAME, 0, 0);
+
+	OMAP_DMA_CLNK_CTRL_REG(dmach) &= ~(1 << 15);
 
-	OMAP_DMA_CLNK_CTRL_REG(dmach) &= ~( 1<< 15);
+	prev_dmach = (dmach == data->dma_channel_number2) ?
+	    data->dma_channel_number1 : data->dma_channel_number2;
 
-	prev_dmach = (dmach == data->dma_channel_number2) ? 
-		data->dma_channel_number1 : data->dma_channel_number2;
-	
 	if (data->new) {
 		data->new = 0;
 		omap16xx_cam_waitfor_syncedge(data, EN_V_UP);
@@ -351,20 +351,20 @@ omap16xxcam_start_dma(struct sgdma_state *sgdma,
 		if (OMAP_DMA_CCR_REG(prev_dmach) & (1 << 7))
 			OMAP_DMA_CLNK_CTRL_REG(prev_dmach) |= (1 << 15);
 		else {
-			/* no transfer is in progress */
-  			omap_start_dma(dmach);
-		}	
+			/* No transfer is in progress */
+			omap_start_dma(dmach);
+		}
 	}
- 	
-	data->next_dmach = prev_dmach; 
+
+	data->next_dmach = prev_dmach;
 	data->free_dmach--;
 	spin_unlock_irqrestore(&data->dma_lock, irqflags);
 	return 0;
 }
-int static
-omap16xxcam_finish_dma(void *priv)
+
+int static omap16xxcam_finish_dma(void *priv)
 {
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 
 	while (data->free_dmach < 2)
 		mdelay(1);
@@ -372,112 +372,107 @@ omap16xxcam_finish_dma(void *priv)
 	return 0;
 }
 
-
-/* Enables the camera. Takes camera out of reset. Enables the clocks. */ 
-static int
-omap16xxcam_enable(void *priv)
+/* Enables the camera. Takes camera out of reset. Enables the clocks. */
+static int omap16xxcam_enable(void *priv)
 {
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 
 	omap16xx_cam_reset(data, 1);
-	
-	/* give clock to camera_module */
+
+	/* Give clock to camera_module */
 	data->camera_regs->mode = (FIFO_TRIGGER_LVL << THRESHOLD_BIT);
 	data->camera_regs->ctrlclock = MCLK_EN | CAMEXCLK_EN;
 
 	omap16xx_cam_clear_fifo(data);
 
-	/* wait for camera to settle down */
+	/* Wait for camera to settle down */
 	mdelay(5);
 
 	return 0;
 }
- 
+
 /* Disables all the camera clocks. Put the camera interface in reset. */
-static int
-omap16xxcam_disable(void *priv)
-{ 	
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+static int omap16xxcam_disable(void *priv)
+{
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 
 	omap16xx_cam_clear_fifo(data);
 
-	data->camera_regs->ctrlclock = 0x00000000;     
+	data->camera_regs->ctrlclock = 0x00000000;
 	data->camera_regs->mode = 0x00000000;
-	
+
 	omap16xx_cam_reset(data, 0);
 
 	return 0;
 }
 
 /* Abort the data transfer */
-static int
-omap16xxcam_abort(void *priv)
+static int omap16xxcam_abort(void *priv)
 {
 	return omap16xxcam_disable(priv);
 }
 
-static int
-omap16xxcam_set_xclk(int xclk, void *priv)
-{ 	
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
- 	int xclk_val;
+static int omap16xxcam_set_xclk(int xclk, void *priv)
+{
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
+	int xclk_val;
 	int divisor = 1;
-	divisor = data->ocp_clk/xclk;
-	if ( divisor * xclk < data->ocp_clk)
-		++divisor; 
+	divisor = data->ocp_clk / xclk;
+	if (divisor * xclk < data->ocp_clk)
+		++divisor;
 
 	switch (divisor) {
-		case 1:
-		case 2:
-			xclk_val = FOSCMOD_TC2_CK2;
-			break;
-		case 3:
-			xclk_val = FOSCMOD_TC2_CK3;
-			break;
-		case 4:
-		case 5:
-		case 6:
-		case 7:
-			xclk_val = FOSCMOD_TC2_CK4;
-			break;
-		case 8:
-		case 9:
-			xclk_val = FOSCMOD_TC2_CK8;
-			break;
-		case 10:
-		case 11:
-			xclk_val = FOSCMOD_TC2_CK10;
-			break;
-		case 12:
-		case 13:
-		case 14:
-		case 15:
-			xclk_val = FOSCMOD_TC2_CK12;
-			break;
-		case 16:
-			xclk_val = FOSCMOD_TC2_CK16;
-			break;
-		default:
-			xclk_val = FOSCMOD_TC2_CK16;
+	case 1:
+	case 2:
+		xclk_val = FOSCMOD_TC2_CK2;
+		break;
+	case 3:
+		xclk_val = FOSCMOD_TC2_CK3;
+		break;
+	case 4:
+	case 5:
+	case 6:
+	case 7:
+		xclk_val = FOSCMOD_TC2_CK4;
+		break;
+	case 8:
+	case 9:
+		xclk_val = FOSCMOD_TC2_CK8;
+		break;
+	case 10:
+	case 11:
+		xclk_val = FOSCMOD_TC2_CK10;
+		break;
+	case 12:
+	case 13:
+	case 14:
+	case 15:
+		xclk_val = FOSCMOD_TC2_CK12;
+		break;
+	case 16:
+		xclk_val = FOSCMOD_TC2_CK16;
+		break;
+	default:
+		xclk_val = FOSCMOD_TC2_CK16;
 	}
-	
-	/* follow the protocol to change the XCLK clock */
+
+	/* Follow the protocol to change the XCLK clock */
 	data->camera_regs->ctrlclock &= ~CAMEXCLK_EN;
 	data->camera_regs->ctrlclock |= xclk_val;
 	data->camera_regs->ctrlclock |= CAMEXCLK_EN;
 
-	return (data->ocp_clk/divisor);
+	return (data->ocp_clk / divisor);
 }
 
-static int
-omap16xxcam_open(void *priv)
+static int omap16xxcam_open(void *priv)
 {
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 	int ret;
 
-	if ((ret = request_irq(INT_CAMERA, omap16xx_cam_isr, IRQF_DISABLED,
-					"camera", data))) {
-		printk("FAILED to aquire irq\n");
+	ret = request_irq(INT_CAMERA, omap16xx_cam_isr, IRQF_DISABLED,
+			  "camera", data);
+	if (ret) {
+		printk(KERN_ERR "FAILED to acquire IRQ\n");
 		return ret;
 	}
 
@@ -488,22 +483,20 @@ omap16xxcam_open(void *priv)
 	return omap16xx_cam_link_open(data);
 }
 
-static int
-omap16xxcam_close(void *priv)
+static int omap16xxcam_close(void *priv)
 {
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 
 	omap16xxcam_disable(priv);
-	 
+
 	free_irq(INT_CAMERA, data);
-	
+
 	return omap16xx_cam_link_close(data);
 }
 
-static int
-omap16xxcam_cleanup(void *priv)
+static int omap16xxcam_cleanup(void *priv)
 {
-	struct omap16xxcam *data = (struct omap16xxcam *) priv;
+	struct omap16xxcam *data = (struct omap16xxcam *)priv;
 
 	if (!data->camera_regs)
 		return -EINVAL;
@@ -511,7 +504,7 @@ omap16xxcam_cleanup(void *priv)
 	omap16xxcam_disable(data);
 	if (cpu_is_omap1710())
 		iounmap((void *)data->camera_regs);
-	data->camera_regs= NULL;
+	data->camera_regs = NULL;
 
 	if (data->iobase_phys) {
 		release_mem_region(data->iobase_phys, CAMERA_IOSIZE);
@@ -527,9 +520,8 @@ omap16xxcam_cleanup(void *priv)
 	return 0;
 }
 
-/* Initialise the OMAP camera interface */
-static void *
-omap16xxcam_init(void)
+/* Initialize the OMAP camera interface */
+static void *omap16xxcam_init(void)
 {
 	unsigned long cam_iobase;
 
@@ -540,36 +532,34 @@ omap16xxcam_init(void)
 	}
 
 	if (cpu_is_omap1710()) {
-		cam_iobase = (unsigned long) ioremap (CAMERA_BASE,
-				CAMERA_IOSIZE);
+		cam_iobase = (unsigned long)ioremap(CAMERA_BASE, CAMERA_IOSIZE);
 		if (!cam_iobase) {
-			printk("CANNOT MAP CAMERA REGISTER\n");
+			printk(KERN_ERR "CANNOT MAP CAMERA REGISTER\n");
 			return NULL;
 		}
-	}
-	else
+	} else
 		cam_iobase = io_p2v(CAMERA_BASE);
 
 	/* Set the base address of the camera registers */
-	hardware_data.camera_regs = (camera_regs_t *)cam_iobase;
-	hardware_data.iobase_phys = (unsigned long) CAMERA_BASE;
+	hardware_data.camera_regs = (camera_regs_t *) cam_iobase;
+	hardware_data.iobase_phys = (unsigned long)CAMERA_BASE;
 
-	/* get the input clock value to camera interface and store it */
+	/* Get the input clock value to camera interface and store it */
 	if (cpu_is_omap1710())
 		hardware_data.func_clk = clk_get(0, "tc2_ck");
 	else
 		hardware_data.func_clk = clk_get(0, "armper_ck");
 	hardware_data.ocp_clk = clk_get_rate(hardware_data.func_clk);
 
-	/* Init the camera IF */
+	/* Initialize the camera IF */
 	omap16xx_cam_init();
-	/* enable it. This is needed for sensor detection */
-	omap16xxcam_enable((void*)&hardware_data);
-	/* Init dma data */
+	/* Enable it. This is needed for sensor detection */
+	omap16xxcam_enable((void *)&hardware_data);
+	/* Initialize DMA data */
 	spin_lock_init(&hardware_data.dma_lock);
 
 	init_waitqueue_head(&hardware_data.vsync_wait);
-	return (void*)&hardware_data;
+	return (void *)&hardware_data;
 }
 
 struct camera_hardware camera_hardware_if = {
@@ -587,4 +577,3 @@ struct camera_hardware camera_hardware_if = {
 	.start_dma	= omap16xxcam_start_dma,
 	.finish_dma	= omap16xxcam_finish_dma,
 };
-
-- 
1.5.3.4.206.g58ba4
