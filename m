From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 08/21] OMAP: DSS2: Taal: Improve taal_power_on() error handling
Date: Wed,  5 May 2010 17:27:28 +0300
Message-ID: <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34102 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443Ab0EEO2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:00 -0400
In-Reply-To: <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Check return values and bail out on errors.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   30 ++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index d0701e2..a093eda 100644
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

