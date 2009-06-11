From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [rfc/rft/patch 1/3] sti: cleanup to merge
Date: Thu, 11 Jun 2009 11:46:57 +0300
Message-ID: <1244710019-14564-2-git-send-email-felipe.balbi@nokia.com>
References: <1244710019-14564-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27887 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbZFKIuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 04:50:02 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n5B8o1FI024291
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 03:50:05 -0500
In-Reply-To: <1244710019-14564-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

preparing this driver to merge it with sti.c and make them
a bus driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/mach/sti.h |   39 +------
 drivers/misc/sti/sdti.c               |  196 +++++++++++++++++++++++----------
 2 files changed, 145 insertions(+), 90 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/sti.h b/arch/arm/plat-omap/include/mach/sti.h
index af43917..f4cbd8f 100644
--- a/arch/arm/plat-omap/include/mach/sti.h
+++ b/arch/arm/plat-omap/include/mach/sti.h
@@ -118,16 +118,11 @@ enum {
 #define to_channel_address(channel) \
 	(sti_channel_base + STI_PERCHANNEL_SIZE * (channel))
 
-#elif defined(CONFIG_ARCH_OMAP3)
-
-#define STI_PERCHANNEL_SIZE	0x1000
-#define to_channel_address(channel) \
-	(sti_channel_base + STI_PERCHANNEL_SIZE * (channel) + 0x800)
-
 #endif
 
+#define STI_TRACE_CONTROL_CHANNEL	253
+
 /* arch/arm/plat-omap/sti/sti.c */
-extern void __iomem *sti_base, *sti_channel_base;
 
 int sti_request_irq(unsigned int irq, void *handler, unsigned long arg);
 void sti_free_irq(unsigned int irq);
@@ -143,30 +138,10 @@ void sti_channel_write_trace(int len, int id, void *data, unsigned int channel);
 /* arch/arm/plat-omap/sti/sti-fifo.c */
 int sti_read_packet(unsigned char *buf, int maxsize);
 
-static inline unsigned long sti_readl(unsigned long reg)
-{
-	return __raw_readl(sti_base + reg);
-}
-
-static inline void sti_writel(unsigned long data, unsigned long reg)
-{
-	__raw_writel(data, sti_base + reg);
-}
-
-static inline void sti_channel_writeb(unsigned char data, unsigned int channel)
-{
-	__raw_writeb(data, to_channel_address(channel));
-}
-
-static inline void sti_channel_writel(unsigned long data, unsigned int channel)
-{
-	__raw_writel(data, to_channel_address(channel));
-}
-
-#define STI_TRACE_CONTROL_CHANNEL	253
+extern unsigned long sti_readl(unsigned long reg);
+extern void sti_writel(unsigned long data, unsigned long reg);
+extern void sti_channel_writeb(unsigned char data, unsigned int channel);
+extern void sti_channel_writel(unsigned long data, unsigned int channel);
+extern void sti_channel_flush(unsigned int channel);
 
-static inline void sti_channel_flush(unsigned int channel)
-{
-	sti_channel_writeb(channel, STI_TRACE_CONTROL_CHANNEL);
-}
 #endif /* __ASM_ARCH_OMAP_STI_H */
diff --git a/drivers/misc/sti/sdti.c b/drivers/misc/sti/sdti.c
index 40dec43..4f4fcef 100644
--- a/drivers/misc/sti/sdti.c
+++ b/drivers/misc/sti/sdti.c
@@ -34,10 +34,50 @@
 #define SDTI_SYSCONFIG_SOFTRESET	(1 << 1)
 #define SDTI_SYSCONFIG_AUTOIDLE		(1 << 0)
 
-static struct clk *sdti_fck, *sdti_ick;
-void __iomem *sti_base, *sti_channel_base;
-static DEFINE_SPINLOCK(sdti_lock);
-static int sdti_initialized;
+#define STI_PERCHANNEL_SIZE	0x1000
+
+struct sti {
+	/* device lock */
+	spinlock_t	lock;
+	struct device	*dev;
+	struct clk	*fck;
+	struct clk	*ick;
+
+	void __iomem	*base;
+	void __iomem	*channel_base;
+
+	unsigned	initialized:1;
+};
+
+static struct sti *the_sti;
+
+#define to_channel_address(channel) \
+	(the_sti->channel_base + STI_PERCHANNEL_SIZE * (channel) + 0x800)
+
+unsigned long sti_readl(unsigned long reg)
+{
+	return __raw_readl(the_sti->base + reg);
+}
+
+void sti_writel(unsigned long data, unsigned long reg)
+{
+	__raw_writel(data, the_sti->base + reg);
+}
+
+void sti_channel_writeb(unsigned char data, unsigned int channel)
+{
+	__raw_writeb(data, to_channel_address(channel));
+}
+
+void sti_channel_writel(unsigned long data, unsigned int channel)
+{
+	__raw_writel(data, to_channel_address(channel));
+}
+
+void sti_channel_flush(unsigned int channel)
+{
+	sti_channel_writeb(channel, STI_TRACE_CONTROL_CHANNEL);
+}
 
 void sti_channel_write_trace(int len, int id, void *data,
 				unsigned int channel)
@@ -45,9 +85,9 @@ void sti_channel_write_trace(int len, int id, void *data,
 	const u8 *tpntr = data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sdti_lock, flags);
+	spin_lock_irqsave(&the_sti->lock, flags);
 
-	if (unlikely(!sdti_initialized))
+	if (unlikely(!the_sti->initialized))
 		goto skip;
 
 	sti_channel_writeb(id, channel);
@@ -56,11 +96,11 @@ void sti_channel_write_trace(int len, int id, void *data,
 	sti_channel_flush(channel);
 
 skip:
-	spin_unlock_irqrestore(&sdti_lock, flags);
+	spin_unlock_irqrestore(&the_sti->lock, flags);
 }
 EXPORT_SYMBOL(sti_channel_write_trace);
 
-static void omap_sdti_reset(void)
+static void omap_sdti_reset(struct sti *sti)
 {
 	int i;
 
@@ -70,38 +110,38 @@ static void omap_sdti_reset(void)
 		if (sti_readl(SDTI_SYSSTATUS) & 1)
 			break;
 	if (i == 10000)
-		printk(KERN_WARNING "XTI: no real reset\n");
+		dev_warn(sti->dev, "no real reset\n");
 }
 
-static int __init omap_sdti_init(void)
+static int __init omap_sdti_init(struct sti *sti)
 {
 	char buf[64];
 	int i, ret = 0;
 
-	sdti_fck = clk_get(NULL, "pclk_fck");
-	if (IS_ERR(sdti_fck)) {
-		printk(KERN_ERR "Cannot get clk pclk_fck\n");
-		ret = PTR_ERR(sdti_fck);
+	sti->fck = clk_get(NULL, "pclk_fck");
+	if (IS_ERR(sti->fck)) {
+		dev_err(sti->dev, "Cannot get clk pclk_fck\n");
+		ret = PTR_ERR(sti->fck);
 		goto err0;
 	}
-	sdti_ick = clk_get(NULL, "pclkx2_fck");
-	if (IS_ERR(sdti_ick)) {
-		printk(KERN_ERR "Cannot get clk pclkx2_fck\n");
-		ret = PTR_ERR(sdti_ick);
+	sti->ick = clk_get(NULL, "pclkx2_fck");
+	if (IS_ERR(sti->ick)) {
+		dev_err(sti->dev, "Cannot get clk pclkx2_fck\n");
+		ret = PTR_ERR(sti->ick);
 		goto err1;
 	}
-	ret = clk_enable(sdti_fck);
+	ret = clk_enable(sti->fck);
 	if (ret) {
-		printk(KERN_ERR "Cannot enable sdti_fck\n");
+		dev_err(sti->dev, "Cannot enable fck\n");
 		goto err2;
 	}
-	ret = clk_enable(sdti_ick);
+	ret = clk_enable(sti->ick);
 	if (ret) {
-		printk(KERN_ERR "Cannot enable sdti_ick\n");
+		printk(KERN_ERR "Cannot enable ick\n");
 		goto err3;
 	}
 
-	omap_sdti_reset();
+	omap_sdti_reset(sti);
 	sti_writel(0xC5ACCE55, SDTI_LOCK_ACCESS);
 
 	/* Autoidle */
@@ -123,82 +163,122 @@ static int __init omap_sdti_init(void)
 	/* Enable SDTI */
 	sti_writel((1 << 31) | (i & 0x3FFFFFFF), SDTI_WINCTRL);
 
-	spin_lock_irq(&sdti_lock);
-	sdti_initialized = 1;
-	spin_unlock_irq(&sdti_lock);
+	spin_lock_irq(&sti->lock);
+	sti->initialized = 1;
+	spin_unlock_irq(&sti->lock);
 
 	i = sti_readl(SDTI_REVISION);
 	snprintf(buf, sizeof(buf), "OMAP SDTI support loaded (HW v%u.%u)\n",
 		(i >> 4) & 0x0f, i & 0x0f);
-	printk(KERN_INFO "%s", buf);
+	dev_dbg(sti->dev, "%s", buf);
 	sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
 
 	return ret;
 
 err3:
-	clk_disable(sdti_fck);
+	clk_disable(sti->fck);
 err2:
-	clk_put(sdti_ick);
+	clk_put(sti->ick);
 err1:
-	clk_put(sdti_fck);
+	clk_put(sti->fck);
 err0:
 	return ret;
 }
 
-static void omap_sdti_exit(void)
+static void omap_sdti_exit(struct sti *sti)
 {
 	sti_writel(0, SDTI_WINCTRL);
-	clk_disable(sdti_fck);
-	clk_disable(sdti_ick);
-	clk_put(sdti_fck);
-	clk_put(sdti_ick);
+	clk_disable(sti->fck);
+	clk_disable(sti->ick);
+	clk_put(sti->fck);
+	clk_put(sti->ick);
 }
 
 static int __devinit omap_sdti_probe(struct platform_device *pdev)
 {
-	struct resource *res, *cres;
-	unsigned int size;
+	struct resource *res;
+	struct sti *sti;
+	int ret;
+
+	sti = kzalloc(sizeof(*sti), GFP_KERNEL);
+	if (!sti) {
+		dev_dbg(&pdev->dev, "could not allocate memory\n");
+		ret = -ENOMEM;
+		goto fail1;
+	}
+
+	spin_lock_init(&sti->lock);
+	platform_set_drvdata(pdev, sti);
 
 	if (pdev->num_resources != 2) {
-		dev_err(&pdev->dev, "invalid number of resources: %d\n",
+		dev_dbg(&pdev->dev, "invalid number of resources: %d\n",
 			pdev->num_resources);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail2;
 	}
 
 	/* SDTI base */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid mem resource\n");
-		return -ENODEV;
+		dev_dbg(&pdev->dev, "invalid mem resource\n");
+		ret = -ENODEV;
+		goto fail2;
+	}
+
+	sti->base = ioremap(res->start, resource_size(res));
+	if (unlikely(!sti->base)) {
+		dev_dbg(&pdev->dev, "base ioremap failed\n");
+		ret = -ENODEV;
+		goto fail2;
 	}
 
 	/* Channel base */
-	cres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (unlikely(!cres)) {
-		dev_err(&pdev->dev, "invalid channel mem resource\n");
-		return -ENODEV;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (unlikely(!res)) {
+		dev_dbg(&pdev->dev, "invalid channel mem resource\n");
+		ret = -ENODEV;
+		goto fail3;
 	}
 
-	size = res->end - res->start;
-	sti_base = ioremap(res->start, size);
-	if (unlikely(!sti_base))
-		return -ENODEV;
+	sti->channel_base = ioremap(res->start, resource_size(res));
+	if (unlikely(!sti->channel_base)) {
+		dev_dbg(&pdev->dev, "invalid channel mem resource\n");
+		ret = -ENODEV;
+		goto fail3;
+	}
 
-	size = cres->end - cres->start;
-	sti_channel_base = ioremap(cres->start, size);
-	if (unlikely(!sti_channel_base)) {
-		iounmap(sti_base);
-		return -ENODEV;
+	ret = omap_sdti_init(sti);
+	if (ret) {
+		dev_dbg(&pdev->dev, "could not initialize sdti\n");
+		goto fail4;
 	}
 
-	return omap_sdti_init();
+	the_sti = sti;
+
+	return 0;
+
+fail4:
+	iounmap(sti->channel_base);
+
+fail3:
+	iounmap(sti->base);
+
+fail2:
+	kfree(sti);
+
+fail1:
+	return ret;
 }
 
 static int __devexit omap_sdti_remove(struct platform_device *pdev)
 {
-	iounmap(sti_channel_base);
-	iounmap(sti_base);
-	omap_sdti_exit();
+	struct sti *sti = platform_get_drvdata(pdev);
+
+	iounmap(sti->channel_base);
+	iounmap(sti->base);
+	omap_sdti_exit(sti);
+	kfree(sti);
+	the_sti = NULL;
 
 	return 0;
 }
-- 
1.6.3.1.244.gf9275

