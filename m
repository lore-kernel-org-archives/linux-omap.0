From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 7/8] PCI: mediatek: fix a leaked reference by adding missing of_node_put
Date: Wed, 27 Feb 2019 12:40:42 +0800
Message-ID: <1551242443-27300-7-git-send-email-wen.yang99@zte.com.cn>
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
./drivers/pci/controller/pcie-mediatek.c:577:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.
./drivers/pci/controller/pcie-mediatek.c:583:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.
./drivers/pci/controller/pcie-mediatek.c:586:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 567, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pcie-mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 55e471c..e91716a 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -572,6 +572,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 
 	port->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						 &intx_domain_ops, port);
+	of_node_put(pcie_intc_node);
 	if (!port->irq_domain) {
 		dev_err(dev, "failed to get INTx IRQ domain\n");
 		return -ENODEV;
-- 
2.9.5
