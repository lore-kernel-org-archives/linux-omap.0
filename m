From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 5/6] usb: dwc3: ep0: Add chained TRB support
Date: Mon, 27 Jul 2015 12:25:31 +0530
Message-ID: <1437980132-20232-6-git-send-email-kishon@ti.com>
References: <1437980132-20232-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437980132-20232-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Add chained TRB support to ep0. Now TRB's can be chained just by
invoking _dwc3_ep0_start_trans_ with 'chain' parameter set to true.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/ep0.c    |   16 +++++++++++++---
 drivers/usb/dwc3/gadget.c |    2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 01411a8..73500d3 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -70,7 +70,10 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 		return 0;
 	}
 
-	trb = dwc->ep0_trb;
+	trb = &dwc->ep0_trb[dep->free_slot];
+
+	if (chain)
+		dep->free_slot++;
 
 	trb->bpl = lower_32_bits(buf_dma);
 	trb->bph = upper_32_bits(buf_dma);
@@ -78,10 +81,17 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	trb->ctrl = type;
 
 	trb->ctrl |= (DWC3_TRB_CTRL_HWO
-			| DWC3_TRB_CTRL_LST
-			| DWC3_TRB_CTRL_IOC
 			| DWC3_TRB_CTRL_ISP_IMI);
 
+	if (chain)
+		trb->ctrl |= DWC3_TRB_CTRL_CHN;
+	else
+		trb->ctrl |= (DWC3_TRB_CTRL_IOC
+				| DWC3_TRB_CTRL_LST);
+
+	if (chain)
+		return 0;
+
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d97fcfa..2feed9e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2687,7 +2687,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			&dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
-- 
1.7.9.5
