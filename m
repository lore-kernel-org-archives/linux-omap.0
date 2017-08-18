From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 11/18] PCI: dwc: dra7xx: Reset all BARs during initialization
Date: Fri, 18 Aug 2017 20:28:03 +0530
Message-ID: <20170818145810.17649-12-kishon@ti.com>
References: <20170818145810.17649-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818145810.17649-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dra7xx has all base address registers (BAR) enabled by default. Reset all
BARs during initialization and so that BARs are enabled only if they are
actually used.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index f2fc5f47064e..ee61f833b62c 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -335,10 +335,23 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
+{
+	u32 reg;
+
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	dw_pcie_writel_dbi2(pci, reg, 0x0);
+	dw_pcie_writel_dbi(pci, reg, 0x0);
+}
+
 static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
+	enum pci_barno bar;
+
+	for (bar = BAR_0; bar <= BAR_5; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
 
 	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
 }
-- 
2.11.0
