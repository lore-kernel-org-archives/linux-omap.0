From: ville.syrjala@nokia.com
Subject: [PATCH v4 3/8] DSS2: OMAPFB: Skip unnecessary set_overlay_info()
Date: Thu, 18 Mar 2010 00:46:18 +0200
Message-ID: <1268865983-16270-4-git-send-email-ville.syrjala@nokia.com>
References: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28622 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab0CQWqn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 18:46:43 -0400
In-Reply-To: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

In omapfb_enable_overlay() if the overlay state is already what we want
skip the set_overlay_info().

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/=
omapfb/omapfb.h
index cd54fdb..c9866be 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -148,6 +148,8 @@ static inline int omapfb_overlay_enable(struct omap=
_overlay *ovl,
 	struct omap_overlay_info info;
=20
 	ovl->get_overlay_info(ovl, &info);
+	if (info.enabled =3D=3D enable)
+		return 0;
 	info.enabled =3D enable;
 	return ovl->set_overlay_info(ovl, &info);
 }
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
