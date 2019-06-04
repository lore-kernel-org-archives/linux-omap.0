From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 30/30] misc: pci_endpoint_test: Enable legacy interrupt
Date: Tue, 4 Jun 2019 18:45:16 +0530
Message-ID: <20190604131516.13596-31-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

PCI core does not enable legacy interrupt if it finds MSI or MSIX interrupt.
Explicitly enable legacy interrupt here in order to perform legacy
interrupt tests.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2a6cd9e65e67..e12a3845ad2e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -697,6 +697,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	pci_set_master(pdev);
+	pci_intx(pdev, true);
 
 	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
 		goto err_disable_irq;
-- 
2.17.1
