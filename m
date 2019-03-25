From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 11/26] PCI: dwc: Fix ATU identification for designware version >= 4.80
Date: Mon, 25 Mar 2019 14:04:46 +0530
Message-ID: <20190325083501.8088-12-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Synopsys designware version >= 4.80 uses a separate register space
for programming ATU. The current code identifies if there exists a
separate register space by accessing the register address of ATUs
in designware version < 4.80. Accessing this address results in
abort in the case of K2G.

Fix it here by adding "version" member to struct dw_pcie. This should
be set by platform specific drivers and designware core will use it
to identify if the platform has a separate ATU space. For platforms
which hasn't populated the version member, the old method of
identification will still be used.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 14 ++++++++------
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a14ca00f72aa..4e2f7946da89 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -358,13 +358,15 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
-	/* Get iATU unroll support */
-	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-	dev_dbg(pci->dev, "iATU unroll: %s\n",
-		pci->iatu_unroll_enabled ? "enabled" : "disabled");
+	if (pci->version >= 0x480A || (!pci->version &&
+				       dw_pcie_iatu_unroll_enabled(pci))) {
+		pci->iatu_unroll_enabled = true;
+		if (!pci->atu_base)
+			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+	}
+	dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
+		"enabled" : "disabled");
 
-	if (pci->iatu_unroll_enabled && !pci->atu_base)
-		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 
 	ret = of_property_read_u32(np, "num-lanes", &lanes);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ca3a3190a6f5..90a5b1215344 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -234,6 +234,7 @@ struct dw_pcie {
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
+	unsigned int		version;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.17.1
