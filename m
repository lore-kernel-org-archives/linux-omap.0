From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 10/14] omap: mcbsp: Cleanup sidetone control initialization and make it generic
Date: Wed, 31 Aug 2011 18:22:57 +0300
Message-ID: <1314804181-17260-11-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:36922 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756630Ab1HaPlk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:41:40 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

Sidetone resource is already registered for a device so there is no need
for cpu_is_omap34xx() and McBSP port number tests in the driver. We can
cleanup and make the code generic by dropping remaining CONFIG_ARCH_OMAP3
conditional compilations and then using sidetone resource and st_data
variable for runtime tests.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |   12 ------
 arch/arm/plat-omap/mcbsp.c              |   67 ++++++++++---------------------
 2 files changed, 22 insertions(+), 57 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index e451a6e..9802055 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -353,9 +353,7 @@ struct omap_mcbsp {
 	spinlock_t lock;
 	struct omap_mcbsp_platform_data *pdata;
 	struct clk *fclk;
-#ifdef CONFIG_ARCH_OMAP3
 	struct omap_mcbsp_st_data *st_data;
-#endif
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
@@ -402,21 +400,11 @@ void omap2_mcbsp1_mux_fsr_src(u8 mux);
 int omap_mcbsp_dma_ch_params(unsigned int id, unsigned int stream);
 int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream);
 
-#ifdef CONFIG_ARCH_OMAP3
 /* Sidetone specific API */
 int omap_st_set_chgain(unsigned int id, int channel, s16 chgain);
 int omap_st_get_chgain(unsigned int id, int channel, s16 *chgain);
 int omap_st_enable(unsigned int id);
 int omap_st_disable(unsigned int id);
 int omap_st_is_enabled(unsigned int id);
-#else
-static inline int omap_st_set_chgain(unsigned int id, int channel,
-				     s16 chgain) { return 0; }
-static inline int omap_st_get_chgain(unsigned int id, int channel,
-				     s16 *chgain) { return 0; }
-static inline int omap_st_enable(unsigned int id) { return 0; }
-static inline int omap_st_disable(unsigned int id) { return 0; }
-static inline int omap_st_is_enabled(unsigned int id) {  return 0; }
-#endif
 
 #endif
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e96d747..f92227f 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -55,7 +55,6 @@ static int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 	}
 }
 
-#ifdef CONFIG_ARCH_OMAP3
 static void omap_mcbsp_st_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	__raw_writel(val, mcbsp->st_data->io_base_st + reg);
@@ -65,7 +64,6 @@ static int omap_mcbsp_st_read(struct omap_mcbsp *mcbsp, u16 reg)
 {
 	return __raw_readl(mcbsp->st_data->io_base_st + reg);
 }
-#endif
 
 #define MCBSP_READ(mcbsp, reg) \
 		omap_mcbsp_read(mcbsp, OMAP_MCBSP_REG_##reg, 0)
@@ -248,7 +246,6 @@ int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
 }
 EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 
-#ifdef CONFIG_ARCH_OMAP3
 static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
@@ -482,11 +479,6 @@ int omap_st_is_enabled(unsigned int id)
 }
 EXPORT_SYMBOL(omap_st_is_enabled);
 
-#else
-static inline void omap_st_start(struct omap_mcbsp *mcbsp) {}
-static inline void omap_st_stop(struct omap_mcbsp *mcbsp) {}
-#endif
-
 /*
  * omap_mcbsp_set_rx_threshold configures the transmit threshold in words.
  * The threshold parameter is 1 based, and it is converted (threshold - 1)
@@ -802,7 +794,7 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	if (cpu_is_omap34xx())
+	if (mcbsp->st_data)
 		omap_st_start(mcbsp);
 
 	/* Only enable SRG, if McBSP is master */
@@ -897,7 +889,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 		MCBSP_WRITE(mcbsp, SPCR2, w & ~(1 << 6));
 	}
 
-	if (cpu_is_omap34xx())
+	if (mcbsp->st_data)
 		omap_st_stop(mcbsp);
 }
 EXPORT_SYMBOL(omap_mcbsp_stop);
@@ -1030,7 +1022,6 @@ static const struct attribute_group additional_attr_group = {
 	.attrs = (struct attribute **)additional_attrs,
 };
 
-#ifdef CONFIG_ARCH_OMAP3
 static ssize_t st_taps_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -1098,10 +1089,9 @@ static const struct attribute_group sidetone_attr_group = {
 	.attrs = (struct attribute **)sidetone_attrs,
 };
 
-static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
+static int __devinit omap_st_add(struct omap_mcbsp *mcbsp,
+				 struct resource *res)
 {
-	struct platform_device *pdev;
-	struct resource *res;
 	struct omap_mcbsp_st_data *st_data;
 	int err;
 
@@ -1111,9 +1101,6 @@ static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
 		goto err1;
 	}
 
-	pdev = container_of(mcbsp->dev, struct platform_device, dev);
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sidetone");
 	st_data->io_base_st = ioremap(res->start, resource_size(res));
 	if (!st_data->io_base_st) {
 		err = -ENOMEM;
@@ -1140,32 +1127,10 @@ static void __devexit omap_st_remove(struct omap_mcbsp *mcbsp)
 {
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
 
-	if (st_data) {
-		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
-		iounmap(st_data->io_base_st);
-		kfree(st_data);
-	}
-}
-
-static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
-{
-	if (cpu_is_omap34xx())
-		if (mcbsp->id == 2 || mcbsp->id == 3)
-			if (omap_st_add(mcbsp))
-				dev_warn(mcbsp->dev,
-				 "Unable to create sidetone controls\n");
-}
-
-static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
-{
-	if (cpu_is_omap34xx())
-		if (mcbsp->id == 2 || mcbsp->id == 3)
-			omap_st_remove(mcbsp);
+	sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
+	iounmap(st_data->io_base_st);
+	kfree(st_data);
 }
-#else
-static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
-static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp) {}
-#endif /* CONFIG_ARCH_OMAP3 */
 
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
@@ -1291,11 +1256,22 @@ static int __devinit omap_mcbsp_probe(struct platform_device *pdev)
 		mcbsp->max_rx_thres = -EINVAL;
 	}
 
-	/* Initialize mcbsp properties for OMAP34XX if needed / applicable */
-	omap34xx_device_init(mcbsp);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sidetone");
+	if (res) {
+		ret = omap_st_add(mcbsp, res);
+		if (ret) {
+			dev_err(mcbsp->dev,
+				"Unable to create sidetone controls\n");
+			goto err_st;
+		}
+	}
 
 	return 0;
 
+err_st:
+	if (mcbsp->pdata->buffer_size)
+		sysfs_remove_group(&mcbsp->dev->kobj,
+				   &additional_attr_group);
 err_thres:
 	clk_put(mcbsp->fclk);
 err_res:
@@ -1321,7 +1297,8 @@ static int __devexit omap_mcbsp_remove(struct platform_device *pdev)
 			sysfs_remove_group(&mcbsp->dev->kobj,
 					   &additional_attr_group);
 
-		omap34xx_device_exit(mcbsp);
+		if (mcbsp->st_data)
+			omap_st_remove(mcbsp);
 
 		clk_put(mcbsp->fclk);
 
-- 
1.7.5.4

