From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 5/8] PCI: aardvark: fix a leaked reference by adding missing of_node_put
Date: Wed, 27 Feb 2019 12:40:40 +0800
Message-ID: <1551242443-27300-5-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
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
./drivers/pci/controller/pci-aardvark.c:826:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 798, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c..56ecb16 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -794,6 +794,7 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
 	struct irq_chip *irq_chip;
+	int ret = 0;
 
 	pcie_intc_node =  of_get_next_child(node, NULL);
 	if (!pcie_intc_node) {
@@ -806,8 +807,8 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-irq",
 					dev_name(dev));
 	if (!irq_chip->name) {
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_put_node;
 	}
 
 	irq_chip->irq_mask = advk_pcie_irq_mask;
@@ -819,11 +820,13 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 				      &advk_pcie_irq_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_put_node;
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(pcie_intc_node);
+	return ret;
 }
 
 static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
-- 
2.9.5
