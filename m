From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 02/11] pci: endpoint: introduce configfs entry for configuring EP functions
Date: Wed, 14 Sep 2016 10:41:58 +0530
Message-ID: <1473829927-20466-3-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473829927-20466-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, mingkai.hu-3arQi8VN3Tc@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org, Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Joao Pinto <jpinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kishon-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Introduce a new configfs entry to configure the EP function (like
configuring the standard configuration header entries) and to
bind the function with a controller.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/pci/endpoint/Kconfig      |    4 +-
 drivers/pci/endpoint/Makefile     |    3 +-
 drivers/pci/endpoint/pci-ep-cfs.c |  275 +++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/endpoint/pci-ep-cfs.c

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index a6d827c..f1dd206 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -13,7 +13,9 @@ config PCI_ENDPOINT
 
 	   Enabling this option will build the endpoint library, which
 	   includes endpoint controller library and endpoint function
-	   library.
+	   library. This will also enable the configfs entry required to
+	   configure the endpoint function and used to bind the
+	   function with a endpoint controller.
 
 	   If in doubt, say "N" to disable Endpoint support.
 
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index dbc5517..67c88bf 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -2,4 +2,5 @@
 # Makefile for PCI Endpoint Support
 #
 
-obj-$(CONFIG_PCI_ENDPOINT)		:= pci-epc-core.o pci-epf-core.o
+obj-$(CONFIG_PCI_ENDPOINT)		:= pci-epc-core.o pci-epf-core.o \
+					   pci-ep-cfs.o
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
new file mode 100644
index 0000000..d11ae34
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -0,0 +1,275 @@
+/**
+ * pci-ep-cfs.c - configfs to configure the PCI endpoint
+ *
+ * Copyright (C) 2016 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+
+struct pci_epf_info {
+	struct config_item pci_epf;
+	struct pci_epf *epf;
+};
+
+static inline struct pci_epf_info *to_pci_epf_info(struct config_item *item)
+{
+	return container_of(item, struct pci_epf_info, pci_epf);
+}
+
+#define PCI_EPF_HEADER_R(_name)	\
+static ssize_t pci_epf_##_name##_show(struct config_item *item,		\
+			char *page)					       \
+{									       \
+	return sprintf(page, "0x%04x\n",				       \
+		       to_pci_epf_info(item)->epf->header->_name);	       \
+}
+
+#define PCI_EPF_HEADER_W_u32(_name)	\
+static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
+					     const char *page, size_t len)     \
+{									       \
+	u32 val;							       \
+	int ret;							       \
+	ret = kstrtou32(page, 0, &val);					       \
+	if (ret)							       \
+		return ret;						       \
+	to_pci_epf_info(item)->epf->header->_name = val;		       \
+	return len;							       \
+}
+
+#define PCI_EPF_HEADER_W_u16(_name)	\
+static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
+					     const char *page, size_t len)     \
+{									       \
+	u16 val;							       \
+	int ret;							       \
+	ret = kstrtou16(page, 0, &val);					       \
+	if (ret)							       \
+		return ret;						       \
+	to_pci_epf_info(item)->epf->header->_name = val;		       \
+	return len;							       \
+}
+
+#define PCI_EPF_HEADER_W_u8(_name)	\
+static ssize_t pci_epf_##_name##_store(struct config_item *item,	       \
+					     const char *page, size_t len)     \
+{									       \
+	u8 val;								       \
+	int ret;							       \
+	ret = kstrtou8(page, 0, &val);					       \
+	if (ret)							       \
+		return ret;						       \
+	to_pci_epf_info(item)->epf->header->_name = val;		       \
+	return len;							       \
+}
+
+#define PCI_EPF_HEADER_RW(_name, _type)	\
+	PCI_EPF_HEADER_R(_name)		\
+	PCI_EPF_HEADER_W_##_type(_name)
+
+static ssize_t pci_epf_peripheral_store(struct config_item *item,
+					    const char *page, size_t len)
+{
+	struct pci_epf_info *epf_info = to_pci_epf_info(item);
+	char *dev_name;
+
+	dev_name = kstrdup(page, GFP_KERNEL);
+	if (!dev_name)
+		return -ENOMEM;
+	if (dev_name[len - 1] == '\n')
+		dev_name[len - 1] = '\0';
+
+	epf_info->epf->hw_devname = dev_name;
+	return len;
+}
+
+static ssize_t pci_epf_peripheral_show(struct config_item *item,
+					   char *page)
+{
+	return sprintf(page, "%s\n",
+		       to_pci_epf_info(item)->epf->hw_devname);
+}
+
+static ssize_t pci_epf_function_show(struct config_item *item,
+					   char *page)
+{
+	return sprintf(page, "%s\n",
+		       to_pci_epf_info(item)->epf->name);
+}
+
+static ssize_t pci_epf_epc_store(struct config_item *item,
+					    const char *page, size_t len)
+{
+	int ret;
+	struct pci_epf_info *epf_info = to_pci_epf_info(item);
+	char *epc_name;
+
+	epc_name = kstrdup(page, GFP_KERNEL);
+	if (!epc_name)
+		return -ENOMEM;
+	if (epc_name[len - 1] == '\n')
+		epc_name[len - 1] = '\0';
+
+	if (epf_info->epf->epc)
+		pci_epc_unbind_epf(epf_info->epf);
+
+	epf_info->epf->pci_epc_name = epc_name;
+	ret = pci_epc_bind_epf(epf_info->epf);
+	if (ret)
+		return -EINVAL;
+
+	return len;
+}
+
+static ssize_t pci_epf_epc_show(struct config_item *item,
+					   char *page)
+{
+	return sprintf(page, "%s\n",
+		       to_pci_epf_info(item)->epf->pci_epc_name);
+}
+
+PCI_EPF_HEADER_RW(vendorid, u16);
+PCI_EPF_HEADER_RW(deviceid, u16);
+PCI_EPF_HEADER_RW(revid, u16);
+PCI_EPF_HEADER_RW(progif_code, u16);
+PCI_EPF_HEADER_RW(subclass_code, u16);
+PCI_EPF_HEADER_RW(baseclass_code, u16);
+PCI_EPF_HEADER_RW(cache_line_size, u16);
+PCI_EPF_HEADER_RW(subsys_vendor_id, u16);
+PCI_EPF_HEADER_RW(subsys_id, u16);
+PCI_EPF_HEADER_RW(interrupt_pin, u16);
+
+CONFIGFS_ATTR(pci_epf_, vendorid);
+CONFIGFS_ATTR(pci_epf_, deviceid);
+CONFIGFS_ATTR(pci_epf_, revid);
+CONFIGFS_ATTR(pci_epf_, progif_code);
+CONFIGFS_ATTR(pci_epf_, subclass_code);
+CONFIGFS_ATTR(pci_epf_, baseclass_code);
+CONFIGFS_ATTR(pci_epf_, cache_line_size);
+CONFIGFS_ATTR(pci_epf_, subsys_vendor_id);
+CONFIGFS_ATTR(pci_epf_, subsys_id);
+CONFIGFS_ATTR(pci_epf_, interrupt_pin);
+CONFIGFS_ATTR(pci_epf_, peripheral);
+CONFIGFS_ATTR_RO(pci_epf_, function);
+CONFIGFS_ATTR(pci_epf_, epc);
+
+static struct configfs_attribute *pci_epf_attrs[] = {
+	&pci_epf_attr_vendorid,
+	&pci_epf_attr_deviceid,
+	&pci_epf_attr_revid,
+	&pci_epf_attr_progif_code,
+	&pci_epf_attr_subclass_code,
+	&pci_epf_attr_baseclass_code,
+	&pci_epf_attr_cache_line_size,
+	&pci_epf_attr_subsys_vendor_id,
+	&pci_epf_attr_subsys_id,
+	&pci_epf_attr_interrupt_pin,
+	&pci_epf_attr_peripheral,
+	&pci_epf_attr_function,
+	&pci_epf_attr_epc,
+	NULL,
+};
+
+static void pci_epf_release(struct config_item *item)
+{
+	struct pci_epf_info *epf_info = to_pci_epf_info(item);
+
+	pci_epf_destroy(epf_info->epf);
+	kfree(epf_info);
+}
+
+static struct configfs_item_operations pci_epf_ops = {
+	.release		= pci_epf_release,
+};
+
+static struct config_item_type pci_epf_type = {
+	.ct_item_ops	= &pci_epf_ops,
+	.ct_attrs	= pci_epf_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item *pci_epf_make(struct config_group *group,
+					const char *name)
+{
+	struct pci_epf_info *epf_info;
+	struct pci_epf *epf;
+
+	epf_info = kzalloc(sizeof(*epf_info), GFP_KERNEL);
+	if (!epf_info)
+		return ERR_PTR(-ENOMEM);
+
+	epf = pci_epf_create(name);
+	if (IS_ERR(epf)) {
+		pr_err("failed to create endpoint function device\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	epf_info->epf = epf;
+
+	config_item_init_type_name(&epf_info->pci_epf, name,
+				   &pci_epf_type);
+
+	return &epf_info->pci_epf;
+}
+
+static struct configfs_group_operations pci_ep_ops = {
+	.make_item	= pci_epf_make,
+};
+
+static struct config_item_type pci_ep_type = {
+	.ct_group_ops	= &pci_ep_ops,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem pci_ep_cfs_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "pci_ep",
+			.ci_type = &pci_ep_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(pci_ep_cfs_subsys.su_mutex),
+};
+
+static int __init pci_ep_cfs_init(void)
+{
+	int ret;
+
+	config_group_init(&pci_ep_cfs_subsys.su_group);
+
+	ret = configfs_register_subsystem(&pci_ep_cfs_subsys);
+	if (ret)
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret, pci_ep_cfs_subsys.su_group.cg_item.ci_namebuf);
+
+	return ret;
+}
+module_init(pci_ep_cfs_init);
+
+static void __exit pci_ep_cfs_exit(void)
+{
+	configfs_unregister_subsystem(&pci_ep_cfs_subsys);
+}
+module_exit(pci_ep_cfs_exit);
+
+MODULE_DESCRIPTION("PCI EP CONFIGFS");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
