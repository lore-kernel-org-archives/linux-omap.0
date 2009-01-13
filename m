From: ext-eero.nurkkala@nokia.com
Subject: [PATCH] McBSP: Sidetone functionality
Date: Tue, 13 Jan 2009 14:41:45 +0200
Message-ID: <12318505051015-git-send-email-ext-eero.nurkkala@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38480 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758675AbZAMMpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 07:45:07 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0DCiYhm011351
	for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2009 14:45:01 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This provides full support for the sidetone
functionality in 3430 OMAPs. Please note that
TDM mode audio should be used to take full
advantage of the sidetone functionalities.

This patch is built on top of commits:

Stanley.Miao:
[PATCH] OMAP: Fix McBSP spin_lock deadlock.

Eero Nurkkala:
McBSP: Provide functions for ASoC frame syncronization

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c             |    4 +
 arch/arm/plat-omap/include/mach/mcbsp.h |   66 +++++++-
 arch/arm/plat-omap/mcbsp.c              |  307 +++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index cae3ebe..6ddb01f 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -239,19 +239,23 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
+		.phys_base_st	= OMAP34XX_MCBSP2_ST_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
+		.st_irq		= INT_34XX_ST_MCBSP2_IRQ,
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
+		.phys_base_st	= OMAP34XX_MCBSP3_ST_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
+		.st_irq		= INT_34XX_ST_MCBSP3_IRQ,
 		.ops		= &omap2_mcbsp_ops,
 		.clk_name	= "mcbsp_clk",
 	},
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 07dfcd0..1b588dc 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -49,7 +49,9 @@
 
 #define OMAP34XX_MCBSP1_BASE	0x48074000
 #define OMAP34XX_MCBSP2_BASE	0x49022000
+#define OMAP34XX_MCBSP2_ST_BASE	0x49028000
 #define OMAP34XX_MCBSP3_BASE	0x49024000
+#define OMAP34XX_MCBSP3_ST_BASE	0x4902A000
 #define OMAP34XX_MCBSP4_BASE	0x49026000
 #define OMAP34XX_MCBSP5_BASE	0x48096000
 
@@ -132,6 +134,15 @@
 #define OMAP_MCBSP_REG_SYSCON	0x8C
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
+#define OMAP_MCBSP_REG_SSELCR	0xBC
+
+#define OMAP_ST_REG_REV		0x00
+#define OMAP_ST_REG_SYSCONFIG	0x10
+#define OMAP_ST_REG_IRQSTATUS	0x18
+#define OMAP_ST_REG_IRQENABLE	0x1C
+#define OMAP_ST_REG_SGAINCR	0x24
+#define OMAP_ST_REG_SFIRCR	0x28
+#define OMAP_ST_REG_SSELCR	0x2C
 
 #define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
 #define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
@@ -247,6 +258,34 @@
 /********************** McBSP SYSCONFIG bit definitions ********************/
 #define SOFTRST			0x0002
 
+/********************** McBSP SSELCR bit definitions ***********************/
+#define SIDETONEEN		0x0400
+#define OCH1ASSIGN(value)	((value<<7))	/* Bits 7:9 */
+#define OCH0ASSIGN(value)	((value<<4))	/* Bits 4:6 */
+#define ICH1ASSIGN(value)	((value<<2))	/* Bits 2:3 */
+#define ICH0ASSIGN(value)	(value)		/* Bits 0:1 */
+
+/********************** McBSP Sidetone SYSCONFIG bit definitions ***********/
+#define ST_AUTOIDLE		0x0001
+
+/********************** McBSP Sidetone IRQSTATUS bit definitions ***********/
+#define ST_OVRRERROR		0x0001
+
+/********************** McBSP Sidetone IRQENABLE bit definitions ***********/
+#define ST_OVRRERROREN		0x0001
+
+/********************** McBSP Sidetone SGAINCR bit definitions *************/
+#define ST_CH1GAIN(value)	((value<<16))	/* Bits 16:31 */
+#define ST_CH0GAIN(value)	(value)		/* Bits 0:15 */
+
+/********************** McBSP Sidetone SFIRCR bit definitions **************/
+#define ST_FIRCOEFF(value)	(value)		/* Bits 0:15 */
+
+/********************** McBSP Sidetone SSELCR bit definitions **************/
+#define ST_COEFFWRDONE		0x0004
+#define ST_COEFFWREN		0x0002
+#define ST_SIDETONEEN		0x0001
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u16 spcr2;
@@ -276,6 +315,13 @@ struct omap_mcbsp_reg_cfg {
 	u16 rccr;
 };
 
+struct omap_st_channel_conf {
+	u8 och1assign;
+	u8 och0assign;
+	u8 ich1assign;
+	u8 ich0assign;
+};
+
 typedef enum {
 	OMAP_MCBSP1 = 0,
 	OMAP_MCBSP2,
@@ -336,9 +382,9 @@ struct omap_mcbsp_ops {
 };
 
 struct omap_mcbsp_platform_data {
-	unsigned long phys_base;
+	unsigned long phys_base, phys_base_st;
 	u8 dma_rx_sync, dma_tx_sync;
-	u16 rx_irq, tx_irq;
+	u16 rx_irq, tx_irq, st_irq;
 	struct omap_mcbsp_ops *ops;
 	char const *clk_name;
 };
@@ -346,7 +392,9 @@ struct omap_mcbsp_platform_data {
 struct omap_mcbsp {
 	struct device *dev;
 	unsigned long phys_base;
+	unsigned long phys_base_st;
 	void __iomem *io_base;
+	void __iomem *io_base_st;
 	u8 id;
 	u8 free;
 	omap_mcbsp_word_length rx_word_length;
@@ -356,6 +404,8 @@ struct omap_mcbsp {
 	/* IRQ based TX/RX */
 	int rx_irq;
 	int tx_irq;
+	/* Sidetone IRQ */
+	int st_irq;
 
 	/* DMA stuff */
 	u8 dma_rx_sync;
@@ -395,6 +445,18 @@ int omap_mcbsp_recv_buffer(unsigned int id, dma_addr_t buffer, unsigned int leng
 int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word);
 int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word);
 
+/* Sidetone functions */
+void omap_st_request(unsigned int id);
+void omap_st_free(unsigned int id);
+void omap_st_start(unsigned int id);
+void omap_st_stop(unsigned int id);
+void omap_st_channel_map(unsigned int id,
+				const struct omap_st_channel_conf *config);
+int omap_st_irq_start(unsigned int id);
+void omap_st_irq_stop(unsigned int id);
+void omap_st_fir_write(unsigned int id, s16 *fir);
+void omap_st_fir_read(unsigned int id, s16 *fir);
+void omap_st_chgain(unsigned int id, s16 ch0gain, s16 ch1gain);
 
 /* SPI specific API */
 void omap_mcbsp_set_spi_mode(unsigned int id, const struct omap_mcbsp_spi_cfg * spi_cfg);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 5c4162d..a98c891 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -54,6 +54,14 @@ int omap_mcbsp_read(void __iomem *io_base, u16 reg)
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
 
+#define OMAP_ST_READ(base, reg) \
+			omap_mcbsp_read(base, OMAP_ST_REG_##reg)
+#define OMAP_ST_WRITE(base, reg, val) \
+			omap_mcbsp_write(base, OMAP_ST_REG_##reg, val)
+
+#define omap_st_check_valid_id(id)	((id == 1 || id == 2) && \
+						id < omap_mcbsp_count)
+
 static void omap_mcbsp_dump_reg(u8 id)
 {
 	struct omap_mcbsp *mcbsp = id_to_mcbsp_ptr(id);
@@ -112,6 +120,16 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t omap_st_irq_handler(int irq, void *dev_id)
+{
+	struct omap_mcbsp *st = dev_id;
+
+	dev_dbg(st->dev, "ST IRQ callback : 0x%x\n",
+		OMAP_ST_READ(st->io_base_st, IRQSTATUS));
+
+	return IRQ_HANDLED;
+}
+
 static void omap_mcbsp_tx_dma_callback(int lch, u16 ch_status, void *data)
 {
 	struct omap_mcbsp *mcbsp_dma_tx = data;
@@ -916,6 +934,272 @@ void omap_mcbsp_set_spi_mode(unsigned int id,
 EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);
 
 /*
+ * Sidetone Functions
+ */
+void omap_st_request(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_st;
+	u16 w;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_st = mcbsp->io_base_st;
+
+	/* Enable the clock to ST core */
+	w = OMAP_ST_READ(io_base_st, SYSCONFIG);
+	OMAP_ST_WRITE(io_base_st, SYSCONFIG, w & ~(ST_AUTOIDLE));
+}
+EXPORT_SYMBOL(omap_st_request);
+
+void omap_st_free(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_st;
+	u16 w;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_st = mcbsp->io_base_st;
+
+	/* Disable the clock to ST core */
+	w = OMAP_ST_READ(io_base_st, SYSCONFIG);
+	OMAP_ST_WRITE(io_base_st, SYSCONFIG, w | ST_AUTOIDLE);
+}
+EXPORT_SYMBOL(omap_st_free);
+
+void omap_st_start(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_mcbsp;
+	void __iomem *io_base_st;
+	u16 w;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_mcbsp = mcbsp->io_base;
+	io_base_st = mcbsp->io_base_st;
+
+	/* Enable McBSP Sidetone */
+	w = OMAP_MCBSP_READ(io_base_mcbsp, SSELCR);
+	OMAP_MCBSP_WRITE(io_base_mcbsp, SSELCR, w | SIDETONEEN);
+
+	/* Enable Sidetone from Sidetone Core */
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+	OMAP_ST_WRITE(io_base_st, SSELCR, w | ST_SIDETONEEN);
+}
+EXPORT_SYMBOL(omap_st_start);
+
+void omap_st_stop(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_mcbsp;
+	void __iomem *io_base_st;
+	u16 w;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_mcbsp = mcbsp->io_base;
+	io_base_st = mcbsp->io_base_st;
+
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+	OMAP_ST_WRITE(io_base_st, SSELCR, w & ~(ST_SIDETONEEN));
+
+	w = OMAP_MCBSP_READ(io_base_mcbsp, SSELCR);
+	OMAP_MCBSP_WRITE(io_base_mcbsp, SSELCR, w & ~(SIDETONEEN));
+}
+EXPORT_SYMBOL(omap_st_stop);
+
+void omap_st_channel_map(unsigned int id,
+				const struct omap_st_channel_conf *config)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_mcbsp;
+	u16 w;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_mcbsp = mcbsp->io_base;
+
+	w = OMAP_MCBSP_READ(io_base_mcbsp, SSELCR);
+	w &= ~(0x03FF);
+	OMAP_MCBSP_WRITE(io_base_mcbsp, SSELCR, w | \
+					OCH1ASSIGN(config->och1assign) | \
+					OCH0ASSIGN(config->och0assign) | \
+					ICH1ASSIGN(config->ich1assign) | \
+					ICH0ASSIGN(config->ich0assign));
+}
+EXPORT_SYMBOL(omap_st_channel_map);
+
+int omap_st_irq_start(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_st;
+	int err = 0;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_st = mcbsp->io_base_st;
+
+	err = request_irq(mcbsp->st_irq, omap_st_irq_handler,
+				0, "McBSP", (void *)mcbsp);
+	if (err != 0) {
+		dev_err(mcbsp->dev, "Unable to request ST IRQ %d "
+				"for McBSP%d\n", mcbsp->st_irq,
+				mcbsp->id);
+		return err;
+	}
+
+	OMAP_ST_WRITE(io_base_st, IRQENABLE, ST_OVRRERROREN);
+
+	return err;
+}
+EXPORT_SYMBOL(omap_st_irq_start);
+
+void omap_st_irq_stop(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_st;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_st = mcbsp->io_base_st;
+
+	OMAP_ST_WRITE(io_base_st, IRQENABLE, 0);
+
+	free_irq(mcbsp->st_irq, (void *)mcbsp);
+}
+EXPORT_SYMBOL(omap_st_irq_stop);
+
+void omap_st_fir_write(unsigned int id, s16 *fir)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_st;
+	u16 w, i;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	if (!fir) {
+		printk(KERN_ERR "%s: Invalid fir (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_st = mcbsp->io_base_st;
+
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+
+	if (w & ST_SIDETONEEN) {
+		printk(KERN_ERR "%s: ST enabled! (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	if (w & ST_COEFFWREN)
+		OMAP_ST_WRITE(io_base_st, SSELCR, w & ~(ST_COEFFWREN));
+
+	OMAP_ST_WRITE(io_base_st, SSELCR, w | ST_COEFFWREN);
+
+	for (i = 0; i < 128; i++)
+		OMAP_ST_WRITE(io_base_st, SFIRCR, fir[i]);
+
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+	while (!(w & ST_COEFFWRDONE))
+		w = OMAP_ST_READ(io_base_st, SSELCR);
+
+	OMAP_ST_WRITE(io_base_st, SSELCR, w & ~(ST_COEFFWREN));
+}
+EXPORT_SYMBOL(omap_st_fir_write);
+
+void omap_st_fir_read(unsigned int id, s16 *fir)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_st;
+	u16 w, i;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	if (!fir) {
+		printk(KERN_ERR "%s: Invalid fir (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_st = mcbsp->io_base_st;
+
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+
+	if (w & ST_SIDETONEEN) {
+		printk(KERN_ERR "%s: ST enabled!(%d)\n", __func__, id + 1);
+		return;
+	}
+
+	if (w & ST_COEFFWREN)
+		OMAP_ST_WRITE(io_base_st, SSELCR, w | ST_COEFFWREN);
+
+	OMAP_ST_WRITE(io_base_st, SSELCR, w & ~(ST_COEFFWREN));
+
+	for (i = 0; i < 128; i++)
+		fir[i] = OMAP_ST_READ(io_base_st, SFIRCR);
+}
+EXPORT_SYMBOL(omap_st_fir_read);
+
+void omap_st_chgain(unsigned int id, s16 ch0gain, s16 ch1gain)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base_st;
+	u16 w;
+
+	if (!omap_st_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base_st = mcbsp->io_base_st;
+
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+
+	OMAP_ST_WRITE(io_base_st, SGAINCR, ST_CH0GAIN(ch0gain) | \
+			ST_CH1GAIN(ch1gain));
+
+}
+EXPORT_SYMBOL(omap_st_chgain);
+
+/*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
  * 730 has only 2 McBSP, and both of them are MPU peripherals.
  */
@@ -961,6 +1245,20 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
+	if (cpu_is_omap34xx()) {
+		mcbsp->phys_base_st = pdata->phys_base_st;
+		/* Not all McBSPs have Sidetone core */
+		if (mcbsp->phys_base_st) {
+			mcbsp->io_base_st = ioremap(pdata->phys_base_st,
+							SZ_4K);
+			if (!mcbsp->io_base_st) {
+				ret = -ENOMEM;
+				goto err_ioremap;
+			}
+		}
+		mcbsp->st_irq = pdata->st_irq;
+	}
+
 	/* Default I/O is IRQ based */
 	mcbsp->io_type = OMAP_MCBSP_IRQ_IO;
 	mcbsp->tx_irq = pdata->tx_irq;
@@ -985,6 +1283,10 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 
 err_clk:
 	iounmap(mcbsp->io_base);
+	if (cpu_is_omap34xx()) {
+		if (mcbsp->io_base_st)
+			iounmap(mcbsp->io_base_st);
+	}
 err_ioremap:
 	mcbsp->free = 0;
 exit:
@@ -1007,6 +1309,11 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 
 		iounmap(mcbsp->io_base);
 
+		if (cpu_is_omap34xx()) {
+			if (mcbsp->io_base_st)
+				iounmap(mcbsp->io_base_st);
+		}
+
 		mcbsp->clk = NULL;
 		mcbsp->free = 0;
 		mcbsp->dev = NULL;
-- 
1.5.2

