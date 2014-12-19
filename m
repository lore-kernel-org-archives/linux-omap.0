From: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit is reached
Date: Fri, 19 Dec 2014 12:40:16 +0530
Message-ID: <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
References: <cover.1418972323.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1418972323.git.amit.virdi-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ajay.khandelwal-qxv4g6HH51o@public.gmane.org, Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When SG is used, there are two loops iterating to prepare TRBs:
 - Outer loop over the request_list
 - Inner loop over the SG list

The driver must stop preparing TRBs when the max TRBs have been prepared. The
code was missing break to get out of the outer loop.

Signed-off-by: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0eec2e917994..8f65ab3a3b92 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -900,6 +900,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 				if (last_one)
 					break;
 			}
+
+			if (last_one)
+				break;
 		} else {
 			dma = req->request.dma;
 			length = req->request.length;
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
