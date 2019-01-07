From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 15/15] PCI: endpoint: Remove features member in struct pci_epc
Date: Mon, 7 Jan 2019 12:11:48 +0530
Message-ID: <20190107064148.10152-16-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Since EPC features are now implemented using pci_epc_features and
all the EPC drivers are moved to using pci_epc_features, remove
features member in struct pci_epc and all the helper macros for
configuring the features.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/pci-epc.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index dc3513a2f88a..4870ad5a6ca2 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -99,7 +99,6 @@ struct pci_epc {
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
-	unsigned int			features;
 };
 
 /**
@@ -120,14 +119,6 @@ struct pci_epc_features {
 	u64	bar_fixed_size[BAR_5 + 1];
 };
 
-#define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
-#define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
-#define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
-#define EPC_FEATURE_SET_BAR(features, bar)	\
-		(features |= (EPC_FEATURE_BAR_MASK & (bar << 1)))
-#define EPC_FEATURE_GET_BAR(features)		\
-		((features & EPC_FEATURE_BAR_MASK) >> 1)
-
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
 
 #define pci_epc_create(dev, ops)    \
-- 
2.17.1
