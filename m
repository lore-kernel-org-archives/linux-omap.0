From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 2/2] usb: dwc3: Add chained TRB support for ep0
Date: Fri, 6 Feb 2015 17:25:35 +0530
Message-ID: <1423223735-32512-2-git-send-email-kishon@ti.com>
References: <1423223735-32512-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423223735-32512-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

dwc3 can do only max packet aligned transfers. So in case request length
is not max packet aligned and is bigger than DWC3_EP0_BOUNCE_SIZE
two chained TRBs is required to handle the transfer.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
*) Did eumeration testing with g_zero in kernel
*) Similar patch was added in u-boot. With DFU, was able to create a scenario
where the request length is not max packet aligned and is bigger than
DWC3_EP0_BOUNCE_SIZE (512 bytes). In that case, 2 chained TRBs will be used.

 drivers/usb/dwc3/ep0.c    |   65 +++++++++++++++++++++++++++++++++------------
 drivers/usb/dwc3/gadget.c |    2 +-
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 24b7925..3b728b8 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
 }
 
 static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
-		u32 len, u32 type)
+		u32 len, u32 type, unsigned chain)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_trb			*trb;
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
@@ -302,7 +312,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 
 	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
-			DWC3_TRBCTL_CONTROL_SETUP);
+			DWC3_TRBCTL_CONTROL_SETUP, false);
 	WARN_ON(ret < 0);
 }
 
@@ -817,6 +827,22 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	maxp = ep0->endpoint.maxpacket;
 
+	/* Handle the first TRB before handling the bounce buffer if the request
+	 * length is greater than the bounce buffer size
+	 */
+	if (!IS_ALIGNED(ur->length, maxp) &&
+	    ur->length > DWC3_EP0_BOUNCE_SIZE) {
+		transfer_size = (ur->length / maxp) * maxp;
+		transferred = transfer_size - length;
+		buf = (u8 *)buf + transferred;
+		ur->actual += transferred;
+
+		trb++;
+		length = trb->size & DWC3_TRB_SIZE_MASK;
+
+		ep0->free_slot = 0;
+	}
+
 	if (dwc->ep0_bounced) {
 		transfer_size = roundup((ur->length - transfer_size),
 					maxp);
@@ -844,7 +870,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 			ret = dwc3_ep0_start_trans(dwc, epnum,
 					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA);
+					DWC3_TRBCTL_CONTROL_DATA, false);
 			WARN_ON(ret < 0);
 		}
 	}
@@ -928,7 +954,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	if (req->request.length == 0) {
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ctrl_req_addr, 0,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
 		u32	transfer_size = 0;
@@ -941,22 +967,26 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 		}
 
-		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
-
 		maxpacket = dep->endpoint.maxpacket;
+
+		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = (req->request.length / maxpacket) *
+						maxpacket;
+			ret = dwc3_ep0_start_trans(dwc, dep->number,
+						   req->request.dma,
+						   transfer_size,
+						   DWC3_TRBCTL_CONTROL_DATA,
+						   true);
+		}
+
 		transfer_size = roundup((req->request.length - transfer_size),
 					maxpacket);
 
 		dwc->ep0_bounced = true;
 
-		/*
-		 * REVISIT in case request length is bigger than
-		 * DWC3_EP0_BOUNCE_SIZE we will need two chained
-		 * TRBs to handle the transfer.
-		 */
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ep0_bounce_addr, transfer_size,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else {
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
@@ -966,7 +996,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
-				req->request.length, DWC3_TRBCTL_CONTROL_DATA);
+				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
+				false);
 	}
 
 	WARN_ON(ret < 0);
@@ -981,7 +1012,7 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
 	return dwc3_ep0_start_trans(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type);
+			dwc->ctrl_req_addr, 0, type, false);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a03a485..7212b93 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2682,7 +2682,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			&dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
-- 
1.7.9.5
