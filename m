From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 16/24] PCI: endpoint: Add support to allocate aligned buffers to be mapped in BARs
Date: Mon, 14 Jan 2019 18:54:16 +0530
Message-ID: <20190114132424.6445-17-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Modify pci_epf_alloc_space API to take alignment size as argument in
order to argument in order to allocate aligned buffers to be mapped to
BARs.

Add 'align' parameter to epc_features which can be used by platform
drivers to specifiy the BAR allocation alignment requirements and use
this while invoking pci_epf_alloc_space.

This is mainly required for Synopsys Designware PCIe core which masks
the lower bits based on the BAR size (See "I/O and MEM Match Modes"
section in DesignWare Cores PCI Express Controller Databook version
4.90a).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c |  5 +++--
 drivers/pci/endpoint/pci-epf-core.c           | 10 ++++++++--
 include/linux/pci-epc.h                       |  2 ++
 include/linux/pci-epf.h                       |  3 ++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 2e0fb231ce0c..faffae2551ed 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -438,7 +438,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	epc_features = epf_test->epc_features;
 
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
-				   test_reg_bar);
+				   test_reg_bar, epc_features->align);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
@@ -453,7 +453,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
 
-		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
+		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
+					   epc_features->align);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8bfdcd291196..fb1306de8f40 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -109,10 +109,12 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
  * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
  * @size: the size of the memory that has to be allocated
  * @bar: the BAR number corresponding to the allocated register space
+ * @align: alignment size for the allocation region
  *
  * Invoke to allocate memory for the PCI EPF register space.
  */
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
+			  size_t align)
 {
 	void *space;
 	struct device *dev = epf->epc->dev.parent;
@@ -120,7 +122,11 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 
 	if (size < 128)
 		size = 128;
-	size = roundup_pow_of_two(size);
+
+	if (align)
+		size = ALIGN(size, align);
+	else
+		size = roundup_pow_of_two(size);
 
 	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
 	if (!space) {
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c3ffa3917f88..f641badc2c61 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -109,6 +109,7 @@ struct pci_epc {
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
  * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
  * @bar_fixed_size: Array specifying the size supported by each BAR
+ * @align: alignment size required for BAR buffer allocation
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
@@ -117,6 +118,7 @@ struct pci_epc_features {
 	u8	reserved_bar;
 	u8	bar_fixed_64bit;
 	u64	bar_fixed_size[BAR_5 + 1];
+	size_t	align;
 };
 
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index ec02f58758c8..2d6f07556682 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -149,7 +149,8 @@ void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,
 			      struct module *owner);
 void pci_epf_unregister_driver(struct pci_epf_driver *driver);
-void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar);
+void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
+			  size_t align);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-- 
2.17.1
