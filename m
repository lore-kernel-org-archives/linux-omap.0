From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 3/8] McBSP: OMAP3: Add Sidetone feature
Date: Thu,  8 Oct 2009 14:58:52 +0300
Message-ID: <1255003137-1034-4-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55139 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939AbZJHMB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:28 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

Add Sidetone feature to mcbsp instances 2 and 3 on OMAP3 based devices.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c             |    2 +
 arch/arm/plat-omap/include/mach/mcbsp.h |   43 ++++
 arch/arm/plat-omap/mcbsp.c              |  379 ++++++++++++++++++++++++++++++-
 3 files changed, 423 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index a846aa1..c5b4d33 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -132,6 +132,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
+		.phys_base_st	= OMAP34XX_MCBSP2_ST_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
@@ -141,6 +142,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
+		.phys_base_st	= OMAP34XX_MCBSP3_ST_BASE,
 		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
 		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 7e9cae3..8ecc09d 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -49,6 +49,9 @@
 
 #define OMAP34XX_MCBSP1_BASE	0x48074000
 #define OMAP34XX_MCBSP2_BASE	0x49022000
+#define OMAP34XX_MCBSP2_ST_BASE	0x49028000
+#define OMAP34XX_MCBSP3_BASE	0x49024000
+#define OMAP34XX_MCBSP3_ST_BASE	0x4902A000
 #define OMAP34XX_MCBSP3_BASE	0x49024000
 #define OMAP34XX_MCBSP4_BASE	0x49026000
 #define OMAP34XX_MCBSP5_BASE	0x48096000
@@ -147,6 +150,15 @@
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
@@ -265,6 +277,24 @@
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
@@ -375,10 +405,22 @@ struct omap_mcbsp_platform_data {
 	u16 rx_irq, tx_irq;
 	struct omap_mcbsp_ops *ops;
 #ifdef CONFIG_ARCH_OMAP34XX
+	/* Sidetone block for McBSP 2 and 3 */
+	unsigned long phys_base_st;
 	u16 buffer_size;
 #endif
 };
 
+struct omap_mcbsp_st_data {
+	void __iomem *io_base_st;
+	int enabled;
+	int running;
+	s16 taps[128];	/* Sidetone filter coefficients */
+	int nr_taps;	/* Number of filter coefficients in use */
+	s16 ch0gain;
+	s16 ch1gain;
+};
+
 struct omap_mcbsp {
 	struct device *dev;
 	unsigned long phys_base;
@@ -411,6 +453,7 @@ struct omap_mcbsp {
 	struct clk *iclk;
 	struct clk *fclk;
 #ifdef CONFIG_ARCH_OMAP34XX
+	struct omap_mcbsp_st_data *st_data;
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 88ac976..9baa4b4 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -26,6 +26,9 @@
 
 #include <mach/dma.h>
 #include <mach/mcbsp.h>
+#ifdef CONFIG_ARCH_OMAP34XX
+#include "../mach-omap2/cm-regbits-34xx.h"
+#endif
 
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count;
@@ -54,6 +57,11 @@ int omap_mcbsp_read(void __iomem *io_base, u16 reg)
 #define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
 #define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
 
+#define OMAP_ST_READ(base, reg) \
+			omap_mcbsp_read(base, OMAP_ST_REG_##reg)
+#define OMAP_ST_WRITE(base, reg, val) \
+			omap_mcbsp_write(base, OMAP_ST_REG_##reg, val)
+
 static void omap_mcbsp_dump_reg(u8 id)
 {
 	struct omap_mcbsp *mcbsp = id_to_mcbsp_ptr(id);
@@ -199,6 +207,160 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 EXPORT_SYMBOL(omap_mcbsp_config);
 
 #ifdef CONFIG_ARCH_OMAP34XX
+static void omap_st_enable(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data;
+	void __iomem *io_base_mcbsp;
+	void __iomem *io_base_st;
+	unsigned int w;
+
+	io_base_mcbsp = mcbsp->io_base;
+	st_data = mcbsp->st_data;
+	io_base_st = st_data->io_base_st;
+
+	/*
+	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
+	 * are enabled or sidetones start sounding ugly.
+	 */
+	w = cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	w &= ~(mcbsp->id - 1);
+	cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+
+	/* Enable McBSP Sidetone */
+	w = OMAP_MCBSP_READ(io_base_mcbsp, SSELCR);
+	OMAP_MCBSP_WRITE(io_base_mcbsp, SSELCR, w | SIDETONEEN);
+
+	w = OMAP_ST_READ(io_base_st, SYSCONFIG);
+	OMAP_ST_WRITE(io_base_st, SYSCONFIG, w & ~(ST_AUTOIDLE));
+
+	/* Enable Sidetone from Sidetone Core */
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+	OMAP_ST_WRITE(io_base_st, SSELCR, w | ST_SIDETONEEN);
+}
+
+static void omap_st_disable(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data;
+	void __iomem *io_base_mcbsp;
+	void __iomem *io_base_st;
+	unsigned int w;
+
+	io_base_mcbsp = mcbsp->io_base;
+	st_data = mcbsp->st_data;
+	io_base_st = st_data->io_base_st;
+
+	w = OMAP_ST_READ(io_base_st, SSELCR);
+	OMAP_ST_WRITE(io_base_st, SSELCR, w & ~(ST_SIDETONEEN));
+
+	w = OMAP_ST_READ(io_base_st, SYSCONFIG);
+	OMAP_ST_WRITE(io_base_st, SYSCONFIG, w | ST_AUTOIDLE);
+
+	w = OMAP_MCBSP_READ(io_base_mcbsp, SSELCR);
+	OMAP_MCBSP_WRITE(io_base_mcbsp, SSELCR, w & ~(SIDETONEEN));
+
+	w = cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	w |= (mcbsp->id - 1);
+	cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+}
+
+static void omap_st_enable_autoidle(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data;
+	void __iomem *io_base_st;
+	unsigned int w;
+
+	st_data = mcbsp->st_data;
+	io_base_st = st_data->io_base_st;
+
+	w = OMAP_ST_READ(io_base_st, SYSCONFIG);
+	OMAP_ST_WRITE(io_base_st, SYSCONFIG, w | ST_AUTOIDLE);
+}
+
+static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
+{
+	struct omap_mcbsp_st_data *st_data;
+	void __iomem *io_base;
+	u16 w, i;
+
+	st_data = mcbsp->st_data;
+	io_base = st_data->io_base_st;
+
+	w = OMAP_ST_READ(io_base, SYSCONFIG);
+	OMAP_ST_WRITE(io_base, SYSCONFIG, w & ~(ST_AUTOIDLE));
+
+	w = OMAP_ST_READ(io_base, SSELCR);
+
+	if (w & ST_COEFFWREN)
+		OMAP_ST_WRITE(io_base, SSELCR, w & ~(ST_COEFFWREN));
+
+	OMAP_ST_WRITE(io_base, SSELCR, w | ST_COEFFWREN);
+
+	for (i = 0; i < 128; i++)
+		OMAP_ST_WRITE(io_base, SFIRCR, fir[i]);
+
+	i = 0;
+
+	w = OMAP_ST_READ(io_base, SSELCR);
+	while (!(w & ST_COEFFWRDONE) && (++i < 1000))
+		w = OMAP_ST_READ(io_base, SSELCR);
+
+	OMAP_ST_WRITE(io_base, SSELCR, w & ~(ST_COEFFWREN));
+
+	if (i == 1000)
+		dev_err(mcbsp->dev, "McBSP FIR load error!\n");
+}
+
+static void omap_st_chgain(struct omap_mcbsp *mcbsp, s16 ch0gain, s16 ch1gain)
+{
+	struct omap_mcbsp_st_data *st_data;
+	void __iomem *io_base;
+	u16 w;
+
+	st_data = mcbsp->st_data;
+	io_base = st_data->io_base_st;
+
+	w = OMAP_ST_READ(io_base, SYSCONFIG);
+	OMAP_ST_WRITE(io_base, SYSCONFIG, w & ~(ST_AUTOIDLE));
+
+	w = OMAP_ST_READ(io_base, SSELCR);
+
+	OMAP_ST_WRITE(io_base, SGAINCR, ST_CH0GAIN(ch0gain) | \
+			ST_CH1GAIN(ch1gain));
+}
+
+static void omap_st_start(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcbsp->lock, flags);
+	if (st_data) {
+		omap_st_fir_write(mcbsp, mcbsp->st_data->taps);
+		omap_st_chgain(mcbsp,
+			       mcbsp->st_data->ch0gain,
+			       mcbsp->st_data->ch1gain);
+		if (st_data->enabled)
+			omap_st_enable(mcbsp);
+		else
+			omap_st_enable_autoidle(mcbsp);
+		st_data->running = 1;
+	}
+	spin_unlock_irqrestore(&mcbsp->lock, flags);
+}
+
+static void omap_st_stop(struct omap_mcbsp *mcbsp)
+{
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcbsp->lock, flags);
+	if (st_data && st_data->running) {
+		omap_st_disable(mcbsp);
+		st_data->running = 0;
+	}
+	spin_unlock_irqrestore(&mcbsp->lock, flags);
+}
+
 /*
  * omap_mcbsp_set_tx_threshold configures how to deal
  * with transmit threshold. the threshold value and handler can be
@@ -360,6 +522,8 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 #else
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp) {}
 static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp) {}
+static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
+static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
 #endif
 
 /*
@@ -516,6 +680,9 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	mcbsp = id_to_mcbsp_ptr(id);
 	io_base = mcbsp->io_base;
 
+	if (cpu_is_omap34xx())
+		omap_st_start(mcbsp);
+
 	mcbsp->rx_word_length = (OMAP_MCBSP_READ(io_base, RCR1) >> 5) & 0x7;
 	mcbsp->tx_word_length = (OMAP_MCBSP_READ(io_base, XCR1) >> 5) & 0x7;
 
@@ -609,6 +776,9 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 		w = OMAP_MCBSP_READ(io_base, SPCR2);
 		OMAP_MCBSP_WRITE(io_base, SPCR2, w & ~(1 << 6));
 	}
+
+	if (cpu_is_omap34xx())
+		omap_st_stop(mcbsp);
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
 
@@ -1190,6 +1360,147 @@ unlock:
 
 static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
 
+static ssize_t st_enable_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+
+	return sprintf(buf, "%d\n", st_data->enabled);
+}
+
+static ssize_t st_enable_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	unsigned long val;
+	int status;
+
+	status = strict_strtoul(buf, 0, &val);
+	if (status)
+		return status;
+
+	spin_lock_irq(&mcbsp->lock);
+	st_data->enabled = !!val;
+
+	if (st_data->running) {
+		if (st_data->enabled)
+			omap_st_enable(mcbsp);
+		else
+			omap_st_disable(mcbsp);
+	}
+	spin_unlock_irq(&mcbsp->lock);
+
+	return size;
+}
+
+static DEVICE_ATTR(st_enable, 0644, st_enable_show, st_enable_store);
+
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
+static ssize_t st_chgain_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+
+	if (strcmp("st_ch0gain", attr->attr.name) == 0)
+		return sprintf(buf, "%d\n", st_data->ch0gain);
+	else
+		return sprintf(buf, "%d\n", st_data->ch1gain);
+}
+
+static ssize_t st_chgain_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
+	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
+	long val;
+	int status;
+
+	status = strict_strtol(buf, 0, &val);
+	if (status)
+		return status;
+	if (val < -32768 || val > 32767)
+		return -EINVAL;
+
+	spin_lock_irq(&mcbsp->lock);
+	if (strcmp("st_ch0gain", attr->attr.name) == 0)
+		st_data->ch0gain = val;
+	else
+		st_data->ch1gain = val;
+
+	if (st_data->running)
+		omap_st_chgain(mcbsp,
+			       mcbsp->st_data->ch0gain,
+			       mcbsp->st_data->ch1gain);
+	spin_unlock_irq(&mcbsp->lock);
+
+	return size;
+}
+
+static DEVICE_ATTR(st_ch0gain, 0644, st_chgain_show, st_chgain_store);
+static DEVICE_ATTR(st_ch1gain, 0644, st_chgain_show, st_chgain_store);
+
 static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
@@ -1211,6 +1522,62 @@ static inline void __devexit omap_additional_remove(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &additional_attr_group);
 }
 
+static const struct attribute *sidetone_attrs[] = {
+	&dev_attr_st_enable.attr,
+	&dev_attr_st_taps.attr,
+	&dev_attr_st_ch0gain.attr,
+	&dev_attr_st_ch1gain.attr,
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
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 {
 	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
@@ -1224,6 +1591,12 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
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
@@ -1232,8 +1605,12 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 
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
1.6.4.183.g04423

