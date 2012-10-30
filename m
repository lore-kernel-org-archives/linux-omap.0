From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] watchdog: omap_wdt: removed disabling in the probe
Date: Tue, 30 Oct 2012 10:37:30 +0530
Message-ID: <508F6092.9000709@ti.com>
References: <1351509087-6606-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54558 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab2J3FHl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 01:07:41 -0400
In-Reply-To: <1351509087-6606-1-git-send-email-lamiaposta71@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: linux-omap@vger.kernel.org, wim@iguana.be, linux-watchdog@vger.kernel.org

Hi Raffaele,

On Monday 29 October 2012 04:41 PM, Raffaele Recalcati wrote:
> In NOWAYOUT case it is better to have watchdog always enabled at boot,
> in order not to leave the system in undefined state in case of userspace
> failure.
>
> Signed-off-by: Raffaele Recalcati <lamiaposta71@gmail.com>
> ---
> Tested using http://arago-project.org/git/projects/linux-omap3.git
> v2.6.37_OMAPPSP_04.02.00.07 commit.
>
>   drivers/watchdog/omap_wdt.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 27ab8db..181b939 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -304,8 +304,16 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
>   	pm_runtime_enable(wdev->dev);
>   	pm_runtime_get_sync(wdev->dev);
>
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
>   	omap_wdt_disable(wdev);
>   	omap_wdt_adjust_timeout(timer_margin);
> +#else
> +	omap_wdt_adjust_timeout(timer_margin);
> +	omap_wdt_disable(wdev);
> +	omap_wdt_set_timeout(wdev);
> +	omap_wdt_enable(wdev);
> +	omap_wdt_ping(wdev);
IMHO this is not the correct procedure to start the watchdog.
The sequence to start watchdog is something similar in omap_wdt_open()
the steps are:
1) Increment omap_wdt_users
2) Set prescalar value
3) Enable prescalar value
4) Load timer counter value
5) Enable watchdog timer.

In your case you are missing first 3 steps.

After starting the watchdog, there should be some daemon
which pets the watchdog before timeout, if not it will reset the board.
This is also missing in your case.
( This daemon can be achieved by enabling delay interrupt and period)

And there is a pm_runtime_put_sync after you enable your watchdog.
Because of which you get the following warning
omap_hwmod: wd_timer2: _wait_target_disable failed

Below is the patch which might meet your aims.
Please comment on the patch.

Here I enabled delay interrupt and delay period
for petting watchdog before timeout.
watchdog is enabled for all the cases(not only for NOWAYOUT)



Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
  drivers/watchdog/omap_wdt.c | 82 
++++++++++++++++++++++++++++++++++++++++-----
  drivers/watchdog/omap_wdt.h |  4 +++
  2 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index f5db18db..38e36c1 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -45,6 +45,7 @@
  #include <linux/uaccess.h>
  #include <linux/slab.h>
  #include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
  #include <mach/hardware.h>
  #include <plat/cpu.h>
  #include <plat/prcm.h>
@@ -57,6 +58,10 @@ static unsigned timer_margin;
  module_param(timer_margin, uint, 0);
  MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");

+static int kernelpet = 1;
+module_param(kernelpet, int, 0);
+MODULE_PARM_DESC(kernelpet, "pet watchdog in kernel via irq");
+
  static unsigned int wdt_trgr_pattern = 0x1234;
  static DEFINE_SPINLOCK(wdt_lock);

@@ -66,6 +71,7 @@ struct omap_wdt_dev {
  	int             omap_wdt_users;
  	struct resource *mem;
  	struct miscdevice omap_wdt_miscdev;
+	int irq;
  };

  static void omap_wdt_ping(struct omap_wdt_dev *wdev)
@@ -125,6 +131,7 @@ static void omap_wdt_adjust_timeout(unsigned 
new_timeout)
  static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
  {
  	u32 pre_margin = GET_WLDR_VAL(timer_margin);
+	u32 delay_period = GET_WLDR_VAL(timer_margin / 2);
  	void __iomem *base = wdev->base;

  	/* just count up at 32 KHz */
@@ -134,14 +141,29 @@ static void omap_wdt_set_timeout(struct 
omap_wdt_dev *wdev)
  	__raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
  	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
  		cpu_relax();
+
+	/* Set delay interrupt to half the watchdog interval. */
+	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 1 << 5)
+		cpu_relax();
+	__raw_writel(delay_period, base + OMAP_WATCHDOG_WDLY);
  }

-/*
- *	Allow only one task to hold it open
- */
-static int omap_wdt_open(struct inode *inode, struct file *file)
+static irqreturn_t omap_wdt_interrupt(int irq, void *dev_id)
+{
+	struct omap_wdt_dev *wdev = dev_id;
+	void __iomem *base = wdev->base;
+	u32 i;
+
+	i = __raw_readl(base + OMAP_WATCHDOG_WIRQSTAT);
+	__raw_writel(i, base + OMAP_WATCHDOG_WIRQSTAT);
+
+	omap_wdt_ping(wdev);
+
+	return IRQ_HANDLED;
+}
+
+static int omap_wdt_setup(struct omap_wdt_dev *wdev)
  {
-	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
  	void __iomem *base = wdev->base;

  	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
@@ -157,12 +179,31 @@ static int omap_wdt_open(struct inode *inode, 
struct file *file)
  	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
  		cpu_relax();

-	file->private_data = (void *) wdev;
-
  	omap_wdt_set_timeout(wdev);
  	omap_wdt_ping(wdev); /* trigger loading of new timeout value */
+
+	/* Enable delay interrupt */
+	if (kernelpet && wdev->irq)
+		__raw_writel(0x2, base + OMAP_WATCHDOG_WIRQENSET);
+
  	omap_wdt_enable(wdev);

+	return 0;
+}
+/*
+ *	Allow only one task to hold it open
+ */
+static int omap_wdt_open(struct inode *inode, struct file *file)
+{
+	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
+	int ret;
+
+	ret = omap_wdt_setup(wdev);
+
+	if (ret)
+		return ret;
+
+	file->private_data = (void *)wdev;
  	return nonseekable_open(inode, file);
  }

@@ -176,6 +217,10 @@ static int omap_wdt_release(struct inode *inode, 
struct file *file)
  #ifndef CONFIG_WATCHDOG_NOWAYOUT
  	omap_wdt_disable(wdev);

+	/* Disable delay interrupt */
+	if (kernelpet && wdev->irq)
+		__raw_writel(0x2, base + OMAP_WATCHDOG_WIRQENCLR);
+
  	pm_runtime_put_sync(wdev->dev);
  #else
  	pr_crit("Unexpected close, not stopping!\n");
@@ -266,7 +311,7 @@ static const struct file_operations omap_wdt_fops = {

  static int __devinit omap_wdt_probe(struct platform_device *pdev)
  {
-	struct resource *res, *mem;
+	struct resource *res, *mem, *res_irq;
  	struct omap_wdt_dev *wdev;
  	int ret;

@@ -288,6 +333,8 @@ static int __devinit omap_wdt_probe(struct 
platform_device *pdev)
  		goto err_busy;
  	}

+	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+
  	wdev = kzalloc(sizeof(struct omap_wdt_dev), GFP_KERNEL);
  	if (!wdev) {
  		ret = -ENOMEM;
@@ -304,6 +351,16 @@ static int __devinit omap_wdt_probe(struct 
platform_device *pdev)
  		goto err_ioremap;
  	}

+	if (res_irq) {
+		ret = request_irq(res_irq->start, omap_wdt_interrupt, 0,
+				  dev_name(&pdev->dev), wdev);
+
+		if (ret)
+			goto err_irq;
+
+		wdev->irq = res_irq->start;
+	}
+
  	platform_set_drvdata(pdev, wdev);

  	pm_runtime_enable(wdev->dev);
@@ -329,11 +386,17 @@ static int __devinit omap_wdt_probe(struct 
platform_device *pdev)

  	omap_wdt_dev = pdev;

+	if (kernelpet && wdev->irq)
+		return  omap_wdt_setup(wdev);
+
  	return 0;

  err_misc:
  	pm_runtime_disable(wdev->dev);
  	platform_set_drvdata(pdev, NULL);
+	if (wdev->irq)
+		free_irq(wdev->irq, wdev);
+err_irq:
  	iounmap(wdev->base);

  err_ioremap:
@@ -372,6 +435,9 @@ static int __devexit omap_wdt_remove(struct 
platform_device *pdev)
  	release_mem_region(res->start, resource_size(res));
  	platform_set_drvdata(pdev, NULL);

+	if (wdev->irq)
+		free_irq(wdev->irq, wdev);
+
  	iounmap(wdev->base);

  	kfree(wdev);
diff --git a/drivers/watchdog/omap_wdt.h b/drivers/watchdog/omap_wdt.h
index 09b774c..c9980d3 100644
--- a/drivers/watchdog/omap_wdt.h
+++ b/drivers/watchdog/omap_wdt.h
@@ -38,7 +38,11 @@
  #define OMAP_WATCHDOG_LDR		(0x2c)
  #define OMAP_WATCHDOG_TGR		(0x30)
  #define OMAP_WATCHDOG_WPS		(0x34)
+#define OMAP_WATCHDOG_WDLY		(0x44)
  #define OMAP_WATCHDOG_SPR		(0x48)
+#define OMAP_WATCHDOG_WIRQSTAT		(0x58)
+#define OMAP_WATCHDOG_WIRQENSET		(0x5c)
+#define OMAP_WATCHDOG_WIRQENCLR		(0x60)

  /* Using the prescaler, the OMAP watchdog could go for many
   * months before firing.  These limits work without scaling,
--


Thanks
Lokesh

> +#endif
>
>   	wdev->omap_wdt_miscdev.parent = &pdev->dev;
>   	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
>

