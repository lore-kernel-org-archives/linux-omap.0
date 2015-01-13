From: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH RESEND 1/2] usb: dwc3: gadget: Fix TRB preparation during SG
Date: Tue, 13 Jan 2015 12:10:37 +0530
Message-ID: <60d22f0ccc98b6bde0e36cc5d4da9d5cca0b8939.1421130636.git.amit.virdi@st.com>
References: <cover.1421130636.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1421130636.git.amit.virdi-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ajay.khandelwal-qxv4g6HH51o@public.gmane.org, Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When scatter gather (SG) is used, multiple TRBs are prepared from one DWC3
request (dwc3_request). So while preparing TRBs, the 'last' flag should be set
only when it is the last TRB being prepared from the last dwc3_request entry.

The current implementation uses list_is_last to check if the dwc3_request is the
last entry from the request_list. However, list_is_last returns false for the
last entry too. This is because, while preparing the first TRB from a request,
the function dwc3_prepare_one_trb modifies the request's next and prev pointers
while moving the URB to req_queued. Hence, list_is_last always returns false no
matter what.

The correct way is not to access the modified pointers of dwc3_request but to
use list_empty macro instead.

Fixes: e5ba5ec833aa4a76980b512d6a6779643516b850 ("usb: dwc3: gadget: fix scatter
gather implementation"

Signed-off-by: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.9+
---
 drivers/usb/dwc3/gadget.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4e2593993fae..cb8939134c32 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -879,8 +879,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
 				if (i == (request->num_mapped_sgs - 1) ||
 						sg_is_last(s)) {
-					if (list_is_last(&req->list,
-							&dep->request_list))
+					if (list_empty(&dep->request_list))
 						last_one = true;
 					chain = false;
 				}
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
