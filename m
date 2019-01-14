From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 10/15] PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is 64Bit
Date: Mon, 14 Jan 2019 16:45:08 +0530
Message-ID: <20190114111513.21618-11-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

It's useless to allocate memory for next BAR if the current BAR is a
64Bit BAR. Stop allocating memory for the next BAR, if the current
BARs flag indicates this is a 64Bit BAR.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 44cc31343a80..ade296180383 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -429,6 +429,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct device *dev = &epf->dev;
+	struct pci_epf_bar *epf_bar;
 	void *base;
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
@@ -442,6 +443,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	epf_test->reg[test_reg_bar] = base;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		epf_bar = &epf->bar[bar];
 		if (bar == test_reg_bar)
 			continue;
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
@@ -449,6 +451,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
+		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			bar++;
 	}
 
 	return 0;
-- 
2.17.1
