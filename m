From: Amit Virdi <amit.virdi@st.com>
Subject: [PATCH 1/4] usb: dwc3: gadget: Fix TRB preparation during SG
Date: Fri, 19 Dec 2014 12:40:15 +0530
Message-ID: <1908f9be4bfb2148b4d2efa2dbc6de88c204e7f4.1418972323.git.amit.virdi@st.com>
References: <cover.1418972323.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43307 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894AbaLSHKf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2014 02:10:35 -0500
In-Reply-To: <cover.1418972323.git.amit.virdi@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, pratyush.anand@gmail.com, ajay.khandelwal@st.com, Amit Virdi <amit.virdi@st.com>

When scatter gather is used, multiple TRBs are prepared from one DWC3 request.
Hence, we must set the 'last' flag when the SG is last as well as the TRB is
last. The current implementation uses list_is_last to check if the dwc3_request
is the last request in the request_list.

This doesn't work when SG is used. This is because, when it is the last request,
the first TRB preparation (in dwc3_prepare_one_trb) modifies the dwc3_request
list's next and prev pointers while moving the URB to req_queued.

Hence, list_is_last always return false no matter what. The correct way is not
to access the modified pointers of dwc3_request but to use list_empty macro
instead.

Fixes: e5ba5ec833aa4a76980b512d6a6779643516b850 ("usb: dwc3: gadget: fix scatter
gather implementation"

Signed-off-by: Amit Virdi <amit.virdi@st.com>
---
 drivers/usb/dwc3/gadget.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f03b136ecfce..0eec2e917994 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -882,8 +882,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
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

