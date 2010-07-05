From: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Subject: [PATCH] usb: musb: tusb6010: fix compile error with n8x0_defconfig
Date: Mon,  5 Jul 2010 12:12:01 +0300
Message-ID: <1278321121-13474-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Drop the unnecessary empty stubs in tusb6010.c and avoid
a compile error when building kernel for n8x0.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---

compile tested with n8x0_defconfig

 drivers/usb/musb/tusb6010.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 05c077f..3c48e77 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -29,19 +29,6 @@ static void tusb_source_power(struct musb *musb, int is_on);
 #define TUSB_REV_MAJOR(reg_val)		((reg_val >> 4) & 0xf)
 #define TUSB_REV_MINOR(reg_val)		(reg_val & 0xf)
 
-#ifdef CONFIG_PM
-/* REVISIT: These should be only needed if somebody implements off idle */
-void musb_platform_save_context(struct musb *musb,
-			struct musb_context_registers *musb_context)
-{
-}
-
-void musb_platform_restore_context(struct musb *musb,
-			struct musb_context_registers *musb_context)
-{
-}
-#endif
