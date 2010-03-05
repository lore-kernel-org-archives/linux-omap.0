From: ville.syrjala@nokia.com
Subject: [PATCH 2/4] DSS2: Check if display supports update mode changes
Date: Fri,  5 Mar 2010 15:26:20 +0200
Message-ID: <1267795582-21004-2-git-send-email-ville.syrjala@nokia.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18378 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab0CEN0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 08:26:43 -0500
In-Reply-To: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@nokia.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>

Check whether the display actually has the set_update_mode() function
before calling it. Only the sysfs codepath was broken, the omapfb ioctl
had the necessary protection.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com>
---
 drivers/video/omap2/dss/display.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/ds=
s/display.c
index 6a74ea1..3a8f146 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -82,6 +82,9 @@ static ssize_t display_upd_mode_store(struct device *=
dev,
 	int val, r;
 	enum omap_dss_update_mode mode;
=20
+	if (!dssdev->driver->set_update_mode)
+		return -EINVAL;
+
 	val =3D simple_strtoul(buf, NULL, 10);
=20
 	switch (val) {
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
