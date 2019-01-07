From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
Date: Mon, 7 Jan 2019 12:11:41 +0530
Message-ID: <20190107064148.10152-9-kishon@ti.com>
References: <20190107064148.10152-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107064148.10152-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
Base Address Register irrespective of the size. Fix it here to indicate
64-bit BAR if the size is > 2GB.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 825fa24427a3..cd395cb7dfd9 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -132,6 +132,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 	epf->bar[bar].size = size;
 	epf->bar[bar].barno = bar;
 	epf->bar[bar].flags = PCI_BASE_ADDRESS_SPACE_MEMORY;
+	epf->bar[bar].flags |= upper_32_bits(size) ?
+				PCI_BASE_ADDRESS_MEM_TYPE_64 :
+				PCI_BASE_ADDRESS_MEM_TYPE_32;
 
 	return space;
 }
-- 
2.17.1
