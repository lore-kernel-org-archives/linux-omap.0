From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.34-rc2+ 04/11] musb: save and restore missing bus control register
Date: Thu, 25 Mar 2010 13:14:26 +0200
Message-ID: <1269515673-27980-5-git-send-email-felipe.balbi@nokia.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269515673-27980-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Added the missing BUS_CONTROL register in musb
save/restore routines.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    2 ++
 drivers/usb/musb/musb_core.h |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 0e8b8ab..3342b82 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2176,6 +2176,7 @@ void musb_save_context(struct musb *musb)
 	if (is_host_enabled(musb)) {
 		musb_context.frame = musb_readw(musb_base, MUSB_FRAME);
 		musb_context.testmode = musb_readb(musb_base, MUSB_TESTMODE);
+		musb_context.busctl = musb_read_ulpi_buscontrol(musb->mregs);
 	}
 	musb_context.power = musb_readb(musb_base, MUSB_POWER);
 	musb_context.intrtxe = musb_readw(musb_base, MUSB_INTRTXE);
@@ -2247,6 +2248,7 @@ void musb_restore_context(struct musb *musb)
 	if (is_host_enabled(musb)) {
 		musb_writew(musb_base, MUSB_FRAME, musb_context.frame);
 		musb_writeb(musb_base, MUSB_TESTMODE, musb_context.testmode);
+		musb_write_ulpi_buscontrol(musb->mregs, musb_context.busctl);
 	}
 	musb_writeb(musb_base, MUSB_POWER, musb_context.power);
 	musb_writew(musb_base, MUSB_INTRTXE, musb_context.intrtxe);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index cd9f4a9..ac17b00 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -478,7 +478,7 @@ struct musb_context_registers {
 	u16 frame;
 	u8 index, testmode;
 
-	u8 devctl, misc;
+	u8 devctl, busctl, misc;
 
 	struct musb_csr_regs index_regs[MUSB_C_NUM_EPS];
 };
-- 
1.7.0.rc0.33.g7c3932

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
