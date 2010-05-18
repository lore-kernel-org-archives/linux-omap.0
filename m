From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 10/23] OMAP: DSS2: Make partial update width even
Date: Tue, 18 May 2010 15:35:01 +0300
Message-ID: <1274186114-26951-11-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57913 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503Ab0ERMgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:10 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

There are some strange problems with DSI and updates with odd widths. O=
ne
particular problem is that HS TX timeout triggers easily with updates w=
ith
odd widths.

This patch makes the updates widths even, circumventing the problem. Th=
ere
should be no ill side effects with increasing the update area slightly =
to
make the width even.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/manager.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/ds=
s/manager.c
index 0820986..32ec2ff 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -940,6 +940,22 @@ static int configure_dispc(void)
 	return r;
 }
=20
+/* Make the coordinates even. There are some strange problems with OMA=
P and
+ * partial DSI update when the update widths are odd. */
+static void make_even(u16 *x, u16 *w)
+{
+	u16 x1, x2;
+
+	x1 =3D *x;
+	x2 =3D *x + *w;
+
+	x1 &=3D ~1;
+	x2 =3D ALIGN(x2, 2);
+
+	*x =3D x1;
+	*w =3D x2 - x1;
+}
+
 /* Configure dispc for partial update. Return possibly modified update
  * area */
 void dss_setup_partial_planes(struct omap_dss_device *dssdev,
@@ -968,6 +984,8 @@ void dss_setup_partial_planes(struct omap_dss_devic=
e *dssdev,
 		return;
 	}
=20
+	make_even(&x, &w);
+
 	spin_lock_irqsave(&dss_cache.lock, flags);
=20
 	/* We need to show the whole overlay if it is scaled. So look for
@@ -1029,6 +1047,8 @@ void dss_setup_partial_planes(struct omap_dss_dev=
ice *dssdev,
 		w =3D x2 - x1;
 		h =3D y2 - y1;
=20
+		make_even(&x, &w);
+
 		DSSDBG("changing upd area due to ovl(%d) scaling %d,%d %dx%d\n",
 				i, x, y, w, h);
 	}
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
