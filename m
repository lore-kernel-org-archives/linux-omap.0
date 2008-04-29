From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] USB: MUSB: Better sysconf reg settings on PM point of view
Date: Tue, 29 Apr 2008 14:05:51 +0300
Message-ID: <1209467151-24972-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62888 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbYD2LHd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 07:07:33 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3TB77gS031675
	for <linux-omap@vger.kernel.org>; Tue, 29 Apr 2008 14:07:31 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>

The following patch is needed because usb is preventing core
powerdomain to enter sleep state.

Thanks to Jouni H=C3=B6gander for pointing this

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 drivers/usb/musb/omap2430.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index e092393..36f1739 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -224,6 +224,14 @@ int __init musb_platform_init(struct musb *musb)
 	musb->xceiv =3D *xceiv;
 	musb_platform_resume(musb);
=20
+	OTG_SYSCONFIG_REG &=3D ~ENABLEWAKEUP;	/* disable wakeup */
+	OTG_SYSCONFIG_REG &=3D ~NOSTDBY;		/* remove possible nostdby */
+	OTG_SYSCONFIG_REG |=3D SMARTSTDBY;	/* enable smart standby */
+	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
+	OTG_SYSCONFIG_REG &=3D ~NOIDLE;		/* remove possible noidle */
+	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
+	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
+
 	OTG_INTERFSEL_REG |=3D ULPI_12PIN;
=20
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
@@ -250,12 +258,8 @@ int musb_platform_suspend(struct musb *musb)
 		return 0;
=20
 	/* in any role */
-	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE; /* disable MSTANDBY */
-	OTG_SYSCONFIG_REG &=3D FORCESTDBY;	/* enable force standby */
-	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
-	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
-	OTG_FORCESTDBY_REG |=3D ENABLEFORCE; /* enable MSTANDBY */
-	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
+	OTG_FORCESTDBY_REG |=3D ENABLEFORCE;	/* enable MSTANDBY */
+	OTG_SYSCONFIG_REG |=3D ENABLEWAKEUP;	/* enable wakeup */
=20
 	if (musb->xceiv.set_suspend)
 		musb->xceiv.set_suspend(&musb->xceiv, 1);
@@ -281,11 +285,8 @@ int musb_platform_resume(struct musb *musb)
 	else
 		clk_enable(musb->clock);
=20
-	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE; /* disable MSTANDBY */
-	OTG_SYSCONFIG_REG |=3D SMARTSTDBY;	/* enable smart standby */
-	OTG_SYSCONFIG_REG &=3D ~AUTOIDLE;		/* disable auto idle */
-	OTG_SYSCONFIG_REG |=3D SMARTIDLE;		/* enable smart idle */
-	OTG_SYSCONFIG_REG |=3D AUTOIDLE;		/* enable auto idle */
+	OTG_SYSCONFIG_REG &=3D ~ENABLEWAKEUP;	/* disable wakeup */
+	OTG_FORCESTDBY_REG &=3D ~ENABLEFORCE;	/* disable MSTANDBY */
=20
 	return 0;
 }
--=20
1.5.5.1.99.gf0ec4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
