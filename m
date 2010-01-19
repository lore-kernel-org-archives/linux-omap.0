From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 12/16] usb: musb: save dynfifo in musb struct
Date: Tue, 19 Jan 2010 15:14:11 +0200
Message-ID: <1263906855-28341-13-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54616 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0ASNPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:15:35 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Save dynamic FIFO read only information for later uses during
musb_save/restore_context functions.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_core.c |    4 +++-
 drivers/usb/musb/musb_core.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index bd14e81..4c8962f 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1341,8 +1341,10 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	reg = musb_read_configdata(mbase);
 
 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
-	if (reg & MUSB_CONFIGDATA_DYNFIFO)
+	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
 		strcat(aInfo, ", dyn FIFOs");
+		musb->dyn_fifo = true;
+	}
 	if (reg & MUSB_CONFIGDATA_MPRXE) {
 		strcat(aInfo, ", bulk combine");
 		musb->bulk_combine = true;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 2ac0e6f..eaa0114 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -411,6 +411,7 @@ struct musb {
 
 	unsigned		hb_iso_rx:1;	/* high bandwidth iso rx? */
 	unsigned		hb_iso_tx:1;	/* high bandwidth iso tx? */
+	unsigned		dyn_fifo:1;	/* dynamic FIFO supported? */
 
 	unsigned		bulk_split:1;
 #define	can_bulk_split(musb,type) \
-- 
1.6.6.rc0

