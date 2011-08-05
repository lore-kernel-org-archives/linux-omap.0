From: Michael Jones <michael.jones@matrix-vision.de>
Subject: [PATCH] OMAP: DSS2: DSI: fix warning unused variable 'dsidev'
Date: Fri,  5 Aug 2011 17:02:41 +0200
Message-ID: <1312556561-27179-1-git-send-email-michael.jones@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:47955 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab1HEPCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 11:02:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>

  CC      drivers/video/omap2/dss/dsi.o
drivers/video/omap2/dss/dsi.c: In function =E2=80=98omap_dsi_prepare_up=
date=E2=80=99:
drivers/video/omap2/dss/dsi.c:3936: warning: unused variable =E2=80=98d=
sidev=E2=80=99

Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
---
 drivers/video/omap2/dss/dsi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/ds=
i.c
index 345757c..3ae0fd8 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3933,7 +3933,9 @@ int omap_dsi_prepare_update(struct omap_dss_devic=
e *dssdev,
 				    u16 *x, u16 *y, u16 *w, u16 *h,
 				    bool enlarge_update_area)
 {
+#ifdef DEBUG
 	struct platform_device *dsidev =3D dsi_get_dsidev_from_dssdev(dssdev)=
;
+#endif
 	u16 dw, dh;
=20
 	dssdev->driver->get_resolution(dssdev, &dw, &dh);
--=20
1.7.6


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erh=
ard Meier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
