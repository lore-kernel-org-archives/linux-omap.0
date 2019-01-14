From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 07/15] PCI: endpoint: Add helper to get first unreserved BAR
Date: Mon, 14 Jan 2019 16:45:05 +0530
Message-ID: <20190114111513.21618-8-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add a helper function pci_epc_get_first_free_bar(), to get the first
unreserved BAR that can be used for endpoint function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++++
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a099479d9ab..e4712a0f249c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,29 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
+ * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
+ *
+ * Invoke to get the first unreserved BAR that can be used for endpoint
+ * function. For any incorrect value in reserved_bar return '0'.
+ */
+unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
+					*epc_features)
+{
+	int free_bar;
+
+	if (!epc_features)
+		return 0;
+
+	free_bar = ffz(epc_features->reserved_bar);
+	if (free_bar > 5)
+		return 0;
+
+	return free_bar;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_first_free_bar);
+
 /**
  * pci_epc_get_features() - get the features supported by EPC
  * @epc: the features supported by *this* EPC device will be returned
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 79fbcf94e14d..94e1ecff98ce 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -180,6 +180,8 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no);
+unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
+					*epc_features);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1
