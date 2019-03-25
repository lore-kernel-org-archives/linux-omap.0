From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 21/26] PCI: dwc: Add callbacks for accessing dbi2 address space
Date: Mon, 25 Mar 2019 14:04:56 +0530
Message-ID: <20190325083501.8088-22-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Certain platforms like TI's AM654 doesn't have separate address space for
dbi2 instead they are accessed using the same address space as dbi
with some configuration bit set. In order to support such platforms,
add callbacks for accessing dbi2 address space.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 31 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h | 12 ++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4e2f7946da89..d7cc1a0c1de6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -89,6 +89,37 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		dev_err(pci->dev, "Write DBI address failed\n");
 }
 
+u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			size_t size)
+{
+	int ret;
+	u32 val;
+
+	if (pci->ops->read_dbi2)
+		return pci->ops->read_dbi2(pci, base, reg, size);
+
+	ret = dw_pcie_read(base + reg, size, &val);
+	if (ret)
+		dev_err(pci->dev, "read DBI address failed\n");
+
+	return val;
+}
+
+void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			  size_t size, u32 val)
+{
+	int ret;
+
+	if (pci->ops->write_dbi2) {
+		pci->ops->write_dbi2(pci, base, reg, size, val);
+		return;
+	}
+
+	ret = dw_pcie_write(base + reg, size, val);
+	if (ret)
+		dev_err(pci->dev, "write DBI address failed\n");
+}
+
 static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e36941ff7cf6..7abca9eb00bf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -218,6 +218,10 @@ struct dw_pcie_ops {
 			    size_t size);
 	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
 			     size_t size, u32 val);
+	u32     (*read_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			     size_t size);
+	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			      size_t size, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
@@ -249,6 +253,10 @@ u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		       size_t size);
 void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 			 size_t size, u32 val);
+u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			size_t size);
+void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			  size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
@@ -292,12 +300,12 @@ static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
 
 static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 {
-	__dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, val);
+	__dw_pcie_write_dbi2(pci, pci->dbi_base2, reg, 0x4, val);
 }
 
 static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
 {
-	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
+	return __dw_pcie_read_dbi2(pci, pci->dbi_base2, reg, 0x4);
 }
 
 static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
-- 
2.17.1
