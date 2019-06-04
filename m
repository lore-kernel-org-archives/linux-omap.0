From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 17/30] PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
Date: Tue, 4 Jun 2019 18:45:03 +0530
Message-ID: <20190604131516.13596-18-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Protect concurrent access to pci_epf_ops with mutex.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 11 ++++++++++-
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 93f28c65ace0..6e0648991b5c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -35,7 +35,9 @@ void pci_epf_unbind(struct pci_epf *epf)
 		return;
 	}
 
+	mutex_lock(&epf->lock);
 	epf->driver->ops->unbind(epf);
+	mutex_unlock(&epf->lock);
 	module_put(epf->driver->owner);
 }
 EXPORT_SYMBOL_GPL(pci_epf_unbind);
@@ -49,6 +51,8 @@ EXPORT_SYMBOL_GPL(pci_epf_unbind);
  */
 int pci_epf_bind(struct pci_epf *epf)
 {
+	int ret;
+
 	if (!epf->driver) {
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
 		return -EINVAL;
@@ -57,7 +61,11 @@ int pci_epf_bind(struct pci_epf *epf)
 	if (!try_module_get(epf->driver->owner))
 		return -EAGAIN;
 
-	return epf->driver->ops->bind(epf);
+	mutex_lock(&epf->lock);
+	ret = epf->driver->ops->bind(epf);
+	mutex_unlock(&epf->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_bind);
 
@@ -252,6 +260,7 @@ struct pci_epf *pci_epf_create(const char *name)
 	device_initialize(dev);
 	dev->bus = &pci_epf_bus_type;
 	dev->type = &pci_epf_type;
+	mutex_init(&epf->lock);
 
 	ret = dev_set_name(dev, "%s", name);
 	if (ret) {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 4993f7f6439b..bcdf4f07bde7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,7 @@ struct pci_epf_bar {
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @nb: notifier block to notify EPF of any EPC events (like linkup)
+ * @lock: mutex to protect pci_epf_ops
  */
 struct pci_epf {
 	struct device		dev;
@@ -124,6 +125,8 @@ struct pci_epf {
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
 	struct notifier_block   nb;
+	/* mutex to protect against concurrent access of pci_epf_ops */
+	struct mutex		lock;
 };
 
 #define to_pci_epf(epf_dev) container_of((epf_dev), struct pci_epf, dev)
-- 
2.17.1
