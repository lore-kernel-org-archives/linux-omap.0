From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 07/30] PCI: cadence: Add read and write accessors to perform only 32-bit accesses
Date: Tue, 4 Jun 2019 18:44:53 +0530
Message-ID: <20190604131516.13596-8-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Certain platforms like TI's J721E allows only 32-bit register accesses.
Add read and write accessor to perform only 32-bit accesses in order to
support platfroms like TI's J721E.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence.c | 40 +++++++++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index cd795f6fc1e2..de5b3b06f2d0 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -7,6 +7,46 @@
 
 #include "pcie-cadence.h"
 
+u32 cdns_pcie_read32(void __iomem *addr, int size)
+{
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 val = readl(aligned_addr);
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		pr_err("Invalid Address in function:%s\n", __func__);
+		return 0;
+	}
+
+	if (size > 2)
+		return val;
+
+	return (val >> (8 * offset)) & ((1 << (size * 8)) - 1);
+}
+
+void cdns_pcie_write32(void __iomem *addr, int size, u32 value)
+{
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 mask;
+	u32 val;
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		pr_err("Invalid Address in function:%s\n", __func__);
+		return;
+	}
+
+	if (size > 2) {
+		writel(value, addr);
+		return;
+	}
+
+	mask = ~(((1 << (size * 8)) - 1) << (offset * 8));
+	val = readl(aligned_addr) & mask;
+	val |= value << (offset * 8);
+	writel(val, aligned_addr);
+}
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size)
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index 0134c1b1ad65..d157bf5eabd5 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -406,6 +406,8 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+u32 cdns_pcie_read32(void __iomem *addr, int size);
+void cdns_pcie_write32(void __iomem *addr, int size, u32 value);
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.17.1
