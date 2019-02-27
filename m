From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 2/8] PCI: uniphier: fix a leaked reference by adding missing of_node_put
Date: Wed, 27 Feb 2019 12:40:37 +0800
Message-ID: <1551242443-27300-2-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, tyreld@linux.vnet.ibm.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ryder.lee@mediatek.com, lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, thomas.petazzoni@bootlin.com, shawn.lin@rock-chips.com, heiko@sntech.de, linux-rockchip@lists.infradead.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, hayashi.kunihiko@socionext.com, yamada.masahiro@socionext.com, kishon@ti.com, linux-omap@vger.kernel.org, wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: linux-omap@vger.kernel.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
irq_domain_add_linear also calls of_node_get to increase refcount,
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./drivers/pci/controller/dwc/pcie-uniphier.c:283:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.
./drivers/pci/controller/dwc/pcie-uniphier.c:290:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.
./drivers/pci/controller/dwc/pcie-uniphier.c:296:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 274, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index d5dc402..3f30ee4 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -270,6 +270,7 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
 	struct device_node *np = pci->dev->of_node;
 	struct device_node *np_intc;
+	int ret = 0;
 
 	np_intc = of_get_child_by_name(np, "legacy-interrupt-controller");
 	if (!np_intc) {
@@ -280,20 +281,24 @@ static int uniphier_pcie_config_legacy_irq(struct pcie_port *pp)
 	pp->irq = irq_of_parse_and_map(np_intc, 0);
 	if (!pp->irq) {
 		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-controller\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_put_node;
 	}
 
 	priv->legacy_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
 	if (!priv->legacy_irq_domain) {
 		dev_err(pci->dev, "Failed to get INTx domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	irq_set_chained_handler_and_data(pp->irq, uniphier_pcie_irq_handler,
 					 pp);
 
-	return 0;
+out_put_node:
+	of_node_put(np_intc);
+	return ret;
 }
 
 static int uniphier_pcie_host_init(struct pcie_port *pp)
-- 
2.9.5
