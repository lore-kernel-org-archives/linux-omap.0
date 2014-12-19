From: Amit Virdi <amit.virdi@st.com>
Subject: [PATCH 3/4] usb: dwc3: gadget: Remove redundant check
Date: Fri, 19 Dec 2014 12:40:17 +0530
Message-ID: <54c5f1a1ba9c471f6c23cda2bc32f4cfec2ed839.1418972323.git.amit.virdi@st.com>
References: <cover.1418972323.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33363 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894AbaLSHKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Dec 2014 02:10:39 -0500
In-Reply-To: <cover.1418972323.git.amit.virdi@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, pratyush.anand@gmail.com, ajay.khandelwal@st.com, Amit Virdi <amit.virdi@st.com>

dwc3_gadget_init_hw_endpoints calls dwc3_alloc_trb_pool only if epnum is not
equal to 0 or 1. Hence, rechecking it in the called function is redundant.

Signed-off-by: Amit Virdi <amit.virdi@st.com>
---
 drivers/usb/dwc3/gadget.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8f65ab3a3b92..8c2e2fbe6f39 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -352,9 +352,6 @@ static int dwc3_alloc_trb_pool(struct dwc3_ep *dep)
 	if (dep->trb_pool)
 		return 0;
 
-	if (dep->number == 0 || dep->number == 1)
-		return 0;
-
 	dep->trb_pool = dma_alloc_coherent(dwc->dev,
 			sizeof(struct dwc3_trb) * DWC3_TRB_NUM,
 			&dep->trb_pool_dma, GFP_KERNEL);
-- 
1.8.0

