From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 4/6] usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain' parameter
Date: Fri, 24 Jul 2015 12:17:14 +0530
Message-ID: <1437720436-4261-5-git-send-email-kishon@ti.com>
References: <1437720436-4261-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437720436-4261-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, kishon@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

No functional change. Added a new parameter in _dwc3_ep0_start_trans_ to
indicate whether the TRB is a chained TRB or last TRB. This is in
preparation for adding chained TRB support for ep0.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/dwc3/ep0.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 4998074..d1a2be1 100644
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
@@ -302,7 +302,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 
 	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
-			DWC3_TRBCTL_CONTROL_SETUP);
+			DWC3_TRBCTL_CONTROL_SETUP, false);
 	WARN_ON(ret < 0);
 }
 
@@ -851,7 +851,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 			ret = dwc3_ep0_start_trans(dwc, epnum,
 					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA);
+					DWC3_TRBCTL_CONTROL_DATA, false);
 			WARN_ON(ret < 0);
 		}
 	}
@@ -935,7 +935,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	if (req->request.length == 0) {
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ctrl_req_addr, 0,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
 		u32	transfer_size = 0;
@@ -966,7 +966,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		 */
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ep0_bounce_addr, transfer_size,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else {
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
@@ -976,7 +976,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
-				req->request.length, DWC3_TRBCTL_CONTROL_DATA);
+				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
+				false);
 	}
 
 	WARN_ON(ret < 0);
@@ -991,7 +992,7 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
 	return dwc3_ep0_start_trans(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type);
+			dwc->ctrl_req_addr, 0, type, false);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
-- 
1.7.9.5
