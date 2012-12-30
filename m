From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] omap_vout: Fix mode build warning
Date: Sun, 30 Dec 2012 11:50:16 +0100
Message-ID: <1356864617-22410-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:39195 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025Ab2L3KuT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 30 Dec 2012 05:50:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Peter Meerwald <pmeerw@pmeerw.net>, Vaibhav Hiremath <hvaibhav@ti.com>

drivers/media/platform/omap/omap_vout.c: In function =E2=80=98omapvid_i=
nit=E2=80=99:
drivers/media/platform/omap/omap_vout.c:380:17: warning: =E2=80=98mode=E2=
=80=99 may be used uninitialized in this function [-Wuninitialized]
drivers/media/platform/omap/omap_vout.c:330:23: note: =E2=80=98mode=E2=80=
=99 was declared here

this issue was raised in May 2012 already
(http://comments.gmane.org/gmane.linux.drivers.video-input-infrastructu=
re/48617)

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/media/platform/omap/omap_vout.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/pl=
atform/omap/omap_vout.c
index 35cc526..0266ed2 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -333,8 +333,6 @@ static int video_mode_to_dss_mode(struct omap_vout_=
device *vout)
 	ovl =3D ovid->overlays[0];
=20
 	switch (pix->pixelformat) {
-	case 0:
-		break;
 	case V4L2_PIX_FMT_YUYV:
 		mode =3D OMAP_DSS_COLOR_YUV2;
 		break;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
