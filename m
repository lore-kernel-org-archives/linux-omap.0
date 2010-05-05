From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 09/21] OMAP: DSS2: Taal: Ensure panel is enabled in enable_te() and run_test()
Date: Wed,  5 May 2010 17:27:29 +0300
Message-ID: <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
 <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34104 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934681Ab0EEO2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:01 -0400
In-Reply-To: <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Bail out from taal_enable_te() and taal_run_test() if panel is not
enabled.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   31 +++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index a093eda..214d3cf 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -946,11 +946,8 @@ static int taal_sync(struct omap_dss_device *dssdev)
 
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int r;
 
-	td->te_enabled = enable;
-
 	if (enable)
 		r = taal_dcs_write_1(DCS_TEAR_ON, 0);
 	else
@@ -973,11 +970,22 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	mutex_lock(&td->lock);
 	dsi_bus_lock();
 
-	r = _taal_enable_te(dssdev, enable);
+	if (td->enabled) {
+		r = _taal_enable_te(dssdev, enable);
+		if (r)
+			goto err;
+	}
+
+	td->te_enabled = enable;
 
 	dsi_bus_unlock();
 	mutex_unlock(&td->lock);
 
+	return 0;
+err:
+	dsi_bus_unlock();
+	mutex_unlock(&td->lock);
+
 	return r;
 }
 
@@ -1077,23 +1085,30 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 	int r;
 
 	mutex_lock(&td->lock);
+
+	if (!td->enabled) {
+		r = -ENODEV;
+		goto err1;
+	}
+
 	dsi_bus_lock();
 
 	r = taal_dcs_read_1(DCS_GET_ID1, &id1);
 	if (r)
-		goto err;
+		goto err2;
 	r = taal_dcs_read_1(DCS_GET_ID2, &id2);
 	if (r)
-		goto err;
+		goto err2;
 	r = taal_dcs_read_1(DCS_GET_ID3, &id3);
 	if (r)
-		goto err;
+		goto err2;
 
 	dsi_bus_unlock();
 	mutex_unlock(&td->lock);
 	return 0;
-err:
+err2:
 	dsi_bus_unlock();
+err1:
 	mutex_unlock(&td->lock);
 	return r;
 }
-- 
1.6.5.2

