From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [BACKPORT 4.14.y 01/18] PCI: designware-ep: Fix find_first_zero_bit()
 usage
Date: Thu,  5 Sep 2019 10:17:42 -0600
Message-ID: <20190905161759.28036-2-mathieu.poirier@linaro.org>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20190905161759.28036-1-mathieu.poirier@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Niklas Cassel <niklas.cassel@axis.com>

commit ad4a5becc689c3f32bbbc2b37eff89efe19dc2f9 upstream

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

find_first_zero_bit() is called with size in bytes rather than bits,
which thus defines a too low upper limit, causing
dw_pcie_ep_inbound_atu() to assign iatu index #4 to both bar 4
and bar 5, which makes bar 5 overwrite the settings set by bar 4.

Since the sizes of the bitmaps are known, dynamically allocate the
bitmaps, and use the correct size when calling find_first_zero_bit().

Additionally, make sure that ep->num_ob_windows and ep->num_ib_windows,
which are obtained from device tree, are smaller than the maximum number
of iATUs (MAX_IATU_IN/MAX_IATU_OUT).

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/pci/dwc/pcie-designware-ep.c | 34 +++++++++++++++++++++-------
 drivers/pci/dwc/pcie-designware.h    |  8 +++++--
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index abcbf0770358..71795db41261 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -74,8 +74,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	free_win = find_first_zero_bit(&ep->ib_window_map,
-				       sizeof(ep->ib_window_map));
+	free_win = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
 	if (free_win >= ep->num_ib_windows) {
 		dev_err(pci->dev, "no free inbound window\n");
 		return -EINVAL;
@@ -89,7 +88,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
 	}
 
 	ep->bar_to_atu[bar] = free_win;
-	set_bit(free_win, &ep->ib_window_map);
+	set_bit(free_win, ep->ib_window_map);
 
 	return 0;
 }
@@ -100,8 +99,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	free_win = find_first_zero_bit(&ep->ob_window_map,
-				       sizeof(ep->ob_window_map));
+	free_win = find_first_zero_bit(ep->ob_window_map, ep->num_ob_windows);
 	if (free_win >= ep->num_ob_windows) {
 		dev_err(pci->dev, "no free outbound window\n");
 		return -EINVAL;
@@ -110,7 +108,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
 	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
 				  phys_addr, pci_addr, size);
 
-	set_bit(free_win, &ep->ob_window_map);
+	set_bit(free_win, ep->ob_window_map);
 	ep->outbound_addr[free_win] = phys_addr;
 
 	return 0;
@@ -125,7 +123,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno bar)
 	dw_pcie_ep_reset_bar(pci, bar);
 
 	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
-	clear_bit(atu_index, &ep->ib_window_map);
+	clear_bit(atu_index, ep->ib_window_map);
 }
 
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
@@ -181,7 +179,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
 		return;
 
 	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
-	clear_bit(atu_index, &ep->ob_window_map);
+	clear_bit(atu_index, ep->ob_window_map);
 }
 
 static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
@@ -302,12 +300,32 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		dev_err(dev, "unable to read *num-ib-windows* property\n");
 		return ret;
 	}
+	if (ep->num_ib_windows > MAX_IATU_IN) {
+		dev_err(dev, "invalid *num-ib-windows*\n");
+		return -EINVAL;
+	}
 
 	ret = of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows);
 	if (ret < 0) {
 		dev_err(dev, "unable to read *num-ob-windows* property\n");
 		return ret;
 	}
+	if (ep->num_ob_windows > MAX_IATU_OUT) {
+		dev_err(dev, "invalid *num-ob-windows*\n");
+		return -EINVAL;
+	}
+
+	ep->ib_window_map = devm_kzalloc(dev, sizeof(long) *
+					 BITS_TO_LONGS(ep->num_ib_windows),
+					 GFP_KERNEL);
+	if (!ep->ib_window_map)
+		return -ENOMEM;
+
+	ep->ob_window_map = devm_kzalloc(dev, sizeof(long) *
+					 BITS_TO_LONGS(ep->num_ob_windows),
+					 GFP_KERNEL);
+	if (!ep->ob_window_map)
+		return -ENOMEM;
 
 	addr = devm_kzalloc(dev, sizeof(phys_addr_t) * ep->num_ob_windows,
 			    GFP_KERNEL);
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 5af29d125c7e..ba9dedc31bfa 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -114,6 +114,10 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
+/* Maximum number of inbound/outbound iATUs */
+#define MAX_IATU_IN			256
+#define MAX_IATU_OUT			256
+
 struct pcie_port;
 struct dw_pcie;
 struct dw_pcie_ep;
@@ -193,8 +197,8 @@ struct dw_pcie_ep {
 	size_t			page_size;
 	u8			bar_to_atu[6];
 	phys_addr_t		*outbound_addr;
-	unsigned long		ib_window_map;
-	unsigned long		ob_window_map;
+	unsigned long		*ib_window_map;
+	unsigned long		*ob_window_map;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
 };
-- 
2.17.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
