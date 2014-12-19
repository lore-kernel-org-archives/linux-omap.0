From: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 4/4] usb: dwc3: Remove current_trb as it is unused
Date: Fri, 19 Dec 2014 12:40:18 +0530
Message-ID: <c0058ce9513e339f223a7945e677e4e41b372a36.1418972323.git.amit.virdi@st.com>
References: <cover.1418972323.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1418972323.git.amit.virdi-qxv4g6HH51o@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ajay.khandelwal-qxv4g6HH51o@public.gmane.org, Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This field was introduced but never used. So, remove it.

Signed-off-by: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
---
 drivers/usb/dwc3/core.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4bb9aa696ede..0842aa80976f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -431,7 +431,6 @@ struct dwc3_event_buffer {
  * @dwc: pointer to DWC controller
  * @saved_state: ep state saved during hibernation
  * @flags: endpoint flags (wedged, stalled, ...)
- * @current_trb: index of current used trb
  * @number: endpoint number (1 - 15)
  * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
  * @resource_index: Resource transfer index
@@ -464,8 +463,6 @@ struct dwc3_ep {
 	/* This last one is specific to EP0 */
 #define DWC3_EP0_DIR_IN		(1 << 31)
 
-	unsigned		current_trb;
