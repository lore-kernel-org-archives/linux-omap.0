From: =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>
Subject: [PATCH] OMAPFB: Check in suspend/resume if framebuffer device is initialized.
Date: Fri, 28 Mar 2008 15:03:29 +0200
Message-ID: <1206709409-594-1-git-send-email-jouni.hogander@nokia.com>
References: <20080328104027.GX24896@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29932 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbYC1NDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 09:03:34 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2SD3KBA005415
	for <linux-omap@vger.kernel.org>; Fri, 28 Mar 2008 15:03:31 +0200
In-Reply-To: <20080328104027.GX24896@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Check wether fbdev is NULL in suspend / resume functions. Fbdev is
NULL, if there is no lcd or it is not enabled in configuration.

Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 drivers/video/omap/omapfb_main.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omap=
fb_main.c
index f66b81a..139c84c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1839,8 +1839,8 @@ static int omapfb_suspend(struct platform_device =
*pdev, pm_message_t mesg)
 {
 	struct omapfb_device *fbdev =3D platform_get_drvdata(pdev);
=20
-	omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
-
+	if (fbdev !=3D NULL)
+		omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
 	return 0;
 }
=20
@@ -1849,7 +1849,8 @@ static int omapfb_resume(struct platform_device *=
pdev)
 {
 	struct omapfb_device *fbdev =3D platform_get_drvdata(pdev);
=20
-	omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
+	if (fbdev !=3D NULL)
+		omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
 	return 0;
 }
=20
--=20
1.5.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
