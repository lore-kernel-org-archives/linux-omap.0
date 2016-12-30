From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/3] PCI: dra7xx: simplify the probe code
Date: Fri, 30 Dec 2016 15:26:12 +0530
Message-ID: <1483091774-8332-2-git-send-email-kishon@ti.com>
References: <1483091774-8332-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483091774-8332-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Use the new devm_gpiod_get_optional() to
simplify the probe code.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/controller/pci-dra7xx.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pci-dra7xx.c b/drivers/pci/controller/pci-dra7xx.c
index 9595fad..f6d0c63 100644
--- a/drivers/pci/controller/pci-dra7xx.c
+++ b/drivers/pci/controller/pci-dra7xx.c
@@ -320,9 +320,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	char name[10];
-	int gpio_sel;
-	enum of_gpio_flags flags;
-	unsigned long gpio_flags;
+	struct gpio_desc *reset;
 
 	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
 	if (!dra7xx)
@@ -388,19 +386,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
-	if (gpio_is_valid(gpio_sel)) {
-		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
-				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
-		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
-					    "pcie_reset");
-		if (ret) {
-			dev_err(dev, "gpio%d request failed, ret %d\n",
-				gpio_sel, ret);
-			goto err_gpio;
-		}
-	} else if (gpio_sel == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
+	reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
 		goto err_gpio;
 	}
 
-- 
1.7.9.5
