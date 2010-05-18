From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 12/23] OMAP: DSS2: Taal: Fix DSI bus locking problem
Date: Tue, 18 May 2010 15:35:03 +0300
Message-ID: <1274186114-26951-13-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62560 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570Ab0ERMgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:32 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

If omapdss_dsi_display_enable() failed the DSI bus was left locked. Als=
o
if the operation failed later omapdss_dsi_display_disable() would get
called without holding the bus lock.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/=
omap2/displays/panel-taal.c
index 1799096..aaf5d30 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -702,10 +702,9 @@ static int taal_power_on(struct omap_dss_device *d=
ssdev)
=20
 	return 0;
 err:
-	dsi_bus_unlock();
-
 	omapdss_dsi_display_disable(dssdev);
 err0:
+	dsi_bus_unlock();
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
=20
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
