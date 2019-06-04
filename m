From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 11/30] PCI: cadence: Add support to drive PERST# line using GPIO
Date: Tue, 4 Jun 2019 18:44:57 +0530
Message-ID: <20190604131516.13596-12-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

In platforms like TI's J721E EVM, the PERST# line is connected to a
GPIO line and PERST# should be driven high to indicate the clocks are
stable (As per Figure 2-10: Power Up of the PCIe CEM spec 3.0).

Add support to make GPIO drive PERST# line.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-host.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 4ad8f2ece6e2..8b3b9827a8d6 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -3,6 +3,8 @@
 // Cadence PCIe host controller driver.
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -287,6 +289,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct list_head resources;
 	struct cdns_pcie_rc *rc;
+	struct gpio_desc *gpiod;
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
@@ -349,13 +352,36 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 		dev_err(dev, "missing \"mem\"\n");
 		return -EINVAL;
 	}
+
 	pcie->mem_res = res;
 
+	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get reset GPIO\n");
+		return ret;
+	}
+
 	ret = cdns_pcie_init_phy(dev, pcie);
 	if (ret) {
 		dev_err(dev, "failed to init phy\n");
 		return ret;
 	}
+
+	/*
+	 * "Power Sequencing and Reset Signal Timings" table in
+	 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
+	 * indicates PERST# should be deasserted after minimum of 100us
+	 * once REFCLK is stable. The REFCLK to the connector in RC
+	 * mode is selected while enabling the PHY. So deassert PERST#
+	 * after 100 us.
+	 */
+	if (gpiod) {
+		usleep_range(100, 200);
+		gpiod_set_value_cansleep(gpiod, 1);
+	}
+
 	platform_set_drvdata(pdev, pcie);
 
 	pm_runtime_enable(dev);
-- 
2.17.1
