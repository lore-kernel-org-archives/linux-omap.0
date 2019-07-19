From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 105/141] PCI: dwc: pci-dra7xx: Fix compilation when !CONFIG_GPIOLIB
Date: Fri, 19 Jul 2019 00:02:10 -0400
Message-ID: <20190719040246.15945-105-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 381ed79c8655a40268ee7391f716edd90c5c3a97 ]

If CONFIG_GPIOLIB is not selected the compilation results in the
following build errors:

drivers/pci/controller/dwc/pci-dra7xx.c:
 In function dra7xx_pcie_probe:
drivers/pci/controller/dwc/pci-dra7xx.c:777:10:
 error: implicit declaration of function devm_gpiod_get_optional;
 did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]

  reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);

drivers/pci/controller/dwc/pci-dra7xx.c:778:45: error: ‘GPIOD_OUT_HIGH’
undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
  reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
                                             ^~~~~~~~~~~~~~
                                             GPIOF_INIT_HIGH

Fix them by including the appropriate header file.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index ae84a69ae63a..4ef0a592505c 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
-- 
2.20.1
