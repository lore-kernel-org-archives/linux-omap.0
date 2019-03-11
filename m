From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 02/42] drivers: gpio: amdpt: use devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 19:54:41 +0100
Message-ID: <1552330521-4276-2-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-amdpt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index 9b78dc8..1ffd7c2 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -78,7 +78,6 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	struct acpi_device *acpi_dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
 	struct pt_gpio_chip *pt_gpio;
-	struct resource *res_mem;
 	int ret = 0;
 
 	if (acpi_bus_get_device(handle, &acpi_dev)) {
@@ -90,12 +89,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	if (!pt_gpio)
 		return -ENOMEM;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_mem) {
-		dev_err(&pdev->dev, "Failed to get MMIO resource for PT GPIO.\n");
-		return -EINVAL;
-	}
-	pt_gpio->reg_base = devm_ioremap_resource(dev, res_mem);
+	pt_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pt_gpio->reg_base)) {
 		dev_err(&pdev->dev, "Failed to map MMIO resource for PT GPIO.\n");
 		return PTR_ERR(pt_gpio->reg_base);
-- 
1.9.1
