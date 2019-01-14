From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 11/15] PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
Date: Mon, 14 Jan 2019 16:45:09 +0530
Message-ID: <20190114111513.21618-12-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Use pci_epc_get_features to get EPC features such as linkup
notifier support, MSI/MSIX capable, BAR configuration etc and use it
for configuring pci-epf-test. Since these features are now obtained
directly from EPC driver, remove pci_epf_test_data which was initially
added to have EPC features in endpoint function driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 87 ++++++++++++-------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ade296180383..2e0fb231ce0c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -47,9 +47,8 @@ struct pci_epf_test {
 	void			*reg[6];
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
-	bool			linkup_notifier;
-	bool			msix_available;
 	struct delayed_work	cmd_handler;
+	const struct pci_epc_features *epc_features;
 };
 
 struct pci_epf_test_reg {
@@ -71,11 +70,6 @@ static struct pci_epf_header test_header = {
 	.interrupt_pin	= PCI_INTERRUPT_INTA,
 };
 
-struct pci_epf_test_data {
-	enum pci_barno	test_reg_bar;
-	bool		linkup_notifier;
-};
-
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
@@ -402,10 +396,16 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	const struct pci_epc_features *epc_features;
+
+	epc_features = epf_test->epc_features;
 
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		epf_bar = &epf->bar[bar];
 
+		if (!!(epc_features->reserved_bar & (1 << bar)))
+			continue;
+
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
@@ -433,6 +433,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	void *base;
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	const struct pci_epc_features *epc_features;
+
+	epc_features = epf_test->epc_features;
 
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
 				   test_reg_bar);
@@ -446,6 +449,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 		if (bar == test_reg_bar)
 			continue;
+
+		if (!!(epc_features->reserved_bar & (1 << bar)))
+			continue;
+
 		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
 		if (!base)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
@@ -458,25 +465,50 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	return 0;
 }
 
+static void pci_epf_configure_bar(struct pci_epf *epf,
+				  const struct pci_epc_features *epc_features)
+{
+	struct pci_epf_bar *epf_bar;
+	bool bar_fixed_64bit;
+	int i;
+
+	for (i = BAR_0; i <= BAR_5; i++) {
+		epf_bar = &epf->bar[i];
+		bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
+		if (bar_fixed_64bit)
+			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+		if (epc_features->bar_fixed_size[i])
+			bar_size[i] = epc_features->bar_fixed_size[i];
+	}
+}
+
 static int pci_epf_test_bind(struct pci_epf *epf)
 {
 	int ret;
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
+	const struct pci_epc_features *epc_features;
+	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
+	bool linkup_notifier = false;
+	bool msix_capable = false;
+	bool msi_capable = true;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
 
-	if (epc->features & EPC_FEATURE_NO_LINKUP_NOTIFIER)
-		epf_test->linkup_notifier = false;
-	else
-		epf_test->linkup_notifier = true;
-
-	epf_test->msix_available = epc->features & EPC_FEATURE_MSIX_AVAILABLE;
+	epc_features = pci_epc_get_features(epc, epf->func_no);
+	if (epc_features) {
+		linkup_notifier = epc_features->linkup_notifier;
+		msix_capable = epc_features->msix_capable;
+		msi_capable = epc_features->msi_capable;
+		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+		pci_epf_configure_bar(epf, epc_features);
+	}
 
-	epf_test->test_reg_bar = EPC_FEATURE_GET_BAR(epc->features);
+	epf_test->test_reg_bar = test_reg_bar;
+	epf_test->epc_features = epc_features;
 
 	ret = pci_epc_write_header(epc, epf->func_no, header);
 	if (ret) {
@@ -492,13 +524,15 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
-	if (ret) {
-		dev_err(dev, "MSI configuration failed\n");
-		return ret;
+	if (msi_capable) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI configuration failed\n");
+			return ret;
+		}
 	}
 
-	if (epf_test->msix_available) {
+	if (msix_capable) {
 		ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
 		if (ret) {
 			dev_err(dev, "MSI-X configuration failed\n");
@@ -506,7 +540,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
-	if (!epf_test->linkup_notifier)
+	if (!linkup_notifier)
 		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
 
 	return 0;
@@ -523,17 +557,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test;
 	struct device *dev = &epf->dev;
-	const struct pci_epf_device_id *match;
-	struct pci_epf_test_data *data;
-	enum pci_barno test_reg_bar = BAR_0;
-	bool linkup_notifier = true;
-
-	match = pci_epf_match_device(pci_epf_test_ids, epf);
-	data = (struct pci_epf_test_data *)match->driver_data;
-	if (data) {
-		test_reg_bar = data->test_reg_bar;
-		linkup_notifier = data->linkup_notifier;
-	}
 
 	epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
 	if (!epf_test)
@@ -541,8 +564,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
 
 	epf->header = &test_header;
 	epf_test->epf = epf;
-	epf_test->test_reg_bar = test_reg_bar;
-	epf_test->linkup_notifier = linkup_notifier;
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-- 
2.17.1
