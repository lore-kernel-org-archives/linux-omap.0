From: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usb: disable OTG AUTOIDLE only with omap3430
Date: Mon, 18 May 2009 17:54:16 +0300
Message-ID: <1242658456-5723-1-git-send-email-ext-niilo.1.minkkinen@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Omap3 MUSB AUTOIDLE functionality configured through OTG_SYSCONFIG
register prevents the device from going into retention.
This is a workaround (by Richard Woodruff/TI), as his comment :
> A new MUSB bug which is a match to data below was identified very
> recently (on hardware and in simulation).
> This bug is in 3430 and not 3630.
> As a priority test (and as new default) you should have engineers
> disable autoidle for MUSB block.
> This is the workaround which will show up in next errata.

Signed-off-by: Niilo Minkkinen <ext-niilo.1.minkkinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 901dffd..396fc6d 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -241,7 +241,12 @@ int __init musb_platform_init(struct musb *musb)
 	l &= ~AUTOIDLE;		/* disable auto idle */
 	l &= ~NOIDLE;		/* remove possible noidle */
 	l |= SMARTIDLE;		/* enable smart idle */
-	l |= AUTOIDLE;		/* enable auto idle */
+	/*
+	 * MUSB AUTOIDLE don't work in 3430.
+	 * Workaround by Richard Woodruff/TI
+	 */
+	if (!cpu_is_omap3430())
+		l |= AUTOIDLE;		/* enable auto idle */
 	omap_writel(l, OTG_SYSCONFIG);
 
 	l = omap_readl(OTG_INTERFSEL);
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
