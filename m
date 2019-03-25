From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 13/26] dt-bindings: PCI: Add PCI RC dt binding
 documentation for AM654
Date: Mon, 25 Mar 2019 15:09:34 +0530
Message-ID: <20190325093947.32633-14-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: devicetree@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, Kishon Vijay Abraham I <kishon@ti.com>, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, Roy Zang <roy.zang@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add devicetree binding documentation for PCIe in RC mode present in
AM654 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 8ee07197a063..5c60e911b8b1 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -11,7 +11,8 @@ described here as well as properties that are not applicable.
 
 Required Properties:-
 
-compatibility: "ti,keystone-pcie"
+compatibility: Should be "ti,keystone-pcie" for RC on Keystone2 SoC
+	       Should be "ti,am654-pcie-rc" for RC on AM654x SoC
 reg: Three register ranges as listed in the reg-names property
 reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 	   TI specific application registers, "config" for the
@@ -20,6 +21,9 @@ reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
 	interrupt-cells: should be set to 1
 	interrupts: GIC interrupt lines connected to PCI MSI interrupt lines
+	(required if the compatible is "ti,keystone-pcie")
+msi-map: As specified in Documentation/devicetree/bindings/pci/pci-msi.txt
+	 (required if the compatible is "ti,am654-pcie-rc".
 
 ti,syscon-pcie-id : phandle to the device control module required to set device
 		    id and vendor id.
-- 
2.17.1
