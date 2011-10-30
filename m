From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v3] usb: ehci: report Data Buffer Error in debug mode
Date: Sun, 30 Oct 2011 12:55:09 -0700
Message-ID: <1320004509-9411-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37060 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab1J3TzZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 30 Oct 2011 15:55:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

Data Buffer Error as per spec section 4.15.1.1.2
results when there is Underrun or Overrun condition.

This error is considered non-fatal and never gets reported.
Its a very good indication on things going wrong at system level,
like running memory at much slower speed.

This is a good error to flag allowing system level corrections.

An issue was found with OMAP4460 board where DDR had to be run
at full speed and this logging helped.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
v1: original patch

v2: fix review comments from Alan Stern
    * use usb_endpoint_num, usb_endpoint_dir_in

v3: More comments from Alan Stern
    * indent, use qh

 drivers/usb/host/ehci-q.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 4e4066c..f136f7f1 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -373,6 +373,17 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
  retry_xacterr:
 		if ((token & QTD_STS_ACTIVE) == 0) {
 
+			/* Report Data Buffer Error: non-fatal but useful */
+			if (token & QTD_STS_DBE)
+				ehci_dbg(ehci,
+					"detected DataBufferErr for urb %p ep%d%s len %d, qtd %p [qh %p]\n",
+					urb,
+					usb_endpoint_num(&urb->ep->desc),
+					usb_endpoint_dir_in(&urb->ep->desc) ? "in" : "out",
+					urb->transfer_buffer_length,
+					qtd,
+					qh);
+
 			/* on STALL, error, and short reads this urb must
 			 * complete and all its qtds must be recycled.
 			 */
-- 
1.7.5.4

