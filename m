From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/13] misc: pci_endpoint_test: Add J721E in pci_device_id table
Date: Mon, 9 Dec 2019 14:51:46 +0530
Message-ID: <20191209092147.22901-13-kishon@ti.com>
References: <20191209092147.22901-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209092147.22901-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Murray <andrew.murray@arm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Add J721E in pci_device_id table so that pci-epf-test can be used
for testing PCIe EP in J721E.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a5e317073d95..215f9b8432a3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -64,6 +64,7 @@
 #define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
+#define PCI_DEVICE_ID_TI_J721E			0xb00d
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 
 #define is_am654_pci_dev(pdev)		\
@@ -789,6 +790,11 @@ static const struct pci_endpoint_test_data am654_data = {
 	.irq_type = IRQ_TYPE_MSI,
 };
 
+static const struct pci_endpoint_test_data j721e_data = {
+	.alignment = 256,
+	.irq_type = IRQ_TYPE_MSI,
+};
+
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
@@ -797,6 +803,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
+	  .driver_data = (kernel_ulong_t)&j721e_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.17.1
