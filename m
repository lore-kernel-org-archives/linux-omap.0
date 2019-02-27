From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 1/8] PCI: dwc: pci-dra7xx: fix a leaked reference by adding missing of_node_put
Date: Wed, 27 Feb 2019 12:40:36 +0800
Message-ID: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, tyreld@linux.vnet.ibm.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ryder.lee@mediatek.com, lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, thomas.petazzoni@bootlin.com, shawn.lin@rock-chips.com, heiko@sntech.de, linux-rockchip@lists.infradead.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, hayashi.kunihiko@socionext.com, yamada.masahiro@socionext.com, kishon@ti.com, linux-omap@vger.kernel.org, wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: linux-omap@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
irq_domain_add_linear also calls of_node_get to increase refcount,
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./drivers/pci/controller/dwc/pci-dra7xx.c:252:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.
./drivers/pci/controller/dwc/pci-dra7xx.c:255:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 241, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index ae84a69..627c91d 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -247,6 +247,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 
 	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						   &intx_domain_ops, pp);
+	of_node_put(pcie_intc_node);
 	if (!dra7xx->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
-- 
2.9.5
