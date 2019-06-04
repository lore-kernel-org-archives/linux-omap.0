From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 12/30] PCI: cadence: Make "mem" an optional memory resource
Date: Tue, 4 Jun 2019 18:44:58 +0530
Message-ID: <20190604131516.13596-13-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Cadence driver uses "mem" memory resource to obtain the offset of
configuration space address region, memory space address region and
message space address region. The obtained offset is used to program
the Address Translation Unit (ATU). However certain platforms like TI's
J721E SoC require the absolute address to be programmed in the and not
just the offset. Make "mem" an optional memory resource and use it
only for platforms that populate it.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pcie-cadence-ep.c   | 6 ++----
 drivers/pci/controller/pcie-cadence-host.c | 5 +++--
 drivers/pci/controller/pcie-cadence.c      | 6 ++++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 825a515821c3..23aa5aba1c86 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -489,10 +489,8 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
-	if (!res) {
-		dev_err(dev, "missing \"mem\"\n");
-		return -EINVAL;
-	}
+	if (!res)
+		dev_dbg(dev, "missing \"mem\"\n");
 	pcie->mem_res = res;
 
 	ret = of_property_read_u32(np, "cdns,max-outbound-regions",
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 8b3b9827a8d6..14a54f6a11de 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -188,9 +188,9 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	struct device *dev = rc->dev;
 	struct device_node *np = dev->of_node;
 	struct of_pci_range_parser parser;
+	u64 cpu_addr = cfg_res->start;
 	struct of_pci_range range;
 	u32 addr0, addr1, desc1;
-	u64 cpu_addr;
 	int r, err;
 
 	/*
@@ -203,7 +203,8 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
 
-	cpu_addr = cfg_res->start - mem_res->start;
+	if (mem_res)
+		cpu_addr -= mem_res->start;
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
 		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
 	addr1 = upper_32_bits(cpu_addr);
diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index 5ac42b19bb63..86282e9a26f7 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -154,7 +154,8 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
 
 	/* Set the CPU address */
-	cpu_addr -= pcie->mem_res->start;
+	if (pcie->mem_res)
+		cpu_addr -= pcie->mem_res->start;
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
 		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
 	addr1 = upper_32_bits(cpu_addr);
@@ -181,7 +182,8 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u8 fn,
 	}
 
 	/* Set the CPU address */
-	cpu_addr -= pcie->mem_res->start;
+	if (pcie->mem_res)
+		cpu_addr -= pcie->mem_res->start;
 	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
 		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
 	addr1 = upper_32_bits(cpu_addr);
-- 
2.17.1
