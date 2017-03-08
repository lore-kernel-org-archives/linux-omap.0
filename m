From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 7/7] PCI: dwc: dra7xx: Push request_irq call to the bottom
 of probe
Date: Wed, 8 Mar 2017 16:17:17 +0530
Message-ID: <1488970037-17740-8-git-send-email-kishon@ti.com>
References: <1488970037-17740-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488970037-17740-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com
Cc: Keerthy <j-keerthy@ti.com>, nsekhar@ti.com, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Currently devm_request_irq is being called before base, pci fields
of dra7xx_pcie structure are populated. It is called even before
pm_runtime_enable and pm_runtime_get_sync are called. This will
lead to exceptions if in case an interrupt is triggered before
the all of the above are done. Hence push the devm_request_irq
call to the end of the probe.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index c6fef0a..8c53233 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -410,13 +410,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
-			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
-	if (ret) {
-		dev_err(dev, "failed to request irq\n");
-		return ret;
-	}
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
 	base = devm_ioremap_nocache(dev, res->start, resource_size(res));
 	if (!base)
@@ -478,6 +471,13 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_gpio;
 
+	ret = devm_request_irq(dev, irq, dra7xx_pcie_irq_handler,
+			       IRQF_SHARED, "dra7xx-pcie-main", dra7xx);
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		goto err_gpio;
+	}
+
 	return 0;
 
 err_gpio:
-- 
1.7.9.5
