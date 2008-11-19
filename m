From: mesak82@gmail.com
Subject: [PATCH][OMAPZOOM] ARM: OMAP3: Update McBSP with changes in struct omap_mcbsp
Date: Tue, 18 Nov 2008 18:53:30 -0600
Message-ID: <1227056010-6919-1-git-send-email-mesak82@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47693 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbYKSAxk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2008 19:53:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vikram.pandita@ti.com, Misael Lopez Cruz <mesak82@gmail.com>

From: Misael Lopez Cruz <mesak82@gmail.com>

This patch updates McBSP driver with the changes in "struct omap_mcbsp".
omap_mcbsp structure suffered some changes because of a virtual/physical
addresses fix and McBSP driver was not properly updated. It was causing
DMA transaction errors and several compilation warnings.

Signed-off-by: Misael Lopez Cruz <mesak82gmail.com>
---
 arch/arm/mach-omap2/mcbsp.c             |  107 ++++++++++++++++++-------------
 arch/arm/plat-omap/include/mach/mcbsp.h |   58 ++++++++--------
 arch/arm/plat-omap/mcbsp.c              |   11 +++-
 3 files changed, 100 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index ce726c5..359147e 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -156,7 +156,8 @@ static void omap2_mcbsp_request(unsigned int id)
 static void  mcbsp_power_settings(unsigned int id, int level)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
+
 	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
@@ -196,7 +197,8 @@ void omap2_mcbsp_config(unsigned int id,
 			 const struct omap_mcbsp_reg_cfg *config)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
+
 	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_XCCR, config->xccr);
@@ -210,7 +212,8 @@ static struct omap_mcbsp_ops omap2_mcbsp_ops = {
 static void omap2_mcbsp_rx_dma_callback(int lch, u16 ch_status, void *data)
 {
 	struct omap_mcbsp *mcbsp_dma_rx = data;
-	u32 io_base;
+	void __iomem *io_base;
+
 	io_base = mcbsp_dma_rx->io_base;
 
 	/* If we are at the last transfer, Shut down the reciever */
@@ -229,7 +232,8 @@ static void omap2_mcbsp_rx_dma_callback(int lch, u16 ch_status, void *data)
 static void omap2_mcbsp_tx_dma_callback(int lch, u16 ch_status, void *data)
 {
 	struct omap_mcbsp *mcbsp_dma_tx = data;
-	u32 io_base;
+	void __iomem *io_base;
+
 	io_base = mcbsp_dma_tx->io_base;
 
 	/* If we are at the last transfer, Shut down the Transmitter */
@@ -318,9 +322,11 @@ void omap2_mcbsp_set_srg_cfg_param(unsigned int id, int interface_mode,
 					struct omap_mcbsp_reg_cfg *mcbsp_cfg,
 					struct omap_mcbsp_srg_fsg_cfg *param)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 	u32 clk_rate, clkgdv;
+
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	mcbsp->interface_mode = interface_mode;
@@ -433,9 +439,10 @@ EXPORT_SYMBOL(omap2_mcbsp_params_cfg);
  */
 void omap2_mcbsp_set_srg_fsg(unsigned int id, u8 state)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	if (state == OMAP_MCBSP_DISABLE_FSG_SRG) {
@@ -460,14 +467,15 @@ void omap2_mcbsp_set_srg_fsg(unsigned int id, u8 state)
  */
 int omap2_mcbsp_stop_datatx(unsigned int id)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	if (mcbsp->dma_tx_lch != -1) {
@@ -491,14 +499,15 @@ EXPORT_SYMBOL(omap2_mcbsp_stop_datatx);
  */
 int omap2_mcbsp_stop_datarx(u32 id)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	if (mcbsp->dma_rx_lch != -1) {
@@ -523,8 +532,8 @@ EXPORT_SYMBOL(omap2_mcbsp_stop_datarx);
  */
 int omap2_mcbsp_reset(unsigned int id)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 	int counter = 0;
 	int wait_for_reset = 10000;
 
@@ -533,6 +542,7 @@ int omap2_mcbsp_reset(unsigned int id)
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	omap_mcbsp_write(io_base, OMAP_MCBSP_REG_SYSCON,
@@ -562,7 +572,7 @@ EXPORT_SYMBOL(omap2_mcbsp_reset);
  */
 int omap2_mcbsp_transmitter_index(int id, int *ei, int *fi)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
+	struct omap_mcbsp *mcbsp;
 	int eix = 0, fix = 0;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -570,6 +580,8 @@ int omap2_mcbsp_transmitter_index(int id, int *ei, int *fi)
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
+
 	if ((!ei) || (!fi)) {
 		printk(KERN_ERR	"OMAP_McBSP: Invalid ei and fi params \n");
 		goto txinx_err;
@@ -604,7 +616,7 @@ EXPORT_SYMBOL(omap2_mcbsp_transmitter_index);
  */
 int omap2_mcbsp_receiver_index(int id, int *ei, int *fi)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
+	struct omap_mcbsp *mcbsp;
 	int eix = 0, fix = 0;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
@@ -612,6 +624,8 @@ int omap2_mcbsp_receiver_index(int id, int *ei, int *fi)
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
+
 	if ((!ei) || (!fi)) {
 		printk(KERN_ERR	"OMAP_McBSP: Invalid ei and fi params x\n");
 		goto rxinx_err;
@@ -646,13 +660,15 @@ EXPORT_SYMBOL(omap2_mcbsp_receiver_index);
  */
 int omap2_mcbsp_set_xrst(unsigned int id, u8 state)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	if (state == OMAP_MCBSP_XRST_DISABLE)
@@ -674,13 +690,15 @@ EXPORT_SYMBOL(omap2_mcbsp_set_xrst);
  */
 int omap2_mcbsp_set_rrst(unsigned int id, u8 state)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	if (state == OMAP_MCBSP_RRST_DISABLE)
@@ -702,14 +720,15 @@ EXPORT_SYMBOL(omap2_mcbsp_set_rrst);
  */
 int omap2_mcbsp_rxmultich_enable(unsigned int id, u8 state)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	if (state == OMAP_MCBSP_RXMUTICH_ENABLE) {
@@ -742,15 +761,15 @@ EXPORT_SYMBOL(omap2_mcbsp_rxmultich_enable);
  */
 int omap2_mcbsp_txmultich_enable(unsigned int id, u32 state)
 {
-
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	if (state == OMAP_MCBSP_TXMUTICH_ENABLE) {
@@ -787,14 +806,15 @@ EXPORT_SYMBOL(omap2_mcbsp_txmultich_enable);
 int omap2_mcbsp_txmultich_cfg(unsigned int id, u8 part_mode, u8 parta_enable,
 					 u8 partb_enable, u32 ch_enable)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	/* check for valid partition mode */
@@ -826,14 +846,15 @@ EXPORT_SYMBOL(omap2_mcbsp_txmultich_cfg);
 int omap2_mcbsp_rxmultich_cfg(unsigned int id, u8 part_mode,
 			       u8 parta_enable, u8 partb_enable, u32 ch_enable)
 {
-	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
-	u32 io_base;
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
 
 	if (!omap_mcbsp_check_valid_id(id)) {
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
 	/* check for valid partition mode */
@@ -861,7 +882,7 @@ int omap2_mcbsp_dma_recv_params(unsigned int id,
 				omap_mcbsp_dma_transfer_params *rp)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	int err, chain_id = -1;
 	struct omap_dma_channel_params rx_params;
 	u32  dt = 0;
@@ -971,10 +992,9 @@ int omap2_mcbsp_dma_trans_params(unsigned int id,
 				omap_mcbsp_dma_transfer_params *tp)
 {
 	struct omap_mcbsp *mcbsp;
-
+	void __iomem *io_base;
 	struct omap_dma_channel_params tx_params;
 	int err = 0, chain_id = -1;
-	u32 io_base;
 	u32 dt = 0;
 #ifdef CONFIG_USE_MCBSP_FIFO
 	u32 mcbsp_fifo_size;
@@ -1088,7 +1108,7 @@ int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
 			     dma_addr_t buf_start_addr, u32 buf_size)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	int enable_rx = 0;
 	int e_count = 0;
 	int f_count = 0;
@@ -1104,9 +1124,7 @@ int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
 	}
 
 	mcbsp = id_to_mcbsp_ptr(id);
-
 	io_base = mcbsp->io_base;
-
 	mcbsp->rx_cb_arg = cbdata;
 
 	/* Auto RRST handling logic - disable the Reciever before 1st dma */
@@ -1192,7 +1210,7 @@ int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
 		buf_start_addr += mcbsp->rx_word_length;
 
 	if (omap_dma_chain_a_transfer(mcbsp->dma_rx_lch,
-			mcbsp->phy_base + OMAP_MCBSP_REG_DRR, buf_start_addr,
+			mcbsp->phys_base + OMAP_MCBSP_REG_DRR, buf_start_addr,
 			e_count, f_count, mcbsp) < 0) {
 		printk(KERN_ERR " Buffer chaining failed \n");
 		return -EINVAL;
@@ -1227,7 +1245,7 @@ int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
 			  dma_addr_t buf_start_addr, u32 buf_size)
 {
 	struct omap_mcbsp *mcbsp;
-	u32 io_base;
+	void __iomem *io_base;
 	u8 enable_tx = 0;
 	int e_count = 0;
 	int f_count = 0;
@@ -1236,10 +1254,9 @@ int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
 		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
 		return -ENODEV;
 	}
-	mcbsp = id_to_mcbsp_ptr(id);
 
+	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
-
 	mcbsp->tx_cb_arg = cbdata;
 
 	/* Auto RRST handling logic - disable the Reciever before 1st dma */
@@ -1277,7 +1294,7 @@ int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
 		buf_start_addr += mcbsp->tx_word_length;
 
 	if (omap_dma_chain_a_transfer(mcbsp->dma_tx_lch,
-		buf_start_addr,	mcbsp->phy_base + OMAP_MCBSP_REG_DXR,
+		buf_start_addr,	mcbsp->phys_base + OMAP_MCBSP_REG_DXR,
 		e_count, f_count, mcbsp) < 0)
 			return -EINVAL;
 
@@ -1385,7 +1402,7 @@ static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 #ifdef CONFIG_ARCH_OMAP34XX
 static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	{
-		.phy_base	= OMAP34XX_MCBSP1_BASE,
+		.phys_base	= OMAP34XX_MCBSP1_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
@@ -1394,7 +1411,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.phy_base	= OMAP34XX_MCBSP2_BASE,
+		.phys_base	= OMAP34XX_MCBSP2_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -1403,7 +1420,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.phy_base	= OMAP34XX_MCBSP3_BASE,
+		.phys_base	= OMAP34XX_MCBSP3_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
@@ -1412,7 +1429,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.phy_base	= OMAP34XX_MCBSP4_BASE,
+		.phys_base	= OMAP34XX_MCBSP4_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
@@ -1421,7 +1438,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.clk_name	= "mcbsp_clk",
 	},
 	{
-		.phy_base	= OMAP34XX_MCBSP5_BASE,
+		.phys_base	= OMAP34XX_MCBSP5_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 68fe194..3e38575 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -1,5 +1,5 @@
 /*
- * linux/include/asm-arm/arch-omap/mcbsp.h
+ * arch/arm/plat-omap/include/mach/mcbsp.h
  *
  * Defines for Multi-Channel Buffered Serial Port
  *
@@ -26,10 +26,10 @@
 
 #include <linux/completion.h>
 #include <linux/spinlock.h>
-#include <mach/dma.h>
 
 #include <mach/hardware.h>
 #include <mach/clock.h>
+#include <mach/dma.h>
 
 #define MCBSP_FIFO_SIZE 64
 #define MCBSP2_FIFO_SIZE 1024
@@ -380,31 +380,31 @@ struct omap_mcbsp_srg_fsg_cfg {
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
-	u32 spcr2;
-	u32 spcr1;
-	u32 rcr2;
-	u32 rcr1;
-	u32 xcr2;
-	u32 xcr1;
-	u32 srgr2;
-	u32 srgr1;
-	u32 mcr2;
-	u32 mcr1;
-	u32 pcr0;
-	u32 rcerc;
-	u32 rcerd;
-	u32 xcerc;
-	u32 xcerd;
-	u32 rcere;
-	u32 rcerf;
-	u32 xcere;
-	u32 xcerf;
-	u32 rcerg;
-	u32 rcerh;
-	u32 xcerg;
-	u32 xcerh;
-	u32 xccr;
-	u32 rccr;
+	u16 spcr2;
+	u16 spcr1;
+	u16 rcr2;
+	u16 rcr1;
+	u16 xcr2;
+	u16 xcr1;
+	u16 srgr2;
+	u16 srgr1;
+	u16 mcr2;
+	u16 mcr1;
+	u16 pcr0;
+	u16 rcerc;
+	u16 rcerd;
+	u16 xcerc;
+	u16 xcerd;
+	u16 rcere;
+	u16 rcerf;
+	u16 xcere;
+	u16 xcerf;
+	u16 rcerg;
+	u16 rcerh;
+	u16 xcerg;
+	u16 xcerh;
+	u16 xccr;
+	u16 rccr;
 };
 
 typedef enum {
@@ -481,7 +481,7 @@ struct omap_mcbsp_ops {
 };
 
 struct omap_mcbsp_platform_data {
-	unsigned long phy_base;
+	unsigned long phys_base;
 	u8 dma_rx_sync, dma_tx_sync;
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
@@ -518,7 +518,6 @@ struct omap_mcbsp {
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
 	struct clk *clk;
-	u32 phy_base;
 	u8  auto_reset;	/* Auto Reset */
 	u8  txskip_alt;	/* Tx skip flags */
 	u8  rxskip_alt;	/* Rx skip flags */
@@ -554,6 +553,7 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word);
 int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word);
 
+
 /* SPI specific API */
 void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg * spi_cfg);
 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 8d6cc35..906e8e3 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -52,6 +52,9 @@ int omap_mcbsp_read(void __iomem *io_base, u16 reg)
 #define OMAP_MCBSP_WRITE(base, reg, val) \
 			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
 
+#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
+#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
+
 static void omap_mcbsp_dump_reg(u8 id)
 {
 	struct omap_mcbsp *mcbsp = id_to_mcbsp_ptr(id);
@@ -224,6 +227,8 @@ int omap_mcbsp_request(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(id);
 
+	clk_enable(mcbsp->clk);
+
 	spin_lock(&mcbsp->lock);
 	if (!mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
@@ -283,6 +288,8 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
+	clk_disable(mcbsp->clk);
+
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free) {
 		dev_err(mcbsp->dev, "McBSP%d was not reserved\n",
@@ -897,8 +904,8 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 	mcbsp->dma_tx_lch = -1;
 	mcbsp->dma_rx_lch = -1;
 
-	mcbsp->phys_base = pdata->phy_base;
-	mcbsp->io_base = ioremap(pdata->phy_base, SZ_4K);
+	mcbsp->phys_base = pdata->phys_base;
+	mcbsp->io_base = ioremap(pdata->phys_base, SZ_4K);
 	if (!mcbsp->io_base) {
 		ret = -ENOMEM;
 		goto err_ioremap;
-- 
1.5.6.3

