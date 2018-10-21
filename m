From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/6] gpio: gpio-omap: simplify getting .driver_data
Date: Sun, 21 Oct 2018 21:59:59 +0200
Message-ID: <20181021200002.1472-5-wsa+renesas@sang-engineering.com>
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200002.1472-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/gpio/gpio-omap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 9887c3db6e16..6ed621a00561 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -984,8 +984,7 @@ omap4_gpio_disable_level_quirk(struct gpio_bank *bank)
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	struct gpio_bank	*bank = dev_get_drvdata(dev);
 	void __iomem		*mask_reg = bank->base +
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
@@ -999,8 +998,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
 
 static int omap_mpuio_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank	*bank = platform_get_drvdata(pdev);
+	struct gpio_bank	*bank = dev_get_drvdata(dev);
 	void __iomem		*mask_reg = bank->base +
 					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 	unsigned long		flags;
@@ -1688,8 +1686,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 
 static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	struct gpio_bank *bank = dev_get_drvdata(dev);
 	unsigned long flags;
 	int error = 0;
 
@@ -1709,8 +1706,7 @@ static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
 
 static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
+	struct gpio_bank *bank = dev_get_drvdata(dev);
 	unsigned long flags;
 	int error = 0;
 
-- 
2.19.0
