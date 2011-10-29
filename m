From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2] usb: ehci: report Data Buffer Error in debug mode
Date: Sat, 29 Oct 2011 16:53:45 -0700
Message-ID: <1319932425-10404-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50257 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412Ab1J2Xx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Oct 2011 19:53:57 -0400
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
---
v1: original patch

v2: fix review comments from Alan Stern<stern@rowland.harvard.edu>

 drivers/usb/host/ehci-q.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 4e4066c..f81c6de 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -373,6 +373,16 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
  retry_xacterr:
 		if ((token & QTD_STS_ACTIVE) == 0) {
 
+			/* Report Data Buffer Error: non-fatal but useful */
+			if (token & QTD_STS_DBE) {
+				ehci_dbg(ehci,
+				"detected DataBufferErr for urb %p ep%d%s len %d, qtd %p [qh %p]\n",
+				urb, usb_endpoint_num(urb->ep),
+				usb_endpoint_dir_in(urb->ep) ? "in" : "out",
+				urb->transfer_buffer_length,
+				qtd, urb->ep->hcpriv);
+			}
+
 			/* on STALL, error, and short reads this urb must
 			 * complete and all its qtds must be recycled.
 			 */
-- 
1.7.5.4

