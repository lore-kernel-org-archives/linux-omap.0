From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 04/11] musb: save and restore missing bus control register
Date: Wed, 24 Mar 2010 13:47:52 +0200
Message-ID: <1269431279-22438-5-git-send-email-felipe.balbi@nokia.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53838 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab0CXLsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 07:48:51 -0400
In-Reply-To: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Ajay Kumar Gupta <ajay.gupta@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Added the missing BUS_CONTROL register in musb
save/restore routines.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    2 ++
 drivers/usb/musb/musb_core.h |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 69a1429..7a7f6ec 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2178,6 +2178,7 @@ void musb_save_context(struct musb *musb)
 	if (is_host_enabled(musb)) {
 		musb_context.frame = musb_readw(musb_base, MUSB_FRAME);
 		musb_context.testmode = musb_readb(musb_base, MUSB_TESTMODE);
+		musb_context.busctl = musb_read_ulpi_buscontrol(musb->mregs);
 	}
 	musb_context.power = musb_readb(musb_base, MUSB_POWER);
 	musb_context.intrtxe = musb_readw(musb_base, MUSB_INTRTXE);
@@ -2249,6 +2250,7 @@ void musb_restore_context(struct musb *musb)
 	if (is_host_enabled(musb)) {
 		musb_writew(musb_base, MUSB_FRAME, musb_context.frame);
 		musb_writeb(musb_base, MUSB_TESTMODE, musb_context.testmode);
+		musb_write_ulpi_buscontrol(musb->mregs, musb_context.busctl);
 	}
 	musb_writeb(musb_base, MUSB_POWER, musb_context.power);
 	musb_writew(musb_base, MUSB_INTRTXE, musb_context.intrtxe);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index f57ecd0..d7b277e 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -479,7 +479,7 @@ struct musb_context_registers {
 	u16 frame;
 	u8 index, testmode;
 
-	u8 devctl, misc;
+	u8 devctl, busctl, misc;
 
 	struct musb_csr_regs index_regs[MUSB_C_NUM_EPS];
 };
-- 
1.7.0.rc0.33.g7c3932

