From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 09/21] OMAP: DSS2: Taal: Bail out from taal_run_test() if panel is not enabled
Date: Mon,  3 May 2010 09:18:29 +0300
Message-ID: <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30953 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab0ECGSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:53 -0400
In-Reply-To: <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Avoid problems if panel was disabled while waiting for the mutex.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index a89b2e7..6abb080 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1077,23 +1077,30 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
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

