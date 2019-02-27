From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 8/8] PCI: rpadlpar: fix a leaked reference by adding missing of_node_put
Date: Wed, 27 Feb 2019 12:40:43 +0800
Message-ID: <1551242443-27300-8-git-send-email-wen.yang99@zte.com.cn>
References: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551242443-27300-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, tyreld@linux.vnet.ibm.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ryder.lee@mediatek.com, lorenzo.pieralisi@arm.com, matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, thomas.petazzoni@bootlin.com, shawn.lin@rock-chips.com, heiko@sntech.de, linux-rockchip@lists.infradead.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, hayashi.kunihiko@socionext.com, yamada.masahiro@socionext.com, kishon@ti.com, linux-omap@vger.kernel.org, wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
List-Id: linux-omap@vger.kernel.org

The call to of_find_node_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pci/hotplug/rpadlpar_core.c:55:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 42, but without a corresponding object release within this function

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pci/hotplug/rpadlpar_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index e2356a9..f3f42ff 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -52,6 +52,7 @@ static struct device_node *find_vio_slot_node(char *drc_name)
 			break;
 	}
 
+	of_node_put(parent);
 	return dn;
 }
 
-- 
2.9.5
