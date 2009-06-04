From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 17/20] omapfb: suspend/resume only if FB device is already initialized
Date: Thu,  4 Jun 2009 20:52:42 +0300
Message-ID: <20541a2436ab1399a93c28197244bb05e8657859.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
 <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
 <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
 <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
 <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
 <d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
 <36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
 <024fee28b6c89decf0d50747127db8fc61ac789e.1244131952.git.imre.deak@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42211 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZFDRz5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:55:57 -0400
In-Reply-To: <024fee28b6c89decf0d50747127db8fc61ac789e.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>, Imre Deak <imre.deak@nokia.com>

=46rom: Jouni H=C3=B6gander <jouni.hogander@nokia.com>

Check wether fbdev is NULL in suspend / resume functions. Fbdev is
NULL, if there is no lcd or it is not enabled in configuration.

Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/omapfb_main.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omap=
fb_main.c
index 5b04b9c..098177b 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1842,8 +1842,8 @@ static int omapfb_suspend(struct platform_device =
*pdev, pm_message_t mesg)
 {
 	struct omapfb_device *fbdev =3D platform_get_drvdata(pdev);
=20
-	omapfb_blank(FB_BLANK_POWERDOWN, fbdev->fb_info[0]);
-
+	if (fbdev !=3D NULL)
+		omapfb_blank(FB_BLANK_POWERDOWN, fbdev->fb_info[0]);
 	return 0;
 }
=20
@@ -1852,7 +1852,8 @@ static int omapfb_resume(struct platform_device *=
pdev)
 {
 	struct omapfb_device *fbdev =3D platform_get_drvdata(pdev);
=20
-	omapfb_blank(FB_BLANK_UNBLANK, fbdev->fb_info[0]);
+	if (fbdev !=3D NULL)
+		omapfb_blank(FB_BLANK_UNBLANK, fbdev->fb_info[0]);
 	return 0;
 }
=20
--=20
1.6.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
