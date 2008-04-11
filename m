From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 20/23] USB: MUSB: checkpatch.pl fixes to musb_core.h
Date: Fri, 11 Apr 2008 11:28:33 +0300
Message-ID: <1207902516-6374-21-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-17-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-18-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-19-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-20-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26612 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827AbYDKIaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:15 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpFE021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:13 +0300
In-Reply-To: <1207902516-6374-20-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 3494b99..c2cd5a9 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -218,7 +218,7 @@ enum musb_g_ep0_state {
 
 /* "flat" mapping: each endpoint has its own i/o address */
 #elif	defined(MUSB_FLAT_REG)
-#define musb_ep_select(_mbase, _epnum)	(((void)(_mbase)),((void)(_epnum)))
+#define musb_ep_select(_mbase, _epnum)	(((void)(_mbase)), ((void)(_epnum)))
 #define	MUSB_EP_OFFSET			MUSB_FLAT_OFFSET
 
 /* "indexed" mapping: INDEX register controls register bank select */
@@ -402,7 +402,7 @@ struct musb {
 #define	can_bulk_split(musb,type) \
 		(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_split)
 #else
-#define	can_bulk_split(musb,type)	0
+#define	can_bulk_split(musb, type)	0
 #endif
 
 #ifdef C_MP_RX
@@ -410,7 +410,7 @@ struct musb {
 #define	can_bulk_combine(musb,type) \
 		(((type) == USB_ENDPOINT_XFER_BULK) && (musb)->bulk_combine)
 #else
-#define	can_bulk_combine(musb,type)	0
+#define	can_bulk_combine(musb, type)	0
 #endif
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -464,8 +464,8 @@ extern const char musb_driver_name[];
 extern void musb_start(struct musb *musb);
 extern void musb_stop(struct musb *musb);
 
-extern void musb_write_fifo(struct musb_hw_ep *ep, u16 len, const u8 * src);
-extern void musb_read_fifo(struct musb_hw_ep *ep, u16 len, u8 * dst);
+extern void musb_write_fifo(struct musb_hw_ep *ep, u16 len, const u8 *src);
+extern void musb_read_fifo(struct musb_hw_ep *ep, u16 len, u8 *dst);
 
 extern void musb_load_testpacket(struct musb *);
 
-- 
1.5.5.23.g2a5fe

