From: Amit Virdi <amit.virdi@st.com>
Subject: [PATCH RESEND 2/2] usb: dwc3: gadget: Stop TRB preparation after limit is reached
Date: Tue, 13 Jan 2015 12:10:38 +0530
Message-ID: <0850c56feeac33437a2aa22c07a8967007827ee9.1421130636.git.amit.virdi@st.com>
References: <cover.1421130636.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35217 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052AbbAMGlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 01:41:14 -0500
In-Reply-To: <cover.1421130636.git.amit.virdi@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, pratyush.anand@gmail.com, ajay.khandelwal@st.com, Amit Virdi <amit.virdi@st.com>

DWC3 gadget sets up a pool of 32 TRBs for each EP during initialization. This
means, the max TRBs that can be submitted for an EP is fixed to 32. Since the
request queue for an EP is a linked list, any number of requests can be queued
to it by the gadget layer.  However, the dwc3 driver must not submit TRBs more
than the pool it has created for. This limit wasn't respected when SG was used
resulting in submitting more than the max TRBs, eventually leading to
non-transfer of the TRBs submitted over the max limit.

Root cause:
When SG is used, there are two loops iterating to prepare TRBs:
 - Outer loop over the request_list
 - Inner loop over the SG list
The code was missing break to get out of the outer loop.

Signed-off-by: Amit Virdi <amit.virdi@st.com>
Cc: <stable@vger.kernel.org> # v3.9+
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index cb8939134c32..6c5e344822b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -897,6 +897,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
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

