From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 20/26] PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability offset
Date: Mon, 25 Mar 2019 14:04:55 +0530
Message-ID: <20190325083501.8088-21-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

commit beb4641a787df79a ("PCI: dwc: Add MSI-X callbacks handler") while
adding MSI-X callback handler, introduced dw_pcie_ep_find_capability and
__dw_pcie_ep_find_next_cap for finding the MSI and MSIX capability.

However if MSI or MSIX capability is the last capability (i.e there are
no additional items in the capabilities list and the Next Capability
Pointer is set to '0'), __dw_pcie_ep_find_next_cap will return '0'
even though MSI or MSIX capability may be present. This is because of
incorrect ordering of "next_cap_ptr" check. Fix it here.

Fixes: beb4641a787df79a142 ("PCI: dwc: Add MSI-X callbacks handler")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index dc6a4bbd3ace..74477ad7467f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -46,16 +46,19 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
 	u8 cap_id, next_cap_ptr;
 	u16 reg;
 
+	if (!cap_ptr)
+		return 0;
+
 	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	next_cap_ptr = (reg & 0xff00) >> 8;
 	cap_id = (reg & 0x00ff);
 
-	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
+	if (cap_id > PCI_CAP_ID_MAX)
 		return 0;
 
 	if (cap_id == cap)
 		return cap_ptr;
 
+	next_cap_ptr = (reg & 0xff00) >> 8;
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
@@ -67,9 +70,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
 	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
 	next_cap_ptr = (reg & 0x00ff);
 
-	if (!next_cap_ptr)
-		return 0;
-
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
-- 
2.17.1
