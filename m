From: ville.syrjala@nokia.com
Subject: [PATCH 3/4] DSS2: Make wait_for_go() succeed for disabled displays
Date: Fri,  5 Mar 2010 15:26:21 +0200
Message-ID: <1267795582-21004-3-git-send-email-ville.syrjala@nokia.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18494 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0CEN1t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 08:27:49 -0500
In-Reply-To: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

When the display is not active make the wait_for_go() functions return
immediately.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/dss/manager.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/ds=
s/manager.c
index 913142d..0e7b036 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -524,7 +524,7 @@ static int dss_mgr_wait_for_go(struct omap_overlay_=
manager *mgr)
 	int i;
 	struct omap_dss_device *dssdev =3D mgr->device;
=20
-	if (!dssdev)
+	if (!dssdev || dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
=20
 	if (dssdev->type =3D=3D OMAP_DISPLAY_TYPE_VENC) {
@@ -595,11 +595,14 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *=
ovl)
 	int r;
 	int i;
=20
-	if (!ovl->manager || !ovl->manager->device)
+	if (!ovl->manager)
 		return 0;
=20
 	dssdev =3D ovl->manager->device;
=20
+	if (!dssdev || dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
 	if (dssdev->type =3D=3D OMAP_DISPLAY_TYPE_VENC) {
 		irq =3D DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 		channel =3D OMAP_DSS_CHANNEL_DIGIT;
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
