From: Jani Nikula <ext-jani.1.nikula@Nokia.com>
Subject: [PATCH v2 08/21] OMAP: DSS2: Taal: Improve taal_power_on() error handling
Date: Mon,  3 May 2010 09:18:28 +0300
Message-ID: <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34466 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab0ECGS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:56 -0400
In-Reply-To: <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@Nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@Nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Check return values and bail out on errors.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   30 ++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 3f4687a..a89b2e7 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -696,16 +696,32 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	if (id2 == 0x00 || id2 == 0xff || id2 == 0x81)
 		td->cabc_broken = true;
 
-	taal_dcs_write_1(DCS_BRIGHTNESS, 0xff);
-	taal_dcs_write_1(DCS_CTRL_DISPLAY, (1<<2) | (1<<5)); /* BL | BCTRL */
+	r = taal_dcs_write_1(DCS_BRIGHTNESS, 0xff);
+	if (r)
+		goto err;
 
-	taal_dcs_write_1(DCS_PIXEL_FORMAT, 0x7); /* 24bit/pixel */
+	r = taal_dcs_write_1(DCS_CTRL_DISPLAY,
+			(1<<2) | (1<<5));	/* BL | BCTRL */
+	if (r)
+		goto err;
 
-	taal_set_addr_mode(td->rotate, td->mirror);
-	if (!td->cabc_broken)
-		taal_dcs_write_1(DCS_WRITE_CABC, td->cabc_mode);
+	r = taal_dcs_write_1(DCS_PIXEL_FORMAT, 0x7); /* 24bit/pixel */
+	if (r)
+		goto err;
 
-	taal_dcs_write_0(DCS_DISPLAY_ON);
+	r = taal_set_addr_mode(td->rotate, td->mirror);
+	if (r)
+		goto err;
+
+	if (!td->cabc_broken) {
+		r = taal_dcs_write_1(DCS_WRITE_CABC, td->cabc_mode);
+		if (r)
+			goto err;
+	}
+
+	r = taal_dcs_write_0(DCS_DISPLAY_ON);
+	if (r)
+		goto err;
 
 	r = _taal_enable_te(dssdev, td->te_enabled);
 	if (r)
-- 
1.6.5.2

