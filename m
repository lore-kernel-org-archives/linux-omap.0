From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 12/26] PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
Date: Mon, 25 Mar 2019 14:04:47 +0530
Message-ID: <20190325083501.8088-13-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

hook_fault_code is an ARM32 specific API for hooking into data abort.
Since pci-keystone.c will be used for AM65X platforms which is an
ARM64 platform, allow hook_fault_code to be compiled only for ARM32.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index dfe54553d832..93296d434f40 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -710,6 +710,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
+#ifdef CONFIG_ARM
 /*
  * When a PCI device does not exist during config cycles, keystone host gets a
  * bus error instead of returning 0xffffffff. This handler always returns 0
@@ -729,6 +730,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 
 	return 0;
 }
+#endif
 
 static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
@@ -778,12 +780,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	if (ret < 0)
 		return ret;
 
+#ifdef CONFIG_ARM
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
 	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
+#endif
 
 	ks_pcie_start_link(pci);
 	dw_pcie_wait_for_link(pci);
-- 
2.17.1
