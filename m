From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 28/30] misc: pci_endpoint_test: Avoid using module parameter to determine irqtype
Date: Tue, 4 Jun 2019 18:45:14 +0530
Message-ID: <20190604131516.13596-29-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

commit e03327122e2c8e6ae4565ef ("pci_endpoint_test: Add 2 ioctl
commands") uses module parameter in pci_endpoint_test_set_irq()
'irqtype' to check if irq vectors of a particular type is already
allocated. However with multi-function devices, irqtype will not
correctly reflect the irq type of the PCI device. Fix it here by
adding 'irqtype' for each PCI device to shows the irq type of that
particular PCI device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 98a60f4d45a1..632c76e33e4e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -110,6 +110,7 @@ struct pci_endpoint_test {
 	struct completion irq_raised;
 	int		last_irq;
 	int		num_irqs;
+	int		irq_type;
 	/* mutex to protect the ioctls */
 	struct mutex	mutex;
 	struct miscdevice miscdev;
@@ -169,6 +170,7 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
 	struct pci_dev *pdev = test->pdev;
 
 	pci_free_irq_vectors(pdev);
+	test->irq_type = IRQ_TYPE_UNDEFINED;
 }
 
 static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
@@ -203,6 +205,8 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 		irq = 0;
 		res = false;
 	}
+
+	test->irq_type = type;
 	test->num_irqs = irq;
 
 	return res;
@@ -342,6 +346,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_dst_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 src_crc32;
 	u32 dst_crc32;
 
@@ -438,6 +443,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 crc32;
 
 	if (size > SIZE_MAX - alignment)
@@ -506,6 +512,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 crc32;
 
 	if (size > SIZE_MAX - alignment)
@@ -567,7 +574,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return false;
 	}
 
-	if (irq_type == req_irq_type)
+	if (test->irq_type == req_irq_type)
 		return true;
 
 	pci_endpoint_test_release_irq(test);
@@ -579,12 +586,10 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
-	irq_type = req_irq_type;
 	return true;
 
 err:
 	pci_endpoint_test_free_irq_vectors(test);
-	irq_type = IRQ_TYPE_UNDEFINED;
 	return false;
 }
 
-- 
2.17.1
