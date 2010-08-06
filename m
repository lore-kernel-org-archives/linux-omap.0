From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/8]usb: musb: HWMOD database structures fixes OMAP4
Date: Fri,  6 Aug 2010 21:27:29 +0530
Message-ID: <1281110249-4098-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Hema HK  <hemahk-l0cyMroinI0@public.gmane.org>

Fixed the missing sysc settings for OMAP4 and enabled the OMAP4 
hwmod data structure.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---

Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c	2010-08-06 08:31:45.885868560 -0400
+++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c	2010-08-06 08:35:41.250112281 -0400
@@ -4516,8 +4516,15 @@
  */
 
 static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
-	.sysc_flags	= SYSS_MISSING,
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+
+	.rev_offs	= 0x0400,
+	.sysc_offs	= 0x0404,
+	.syss_offs	= 0x0408,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
+			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			  SYSC_HAS_AUTOIDLE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
 static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
@@ -4884,7 +4891,7 @@
 	/* usb_host_hs class */
 /*	&omap44xx_usb_host_hs_hwmod, */
 	/* usb_otg_hs class */
-/*	&omap44xx_usb_otg_hs_hwmod, */
+	&omap44xx_usb_otg_hs_hwmod,
 	/* usb_tll_hs class */
 /*	&omap44xx_usb_tll_hs_hwmod, */
 	/* wd_timer class */
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
