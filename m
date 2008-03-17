From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] USB: GADGET: Fix compile breakage on omap_udc.c
Date: Mon, 17 Mar 2008 21:50:50 +0200
Message-ID: <1205783450-16673-3-git-send-email-me@felipebalbi.com>
References: <1205783450-16673-1-git-send-email-me@felipebalbi.com>
 <1205783450-16673-2-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37145 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbYCQTso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 15:48:44 -0400
In-Reply-To: <1205783450-16673-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>

Recent changes broke compilation for omap_udc.c.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/gadget/omap_udc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 85a0d1a..9aa5946 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2299,7 +2299,7 @@ static int proc_otg_show(struct seq_file *s)
 		 * do with the frame adjustment counter and McBSP2.
 		 */
 		ctrl_name = "control_devconf";
-		trans = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0);
+		trans = omap_ctrl_readb(OMAP2_CONTROL_DEVCONF0);
 	} else {
 		ctrl_name = "tranceiver_ctrl";
 		trans = USB_TRANSCEIVER_CTRL_REG;
-- 
1.5.4.3.447.gc95b3

