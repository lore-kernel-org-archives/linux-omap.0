From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH] WATCHDOG: use base address from platform resources and
 make 2430 boot again
Date: Thu, 05 Apr 2007 07:43:49 -0500
Message-ID: <4614EF05.6050606@gmail.com>
References: <782515bb0704041855x4ff69d3bp19d386805eaecf16@mail.gmail.com>
	<5d5443650704050320t242adc8ak46c76cfbc69449ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000008030204080607070203"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5d5443650704050320t242adc8ak46c76cfbc69449ed@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000008030204080607070203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Trilok,
Thanks for your time in helping review the patch. :)

Trilok Soni stated on 4/5/2007 5:20 AM:
> Few comments:
>
> + *                             statics
>  */
>
> Changelog goes in the SCM metadata, not source files. Please avoid this.
Is this a new convention? No offence intended, but I like my signature
on the files I touch extensively.. since it is not denied by
coding_standards.txt, kinda pulling on leeway here.. :)
>
> -static void omap_wdt_ping(void)
> +static void omap_wdt_ping(struct omap_wdt_dev *wdev)
> {
> +    void __iomem    *base=wdev->base;
>
>
> space between *base and wdev->base is required for readability.
yup.. typie typie....
> +    wdev = (struct omap_wdt_dev *) platform_get_drvdata(omap_wdt_dev);
>
> You don't need casting here, I think.
cleaner.. since get_drvdata returns void *.. makes sense to explain what
form i am casting to-helps novice readers of code.. readability..
>
> +    file->private_data = (void *) wdev;
> +    wdev = (struct omap_wdt_dev *) file->private_data;
>
> No need of casting.
same reasoning..readability
>
> You should also set drvdata to NULL on wdt remove and error recovery
> path in wdt_probe.
>
> +    platform_set_drvdata(pdev, NULL);
>
good catch.. missed that one.

I have attached a follow up patch fixing the above mentioned issues..

Regards,
Nishanth Menon

--------------000008030204080607070203
Content-Type: text/plain;
 name="002-watchdog-fix-2430.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="002-watchdog-fix-2430.patch"

Watchdog fixes for 2430
* modfied watchdog driver to use base address provided in platform defn
* in the process cleaned up a bunch of statics used.
* added 2430 baseaddress defn
* Addressed review reported by Trilok Soni.

Signed-off-by: Nishanth Menon <menon.nishanth@gmail.com>
---
 arch/arm/plat-omap/devices.c     |    7 +
 drivers/char/watchdog/omap_wdt.c |  255 ++++++++++++++++++++++++---------------
 drivers/char/watchdog/omap_wdt.h |   28 +---
 3 files changed, 175 insertions(+), 115 deletions(-)
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index f4d04d8..56690ac 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -424,7 +424,14 @@ static inline void omap_init_uwire(void) {}
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
 #ifdef CONFIG_ARCH_OMAP24XX
+
+#ifdef CONFIG_ARCH_OMAP2430
+/* WDT2 */
+#define	OMAP_WDT_BASE		0x49016000
+#else
 #define	OMAP_WDT_BASE		0x48022000
+#endif
+
 #else
 #define	OMAP_WDT_BASE		0xfffeb000
 #endif
diff --git a/drivers/char/watchdog/omap_wdt.c b/drivers/char/watchdog/omap_wdt.c
index 84074a6..a608228 100644
--- a/drivers/char/watchdog/omap_wdt.c
+++ b/drivers/char/watchdog/omap_wdt.c
@@ -24,6 +24,11 @@
  *
  * Copyright (c) 2005 David Brownell
  *	Use the driver model and standard identifiers; handle bigger timeouts.
+ * ***
+ * History:
+ * --------
+ * 2007-04-04 Nishanth Menon - move to depend on platform resource and clean
+ *                             statics
  */
 
 #include <linux/module.h>
@@ -50,49 +55,61 @@
 
 #include "omap_wdt.h"
 
+static struct platform_device *omap_wdt_dev;
+
 static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
 MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 
-static int omap_wdt_users;
-static struct clk *armwdt_ck = NULL;
-static struct clk *mpu_wdt_ick = NULL;
-static struct clk *mpu_wdt_fck = NULL;
-
 static unsigned int wdt_trgr_pattern = 0x1234;
+struct omap_wdt_dev {
+	void __iomem    *base;          /* physical */
+	struct device   *dev;
+	int             omap_wdt_users;
+	struct clk      *armwdt_ck;
+	struct clk      *mpu_wdt_ick;
+	struct clk      *mpu_wdt_fck;
+	struct resource *mem;
+	struct miscdevice omap_wdt_miscdev;
+};
 
-static void omap_wdt_ping(void)
+static void omap_wdt_ping(struct omap_wdt_dev *wdev)
 {
+	void __iomem    *base = wdev->base;
 	/* wait for posted write to complete */
-	while ((omap_readl(OMAP_WATCHDOG_WPS)) & 0x08)
+	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
 		cpu_relax();
 	wdt_trgr_pattern = ~wdt_trgr_pattern;
-	omap_writel(wdt_trgr_pattern, (OMAP_WATCHDOG_TGR));
+	omap_writel(wdt_trgr_pattern, (base + OMAP_WATCHDOG_TGR));
 	/* wait for posted write to complete */
-	while ((omap_readl(OMAP_WATCHDOG_WPS)) & 0x08)
+	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
 		cpu_relax();
 	/* reloaded WCRR from WLDR */
 }
 
-static void omap_wdt_enable(void)
+static void omap_wdt_enable(struct omap_wdt_dev *wdev)
 {
+	void __iomem *base;
+	base = wdev->base;
 	/* Sequence to enable the watchdog */
-	omap_writel(0xBBBB, OMAP_WATCHDOG_SPR);
-	while ((omap_readl(OMAP_WATCHDOG_WPS)) & 0x10)
+	omap_writel(0xBBBB, base + OMAP_WATCHDOG_SPR);
+	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
 		cpu_relax();
-	omap_writel(0x4444, OMAP_WATCHDOG_SPR);
-	while ((omap_readl(OMAP_WATCHDOG_WPS)) & 0x10)
+	omap_writel(0x4444, base + OMAP_WATCHDOG_SPR);
+	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
 		cpu_relax();
 }
 
-static void omap_wdt_disable(void)
+static void omap_wdt_disable(struct omap_wdt_dev *wdev)
 {
+	void __iomem *base;
+	base = wdev->base;
 	/* sequence required to disable watchdog */
-	omap_writel(0xAAAA, OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
-	while (omap_readl(OMAP_WATCHDOG_WPS) & 0x10)
+	omap_writel(0xAAAA, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
+	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
 		cpu_relax();
-	omap_writel(0x5555, OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
-	while (omap_readl(OMAP_WATCHDOG_WPS) & 0x10)
+	omap_writel(0x5555, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
+	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
 		cpu_relax();
 }
 
@@ -105,15 +122,17 @@ static void omap_wdt_adjust_timeout(unsigned new_timeout)
 	timer_margin = new_timeout;
 }
 
-static void omap_wdt_set_timeout(void)
+static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
 {
 	u32 pre_margin = GET_WLDR_VAL(timer_margin);
+	void __iomem *base;
+	base = wdev->base;
 
 	/* just count up at 32 KHz */
-	while (omap_readl(OMAP_WATCHDOG_WPS) & 0x04)
+	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
-	omap_writel(pre_margin, OMAP_WATCHDOG_LDR);
-	while (omap_readl(OMAP_WATCHDOG_WPS) & 0x04)
+	omap_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
+	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
 }
 
@@ -123,55 +142,65 @@ static void omap_wdt_set_timeout(void)
 
 static int omap_wdt_open(struct inode *inode, struct file *file)
 {
-	if (test_and_set_bit(1, (unsigned long *)&omap_wdt_users))
+	struct omap_wdt_dev *wdev;
+	void __iomem *base;
+	wdev = (struct omap_wdt_dev *) platform_get_drvdata(omap_wdt_dev);
+	base = wdev->base;
+	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
 	if (cpu_is_omap16xx())
-		clk_enable(armwdt_ck);	/* Enable the clock */
+		clk_enable(wdev->armwdt_ck);	/* Enable the clock */
 
 	if (cpu_is_omap24xx()) {
-		clk_enable(mpu_wdt_ick);    /* Enable the interface clock */
-		clk_enable(mpu_wdt_fck);    /* Enable the functional clock */
+		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
+		clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
 	}
 
 	/* initialize prescaler */
-	while (omap_readl(OMAP_WATCHDOG_WPS) & 0x01)
+	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
-	omap_writel((1 << 5) | (PTV << 2), OMAP_WATCHDOG_CNTRL);
-	while (omap_readl(OMAP_WATCHDOG_WPS) & 0x01)
+	omap_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
+	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
 
-	omap_wdt_set_timeout();
-	omap_wdt_enable();
+	file->private_data = (void *) wdev;
+
+	omap_wdt_set_timeout(wdev);
+	omap_wdt_enable(wdev);
+
 	return 0;
 }
 
 static int omap_wdt_release(struct inode *inode, struct file *file)
 {
+	struct omap_wdt_dev *wdev;
+	wdev = (struct omap_wdt_dev *) file->private_data;
 	/*
 	 *      Shut off the timer unless NOWAYOUT is defined.
 	 */
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
-	omap_wdt_disable();
+
+	omap_wdt_disable(wdev);
 
 	if (cpu_is_omap16xx()) {
-		clk_disable(armwdt_ck);	/* Disable the clock */
-		clk_put(armwdt_ck);
-		armwdt_ck = NULL;
+		clk_disable(wdev->armwdt_ck);	/* Disable the clock */
+		clk_put(wdev->armwdt_ck);
+		wdev->armwdt_ck = NULL;
 	}
 
 	if (cpu_is_omap24xx()) {
-		clk_disable(mpu_wdt_ick);	/* Disable the clock */
-		clk_disable(mpu_wdt_fck);	/* Disable the clock */
-		clk_put(mpu_wdt_ick);
-		clk_put(mpu_wdt_fck);
-		mpu_wdt_ick = NULL;
-		mpu_wdt_fck = NULL;
+		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
+		clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
+		clk_put(wdev->mpu_wdt_ick);
+		clk_put(wdev->mpu_wdt_fck);
+		wdev->mpu_wdt_ick = NULL;
+		wdev->mpu_wdt_fck = NULL;
 	}
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
-	omap_wdt_users = 0;
+	wdev->omap_wdt_users = 0;
 	return 0;
 }
 
@@ -179,9 +208,11 @@ static ssize_t
 omap_wdt_write(struct file *file, const char __user *data,
 		size_t len, loff_t *ppos)
 {
+	struct omap_wdt_dev *wdev;
+	wdev = (struct omap_wdt_dev *) file->private_data;
 	/* Refresh LOAD_TIME. */
 	if (len)
-		omap_wdt_ping();
+		omap_wdt_ping(wdev);
 	return len;
 }
 
@@ -189,12 +220,14 @@ static int
 omap_wdt_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
+	struct omap_wdt_dev *wdev;
 	int new_margin;
 	static struct watchdog_info ident = {
 		.identity = "OMAP Watchdog",
 		.options = WDIOF_SETTIMEOUT,
 		.firmware_version = 0,
 	};
+	wdev = (struct omap_wdt_dev *) file->private_data;
 
 	switch (cmd) {
 	default:
@@ -212,22 +245,23 @@ omap_wdt_ioctl(struct inode *inode, struct file *file,
 			return put_user(omap_prcm_get_reset_sources(),
 					(int __user *)arg);
 	case WDIOC_KEEPALIVE:
-		omap_wdt_ping();
+		omap_wdt_ping(wdev);
 		return 0;
 	case WDIOC_SETTIMEOUT:
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 		omap_wdt_adjust_timeout(new_margin);
 
-		omap_wdt_disable();
-		omap_wdt_set_timeout();
-		omap_wdt_enable();
+		omap_wdt_disable(wdev);
+		omap_wdt_set_timeout(wdev);
+		omap_wdt_enable(wdev);
 
-		omap_wdt_ping();
+		omap_wdt_ping(wdev);
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timer_margin, (int __user *)arg);
 	}
+	return 0;
 }
 
 static const struct file_operations omap_wdt_fops = {
@@ -238,96 +272,122 @@ static const struct file_operations omap_wdt_fops = {
 	.release = omap_wdt_release,
 };
 
-static struct miscdevice omap_wdt_miscdev = {
-	.minor = WATCHDOG_MINOR,
-	.name = "watchdog",
-	.fops = &omap_wdt_fops
-};
 
 static int __init omap_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res, *mem;
 	int ret;
+	struct omap_wdt_dev *wdev;
 
 	/* reserve static register mappings */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENOENT;
 
+	if (omap_wdt_dev)
+		return -EBUSY;
+
 	mem = request_mem_region(res->start, res->end - res->start + 1,
 				 pdev->name);
 	if (mem == NULL)
 		return -EBUSY;
 
-	platform_set_drvdata(pdev, mem);
-
-	omap_wdt_users = 0;
+	wdev = kzalloc(sizeof(struct omap_wdt_dev), GFP_KERNEL);
+	if (!wdev) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	wdev->omap_wdt_users = 0;
+	wdev->mem = mem;
 
 	if (cpu_is_omap16xx()) {
-		armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
-		if (IS_ERR(armwdt_ck)) {
-			ret = PTR_ERR(armwdt_ck);
-			armwdt_ck = NULL;
+		wdev->armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
+		if (IS_ERR(wdev->armwdt_ck)) {
+			ret = PTR_ERR(wdev->armwdt_ck);
+			wdev->armwdt_ck = NULL;
 			goto fail;
 		}
 	}
 
 	if (cpu_is_omap24xx()) {
-		mpu_wdt_ick = clk_get(&pdev->dev, "mpu_wdt_ick");
-		if (IS_ERR(mpu_wdt_ick)) {
-			ret = PTR_ERR(mpu_wdt_ick);
-			mpu_wdt_ick = NULL;
+		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "mpu_wdt_ick");
+		if (IS_ERR(wdev->mpu_wdt_ick)) {
+			ret = PTR_ERR(wdev->mpu_wdt_ick);
+			wdev->mpu_wdt_ick = NULL;
 			goto fail;
 		}
-		mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
-		if (IS_ERR(mpu_wdt_fck)) {
-			ret = PTR_ERR(mpu_wdt_fck);
-			mpu_wdt_fck = NULL;
+		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
+		if (IS_ERR(wdev->mpu_wdt_fck)) {
+			ret = PTR_ERR(wdev->mpu_wdt_fck);
+			wdev->mpu_wdt_fck = NULL;
 			goto fail;
 		}
 	}
+	wdev->base = (void __iomem *) (mem->start);
+	platform_set_drvdata(pdev, wdev);
 
-	omap_wdt_disable();
+	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
 
-	omap_wdt_miscdev.parent = &pdev->dev;
-	ret = misc_register(&omap_wdt_miscdev);
+	wdev->omap_wdt_miscdev.parent = &pdev->dev;
+	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
+	wdev->omap_wdt_miscdev.name = "watchdog";
+	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
+
+	ret = misc_register(&(wdev->omap_wdt_miscdev));
 	if (ret)
 		goto fail;
 
-	pr_info("OMAP Watchdog Timer: initial timeout %d sec\n", timer_margin);
+	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
+		omap_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
+		timer_margin);
 
 	/* autogate OCP interface clock */
-	omap_writel(0x01, OMAP_WATCHDOG_SYS_CONFIG);
+	omap_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
+
+	omap_wdt_dev = pdev;
+
 	return 0;
 
 fail:
-	if (armwdt_ck)
-		clk_put(armwdt_ck);
-	if (mpu_wdt_ick)
-		clk_put(mpu_wdt_ick);
-	if (mpu_wdt_fck)
-		clk_put(mpu_wdt_fck);
-	release_resource(mem);
+	if (wdev) {
+		platform_set_drvdata(pdev, NULL);
+		if (wdev->armwdt_ck)
+			clk_put(wdev->armwdt_ck);
+		if (wdev->mpu_wdt_ick)
+			clk_put(wdev->mpu_wdt_ick);
+		if (wdev->mpu_wdt_fck)
+			clk_put(wdev->mpu_wdt_fck);
+		kfree(wdev);
+	}
+	if (mem) {
+		release_resource(mem);
+	}
 	return ret;
 }
 
 static void omap_wdt_shutdown(struct platform_device *pdev)
 {
-	omap_wdt_disable();
+	struct omap_wdt_dev *wdev;
+	wdev = (struct omap_wdt_dev *) platform_get_drvdata(pdev);
+	omap_wdt_disable(wdev);
 }
 
 static int omap_wdt_remove(struct platform_device *pdev)
 {
-	struct resource *mem = platform_get_drvdata(pdev);
-	misc_deregister(&omap_wdt_miscdev);
-	release_resource(mem);
-	if (armwdt_ck)
-		clk_put(armwdt_ck);
-	if (mpu_wdt_ick)
-		clk_put(mpu_wdt_ick);
-	if (mpu_wdt_fck)
-		clk_put(mpu_wdt_fck);
+	struct omap_wdt_dev *wdev;
+	wdev = (struct omap_wdt_dev *) platform_get_drvdata(pdev);
+
+	misc_deregister(&(wdev->omap_wdt_miscdev));
+	release_resource(wdev->mem);
+	if (wdev->armwdt_ck)
+		clk_put(wdev->armwdt_ck);
+	if (wdev->mpu_wdt_ick)
+		clk_put(wdev->mpu_wdt_ick);
+	if (wdev->mpu_wdt_fck)
+		clk_put(wdev->mpu_wdt_fck);
+	kfree(wdev);
+	omap_wdt_dev = NULL;
 	return 0;
 }
 
@@ -341,16 +401,20 @@ static int omap_wdt_remove(struct platform_device *pdev)
 
 static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	if (omap_wdt_users)
-		omap_wdt_disable();
+	struct omap_wdt_dev *wdev;
+	wdev = (struct omap_wdt_dev *) platform_get_drvdata(pdev);
+	if (wdev->omap_wdt_users)
+		omap_wdt_disable(wdev);
 	return 0;
 }
 
 static int omap_wdt_resume(struct platform_device *pdev)
 {
-	if (omap_wdt_users) {
-		omap_wdt_enable();
-		omap_wdt_ping();
+	struct omap_wdt_dev *wdev;
+	wdev = (struct omap_wdt_dev *) platform_get_drvdata(pdev);
+	if (wdev->omap_wdt_users) {
+		omap_wdt_enable(wdev);
+		omap_wdt_ping(wdev);
 	}
 	return 0;
 }
diff --git a/drivers/char/watchdog/omap_wdt.h b/drivers/char/watchdog/omap_wdt.h
index 52a532a..511135d 100644
--- a/drivers/char/watchdog/omap_wdt.h
+++ b/drivers/char/watchdog/omap_wdt.h
@@ -30,25 +30,15 @@
 #ifndef _OMAP_WATCHDOG_H
 #define _OMAP_WATCHDOG_H
 
-#define OMAP1610_WATCHDOG_BASE		0xfffeb000
-#define OMAP2420_WATCHDOG_BASE		0x48022000	/*WDT Timer 2 */
-
-#ifdef CONFIG_ARCH_OMAP24XX
-#define OMAP_WATCHDOG_BASE 		OMAP2420_WATCHDOG_BASE
-#else
-#define OMAP_WATCHDOG_BASE 		OMAP1610_WATCHDOG_BASE
-#define RM_RSTST_WKUP			0
-#endif
-
-#define OMAP_WATCHDOG_REV		(OMAP_WATCHDOG_BASE + 0x00)
-#define OMAP_WATCHDOG_SYS_CONFIG	(OMAP_WATCHDOG_BASE + 0x10)
-#define OMAP_WATCHDOG_STATUS		(OMAP_WATCHDOG_BASE + 0x14)
-#define OMAP_WATCHDOG_CNTRL		(OMAP_WATCHDOG_BASE + 0x24)
-#define OMAP_WATCHDOG_CRR		(OMAP_WATCHDOG_BASE + 0x28)
-#define OMAP_WATCHDOG_LDR		(OMAP_WATCHDOG_BASE + 0x2c)
-#define OMAP_WATCHDOG_TGR		(OMAP_WATCHDOG_BASE + 0x30)
-#define OMAP_WATCHDOG_WPS		(OMAP_WATCHDOG_BASE + 0x34)
-#define OMAP_WATCHDOG_SPR		(OMAP_WATCHDOG_BASE + 0x48)
+#define OMAP_WATCHDOG_REV			(0x00)
+#define OMAP_WATCHDOG_SYS_CONFIG	(0x10)
+#define OMAP_WATCHDOG_STATUS		(0x14)
+#define OMAP_WATCHDOG_CNTRL			(0x24)
+#define OMAP_WATCHDOG_CRR			(0x28)
+#define OMAP_WATCHDOG_LDR			(0x2c)
+#define OMAP_WATCHDOG_TGR			(0x30)
+#define OMAP_WATCHDOG_WPS			(0x34)
+#define OMAP_WATCHDOG_SPR			(0x48)
 
 /* Using the prescaler, the OMAP watchdog could go for many
  * months before firing.  These limits work without scaling,

--------------000008030204080607070203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000008030204080607070203--
