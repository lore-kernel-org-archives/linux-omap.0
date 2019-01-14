From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 03/24] dt-bindings: PCI: keystone: Add "reg-names" binding information
Date: Mon, 14 Jan 2019 18:54:03 +0530
Message-ID: <20190114132424.6445-4-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Murali Karicheri <m-karicheri2@ti.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Add "reg-names" binding information in order for device tree node
to be populated with the correct register strings. This will break
old dt compatibility. However Keystone PCI has never worked
in upstream kernel due to lack of SERDES support. Before SERDES
support is added, cleanup the Keystone PCI dt-bindngs. This new
binding will also be used by PCI in AM654 platform.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 2030ee0dc4f9..3a551687cfa2 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -12,8 +12,10 @@ described here as well as properties that are not applicable.
 Required Properties:-
 
 compatibility: "ti,keystone-pcie"
-reg:	index 1 is the base address and length of DW application registers.
-	index 2 is the base address and length of PCI device ID register.
+reg: Three register ranges as listed in the reg-names property
+reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
+	   TI specific application registers, "config" for the
+	   configuration space address
 
 pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
 	interrupt-cells: should be set to 1
-- 
2.17.1
