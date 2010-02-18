From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCHv4 1/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 20:42:28 +0200
Message-ID: <1266518549-23809-2-git-send-email-ilkka.koskinen@nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50835 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab0BRSlM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 13:41:12 -0500
In-Reply-To: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, jhnikula@gmail.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: eduardo.valentin@nokia.com, ext-Eero.Nurkkala@nokia.com

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Add sidetone feature to McBSP instances 2 and 3 on OMAP3 based devices.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c             |    2 +
 arch/arm/plat-omap/include/plat/mcbsp.h |   60 +++++
 arch/arm/plat-omap/mcbsp.c              |  402 ++++++++++++++++++++++++++++++-
 3 files changed, 463 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index d601f94..be8fce3 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -136,6 +136,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
+		.phys_base_st	= OMAP34XX_MCBSP2_ST_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -145,6 +146,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
+		.phys_base_st	= OMAP34XX_MCBSP3_ST_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 4df957b..3974835 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -49,6 +49,9 @@
 
 #define OMAP34XX_MCBSP1_BASE	0x48074000
 #define OMAP34XX_MCBSP2_BASE	0x49022000
+#define OMAP34XX_MCBSP2_ST_BASE	0x49028000
+#define OMAP34XX_MCBSP3_BASE	0x49024000
+#define OMAP34XX_MCBSP3_ST_BASE	0x4902A000
 #define OMAP34XX_MCBSP3_BASE	0x49024000
 #define OMAP34XX_MCBSP4_BASE	0x49026000
 #define OMAP34XX_MCBSP5_BASE	0x48096000
@@ -146,6 +149,15 @@
 #define OMAP_MCBSP_REG_WAKEUPEN	0xA8
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
@@ -264,6 +276,24 @@
 #define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
 
+/********************** McBSP SSELCR bit definitions ***********************/
+#define SIDETONEEN		0x0400
+
+/********************** McBSP Sidetone SYSCONFIG bit definitions ***********/
+#define ST_AUTOIDLE		0x0001
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
 /********************** McBSP DMA operating modes **************************/
 #define MCBSP_DMA_MODE_ELEMENT		0
 #define MCBSP_DMA_MODE_THRESHOLD	1
@@ -374,10 +404,22 @@ struct omap_mcbsp_platform_data {
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
 #ifdef CONFIG_ARCH_OMAP3
+	/* Sidetone block for McBSP 2 and 3 */
+	unsigned long phys_base_st;
 	u16 buffer_size;
 #endif
 };
 
+struct omap_mcbsp_st_data {
+	void __iomem *io_base_st;
+	bool running;
+	bool enabled;
+	s16 taps[128];	/* Sidetone filter coefficients */
+	int nr_taps;	/* Number of filter coefficients in use */
+	s16 ch0gain;
+	s16 ch1gain;
+};
+
 struct omap_mcbsp {
 	struct device *dev;
 	unsigned long phys_base;
@@ -410,6 +452,7 @@ struct omap_mcbsp {
 	struct clk *iclk;
 	struct clk *fclk;
 #ifdef CONFIG_ARCH_OMAP3
+	struct omap_mcbsp_st_data *st_data;
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
@@ -459,4 +502,21 @@ int omap_mcbsp_pollread(unsigned int id, u16 * buf);
 int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
 int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t io_type);
 
+#ifdef CONFIG_ARCH_OMAP3
+/* Sidetone specific API */
+int omap_st_set_chgain(unsigned int id, int channel, s16 chgain);
+int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain);
+int omap_st_enable(unsigned int id);
+int omap_st_disable(unsigned int id);
+int omap_st_is_enabled(unsigned int id);
+#else
+static inline int omap_st_set_chgain(unsigned int id, int channel,
+				     s16 chgain) { return 0; }
+static inline int omap_st_get_chgain(unsigned int id, int channel,
+				     s16 *chgain) { return 0; }
+static inline int omap_st_enable(unsigned int id) { return 0; }
+static inline int omap_st_disable(unsigned int id) { return 0; }
+static inline int omap_st_is_enabled(unsigned int id) {  return 0; }
+#endif
+
 #endif
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 473be3d..e47686e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -27,6 +27,8 @@
 #include <plat/dma.h>
 #include <plat/mcbsp.h>
 
+#include "../mach-omap2/cm-regbits-34xx.h"
+
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count, omap_mcbsp_cache_size;
 
@@ -58,6 +60,18 @@ int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 	}
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+void omap_mcbsp_st_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
+{
+	__raw_writel(val, mcbsp->st_data->io_base_st + reg);
+}
+
+int omap_mcbsp_st_read(struct omap_mcbsp *mcbsp, u16 reg)
+{
+	return __raw_readl(mcbsp->st_data->io_base_st + reg);
+}
+#endif
+
 #define MCBSP_READ(mcbsp, reg) \
 		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
 #define MCBSP_WRITE(mcbsp, reg, val) \
@@ -68,6 +82,11 @@ int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
 
+#define MCBSP_ST_READ(mcbsp, reg) \
+			omap_mcbsp_st_read(mcbsp, OMAP_ST_REG_##reg)
+#define MCBSP_ST_WRITE(mcbsp, reg, val) \
+			omap_mcbsp_st_write(mcbsp, OMAP_ST_REG_##reg, val)
+
 static void omap_mcbsp_dump_reg(u8 id)
 {
 	struct omap_mcbsp *mcbsp = id_to_mcbsp_ptr(id);
@@ -211,6 +230,257 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 EXPORT_SYMBOL(omap_mcbsp_config);
 
 #ifdef CONFIG_ARCH_OMAP3
+static void omap_st_on(struct omap_mcbsp *mcbsp)
+{
+	unsigned int w;
+
+	/*
+	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
+	 * are enabled or sidetones start sounding ugly.
+	 */
+	w = cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	w &= ~(1 << (mcbsp->id - 2));
+	cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+
+	/* Enable McBSP Sidetone */
+	w = MCBSP_READ(mcbsp, SSELCR);
+	MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
+
+	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+
+	/* Enable Sidetone from Sidetone Core */
+	w = MCBSP_ST_READ(mcbsp, SSELCR);
+	MCBSP_ST_WRITE(mcbsp, SSELCR, w | ST_SIDETONEEN);
+}
+
+static void omap_st_off(struct omap_mcbsp *mcbsp)
+{
+	unsigned int w;
+
+	w = MCBSP_ST_READ(mcbsp, SSELCR);
+	MCBSP_ST_WRITE(mcbsp, SSELCR, w & ~(ST_SIDETONEEN));
+
+	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
+
+	w = MCBSP_READ(mcbsp, SSELCR);
+	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
+
+	w = cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	w |= 1 << (mcbsp->id - 2);
+	cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+}
+
+static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
+{
+	u16 val, i;
+
+	val = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, val & ~(ST_AUTOIDLE));
+
+	val = MCBSP_ST_READ(mcbsp, SSELCR);
+
+	if (val & ST_COEFFWREN)
+		MCBSP_ST_WRITE(mcbsp, SSELCR, val & ~(ST_COEFFWREN));
+
+	MCBSP_ST_WRITE(mcbsp, SSELCR, val | ST_COEFFWREN);
+
+	for (i = 0; i < 128; i++)
+		MCBSP_ST_WRITE(mcbsp, SFIRCR, fir[i]);
+
+	i = 0;
+
+	val = MCBSP_ST_READ(mcbsp, SSELCR);
+	while (!(val & ST_COEFFWRDONE) && (++i < 1000))
+		val = MCBSP_ST_READ(mcbsp, SSELCR);
+
+	MCBSP_ST_WRITE(mcbsp, SSELCR, val & ~(ST_COEFFWREN));
+
+	if (i == 1000)
+		dev_err(mcbsp->dev, "McBSP FIR load error!\n");
+}
+
+static void omap_st_chgain(struct omap_mcbsp *mcbsp)
+{
+	u16 w;
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+
+	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+
+	w = MCBSP_ST_READ(mcbsp, SSELCR);
+
+	MCBSP_ST_WRITE(mcbsp, SGAINCR, ST_CH0GAIN(st_data->ch0gain) | \
+		      ST_CH1GAIN(st_data->ch1gain));
+}
+
+int omap_st_set_chgain(unsigned int id, int channel, s16 chgain)
+{
+	struct omap_mcbsp *mcbsp;
+	struct omap_mcbsp_st_data *st_data;
+	int ret = 0;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	st_data = mcbsp->st_data;
+
+	if (!st_data)
+		return -ENOENT;
+
+	spin_lock_irq(&mcbsp->lock);
+	if (channel == 0)
+		st_data->ch0gain = chgain;
+	else if (channel == 1)
+		st_data->ch1gain = chgain;
+	else
+		ret = -EINVAL;
+
+	if (st_data->enabled)
+		omap_st_chgain(mcbsp);
+	spin_unlock_irq(&mcbsp->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_st_set_chgain);
+
+int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain)
+{
+	struct omap_mcbsp *mcbsp;
+	struct omap_mcbsp_st_data *st_data;
+	int ret = 0;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	st_data = mcbsp->st_data;
+
+	if (!st_data)
+		return -ENOENT;
+
+	spin_lock_irq(&mcbsp->lock);
+	if (channel == 0)
+		*chgain = st_data->ch0gain;
+	else if (channel == 1)
+		*chgain = st_data->ch1gain;
+	else
+		ret = -EINVAL;
+	spin_unlock_irq(&mcbsp->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_st_get_chgain);
+
+static int omap_st_start(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+
+	if (st_data && st_data->enabled && !st_data->running) {
+		omap_st_fir_write(mcbsp, st_data->taps);
+		omap_st_chgain(mcbsp);
+
+		if (!mcbsp->free) {
+			omap_st_on(mcbsp);
+			st_data->running = 1;
+		}
+	}
+
+	return 0;
+}
+
+int omap_st_enable(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	struct omap_mcbsp_st_data *st_data;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	st_data = mcbsp->st_data;
+
+	if (!st_data)
+		return -ENODEV;
+
+	spin_lock_irq(&mcbsp->lock);
+	st_data->enabled = 1;
+	omap_st_start(mcbsp);
+	spin_unlock_irq(&mcbsp->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_st_enable);
+
+static int omap_st_stop(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+
+	if (st_data && st_data->running) {
+		if (!mcbsp->free) {
+			omap_st_off(mcbsp);
+			st_data->running = 0;
+		}
+	}
+
+	return 0;
+}
+
+int omap_st_disable(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	struct omap_mcbsp_st_data *st_data;
+	int ret = 0;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	st_data = mcbsp->st_data;
+
+	if (!st_data)
+		return -ENODEV;
+
+	spin_lock_irq(&mcbsp->lock);
+	omap_st_stop(mcbsp);
+	st_data->enabled = 0;
+	spin_unlock_irq(&mcbsp->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_st_disable);
+
+int omap_st_is_enabled(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+	struct omap_mcbsp_st_data *st_data;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+
+	mcbsp = id_to_mcbsp_ptr(id);
+	st_data = mcbsp->st_data;
+
+	if (!st_data)
+		return -ENODEV;
+
+
+	return st_data->enabled;
+}
+EXPORT_SYMBOL(omap_st_is_enabled);
+
 /*
  * omap_mcbsp_set_tx_threshold configures how to deal
  * with transmit threshold. the threshold value and handler can be
@@ -363,6 +633,8 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 #else
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp) {}
 static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp) {}
+static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
+static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
 #endif
 
 /*
@@ -546,6 +818,9 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
+	if (cpu_is_omap34xx())
+		omap_st_start(mcbsp);
+
 	mcbsp->rx_word_length = (MCBSP_READ_CACHE(mcbsp, RCR1) >> 5) & 0x7;
 	mcbsp->tx_word_length = (MCBSP_READ_CACHE(mcbsp, XCR1) >> 5) & 0x7;
 
@@ -637,6 +912,9 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 		w = MCBSP_READ_CACHE(mcbsp, SPCR2);
 		MCBSP_WRITE(mcbsp, SPCR2, w & ~(1 << 6));
 	}
+
+	if (cpu_is_omap34xx())
+		omap_st_stop(mcbsp);
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
@@ -1212,6 +1490,64 @@ unlock:
 
 static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
 
+static ssize_t st_taps_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	ssize_t status = 0;
+	int i;
+
+	spin_lock_irq(&mcbsp->lock);
+	for (i = 0; i < st_data->nr_taps; i++)
+		status += sprintf(&buf[status], (i ? ", %d" : "%d"),
+				  st_data->taps[i]);
+	if (i)
+		status += sprintf(&buf[status], "\n");
+	spin_unlock_irq(&mcbsp->lock);
+
+	return status;
+}
+
+static ssize_t st_taps_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	int val, tmp, status, i = 0;
+
+	spin_lock_irq(&mcbsp->lock);
+	memset(st_data->taps, 0, sizeof(st_data->taps));
+	st_data->nr_taps = 0;
+
+	do {
+		status = sscanf(buf, "%d%n", &val, &tmp);
+		if (status < 0 || status == 0) {
+			size = -EINVAL;
+			goto out;
+		}
+		if (val < -32768 || val > 32767) {
+			size = -EINVAL;
+			goto out;
+		}
+		st_data->taps[i++] = val;
+		buf += tmp;
+		if (*buf != ',')
+			break;
+		buf++;
+	} while (1);
+
+	st_data->nr_taps = i;
+
+out:
+	spin_unlock_irq(&mcbsp->lock);
+
+	return size;
+}
+
+static DEVICE_ATTR(st_taps, 0644, st_taps_show, st_taps_store);
+
 static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
@@ -1233,6 +1569,60 @@ static inline void __devexit omap_additional_remove(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &additional_attr_group);
 }
 
+static const struct attribute *sidetone_attrs[] = {
+	&dev_attr_st_taps.attr,
+	NULL,
+};
+
+static const struct attribute_group sidetone_attr_group = {
+	.attrs = (struct attribute **)sidetone_attrs,
+};
+
+int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_platform_data *pdata = mcbsp->pdata;
+	struct omap_mcbsp_st_data *st_data;
+	int err;
+
+	st_data = kzalloc(sizeof(*mcbsp->st_data), GFP_KERNEL);
+	if (!st_data) {
+		err = -ENOMEM;
+		goto err1;
+	}
+
+	st_data->io_base_st = ioremap(pdata->phys_base_st, SZ_4K);
+	if (!st_data->io_base_st) {
+		err = -ENOMEM;
+		goto err2;
+	}
+
+	err = sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group);
+	if (err)
+		goto err3;
+
+	mcbsp->st_data = st_data;
+	return 0;
+
+err3:
+	iounmap(st_data->io_base_st);
+err2:
+	kfree(st_data);
+err1:
+	return err;
+
+}
+
+static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+
+	if (st_data) {
+		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
+		iounmap(st_data->io_base_st);
+		kfree(st_data);
+	}
+}
+
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 {
 	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
@@ -1246,6 +1636,12 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 		if (omap_additional_add(mcbsp->dev))
 			dev_warn(mcbsp->dev,
 				"Unable to create additional controls\n");
+
+		if (mcbsp->id == 2 || mcbsp->id == 3)
+			if (omap_st_add(mcbsp))
+				dev_warn(mcbsp->dev,
+				 "Unable to create sidetone controls\n");
+
 	} else {
 		mcbsp->max_tx_thres = -EINVAL;
 		mcbsp->max_rx_thres = -EINVAL;
@@ -1254,8 +1650,12 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 
 static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
 {
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
 		omap_additional_remove(mcbsp->dev);
+
+		if (mcbsp->id == 2 || mcbsp->id == 3)
+			omap_st_remove(mcbsp);
+	}
 }
 #else
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
-- 
1.6.0.4

