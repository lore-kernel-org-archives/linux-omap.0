From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 25/26] misc: pci_endpoint_test: Add support to test PCI EP in AM654x
Date: Mon, 25 Mar 2019 15:09:46 +0530
Message-ID: <20190325093947.32633-26-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

TI's AM654x PCIe EP has a restriction that BAR_0 is mapped to
application registers. "PCIe Inbound Address Translation" section in
AM65x Sitara Processors TRM (SPRUID7 – April 2018) describes BAR0 is
reserved. Configure pci_endpoint_test to use BAR_2 instead.
Also set alignment to 64K since "PCIe Subsystem Address Translation"
section in TRM indicates minimum ATU window size is 64K.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 29582fe57151..e015e8fa9bd3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -75,6 +75,11 @@
 #define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
+#define PCI_DEVICE_ID_TI_AM654			0xb00c
+
+#define is_am654_pci_dev(pdev)		\
+		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -588,6 +593,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	int ret = -EINVAL;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
+	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
 	switch (cmd) {
@@ -595,6 +601,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		bar = arg;
 		if (bar < 0 || bar > 5)
 			goto ret;
+		if (is_am654_pci_dev(pdev) && bar == BAR_0)
+			goto ret;
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
 	case PCITEST_LEGACY_IRQ:
@@ -785,11 +793,20 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static const struct pci_endpoint_test_data am654_data = {
+	.test_reg_bar = BAR_2,
+	.alignment = SZ_64K,
+	.irq_type = IRQ_TYPE_MSI,
+};
+
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
+	  .driver_data = (kernel_ulong_t)&am654_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.17.1
