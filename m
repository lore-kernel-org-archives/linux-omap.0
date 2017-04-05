From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v6 16/23] PCI: Add device IDs for DRA74x and DRA72x
Date: Wed, 5 Apr 2017 14:22:36 +0530
Message-ID: <20170405085243.18123-17-kishon@ti.com>
References: <20170405085243.18123-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170405085243.18123-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add device IDs for DRA74x and DRA72x devices. These devices have
configurable PCI endpoint.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a4f77feecbb0..5f6b71d15393 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -862,6 +862,8 @@
 #define PCI_DEVICE_ID_TI_X620		0xac8d
 #define PCI_DEVICE_ID_TI_X420		0xac8e
 #define PCI_DEVICE_ID_TI_XX20_FM	0xac8f
+#define PCI_DEVICE_ID_TI_DRA74x		0xb500
+#define PCI_DEVICE_ID_TI_DRA72x		0xb501
 
 #define PCI_VENDOR_ID_SONY		0x104d
 
-- 
2.11.0
