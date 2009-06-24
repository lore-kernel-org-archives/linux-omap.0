From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/07] arm: rework omap
	suspend_late()/resume_early()
Date: Wed, 24 Jun 2009 18:23:15 +0900
Message-ID: <20090624092315.14276.84763.sendpatchset@rx1.opensource.se>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, ben-linux@fluff.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, akpm@linux-foundation.org, felipe.balbi@nokia.com
List-Id: linux-omap@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks platform driver power management code
for omap drivers using late/early legacy callbacks.

The callbacks are converted for CONFIG_SUSPEND like this:
  suspend_late() -> suspend_noirq()
  resume_early() -> resume_noirq()

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested but compiles just fine.

 arch/arm/plat-omap/debug-leds.c |   11 +++++++----
 arch/arm/plat-omap/gpio.c       |   14 ++++++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

--- 0001/arch/arm/plat-omap/debug-leds.c
+++ work/arch/arm/plat-omap/debug-leds.c	2009-06-01 15:50:21.000000000 +0900
@@ -281,24 +281,27 @@ static int /* __init */ fpga_probe(struc
 	return 0;
 }
 
-static int fpga_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+static int fpga_suspend_noirq(struct device *dev)
 {
 	__raw_writew(~0, &fpga->leds);
 	return 0;
 }
 
-static int fpga_resume_early(struct platform_device *pdev)
+static int fpga_resume_noirq(struct device *dev)
 {
 	__raw_writew(~hw_led_state, &fpga->leds);
 	return 0;
 }
 
+static struct dev_pm_ops fpga_dev_pm_ops = {
+	.suspend_noirq = fpga_suspend_noirq,
+	.resume_noirq = fpga_resume_noirq,
+};
 
 static struct platform_driver led_driver = {
 	.driver.name	= "omap_dbg_led",
+	.driver.pm	= &fpga_dev_pm_ops,
 	.probe		= fpga_probe,
-	.suspend_late	= fpga_suspend_late,
-	.resume_early	= fpga_resume_early,
 };
 
 static int __init fpga_init(void)
--- 0001/arch/arm/plat-omap/gpio.c
+++ work/arch/arm/plat-omap/gpio.c	2009-06-01 16:30:56.000000000 +0900
@@ -1264,8 +1264,9 @@ static struct irq_chip mpuio_irq_chip = 
 
 #include <linux/platform_device.h>
 
-static int omap_mpuio_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+static int omap_mpuio_suspend_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank	*bank = platform_get_drvdata(pdev);
 	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
 	unsigned long		flags;
@@ -1278,8 +1279,9 @@ static int omap_mpuio_suspend_late(struc
 	return 0;
 }
 
-static int omap_mpuio_resume_early(struct platform_device *pdev)
+static int omap_mpuio_resume_noirq(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_bank	*bank = platform_get_drvdata(pdev);
 	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
 	unsigned long		flags;
@@ -1291,14 +1293,18 @@ static int omap_mpuio_resume_early(struc
 	return 0;
 }
 
+static struct dev_pm_ops omap_mpuio_dev_pm_ops = {
+	.suspend_noirq = omap_mpuio_suspend_noirq,
+	.resume_noirq = omap_mpuio_resume_noirq,
+};
+
 /* use platform_driver for this, now that there's no longer any
  * point to sys_device (other than not disturbing old code).
  */
 static struct platform_driver omap_mpuio_driver = {
-	.suspend_late	= omap_mpuio_suspend_late,
-	.resume_early	= omap_mpuio_resume_early,
 	.driver		= {
 		.name	= "mpuio",
+		.pm	= &omap_mpuio_dev_pm_ops,
 	},
 };
 
