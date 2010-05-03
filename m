From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 17/21] OMAP: DSS2: Taal: Configure ESD check in DSI panel data
Date: Mon,  3 May 2010 09:18:37 +0300
Message-ID: <261f7b2c8cf1120e05d9664137e22ed237657c60.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
 <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ad1917b1c316a85051c4a908705d403956ca1720.1272621452.git.ext-jani.1.nikula@nokia.com>
 <4004b06a47d3c1d20d6d8a30ddccdf536faeb5a0.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88e1b382ddf14870c7a44e7ca620ad84d883b50.1272621452.git.ext-jani.1.nikula@nokia.com>
 <5a5dc1e253df571477551b8f63560ad9d1a3ab2b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <df2ca92a00d718b95aa6a7875a4199882c86f513.1272621452.git.ext-jani.1.nikula@nokia.com>
 <d76f00a4c763b84d7511a9f0c98eb7117e9e6a3e.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30973 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535Ab0ECGTC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:19:02 -0400
In-Reply-To: <d76f00a4c763b84d7511a9f0c98eb7117e9e6a3e.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Make ESD check usage configurable in DSI panel data, as opposed to a

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index b68976b..f5a1422 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -62,7 +62,6 @@
 #define DCS_GET_ID2		0xdb
 #define DCS_GET_ID3		0xdc
 
-/* #define TAAL_USE_ESD_CHECK */
 #define TAAL_ESD_CHECK_PERIOD	msecs_to_jiffies(5000)
 
 static irqreturn_t taal_te_isr(int irq, void *data);
@@ -794,6 +793,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 static int taal_enable(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "enable\n");
@@ -814,9 +814,9 @@ static int taal_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-#ifdef TAAL_USE_ESD_CHECK
-	queue_delayed_work(td->esd_wq, &td->esd_work, TAAL_ESD_CHECK_PERIOD);
-#endif
+	if (panel_data->use_esd_check)
+		queue_delayed_work(td->esd_wq, &td->esd_work,
+				TAAL_ESD_CHECK_PERIOD);
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -886,6 +886,7 @@ err:
 static int taal_resume(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "resume\n");
@@ -907,10 +908,9 @@ static int taal_resume(struct omap_dss_device *dssdev)
 		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 	} else {
 		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-#ifdef TAAL_USE_ESD_CHECK
-		queue_delayed_work(td->esd_wq, &td->esd_work,
-				TAAL_ESD_CHECK_PERIOD);
-#endif
+		if (panel_data->use_esd_check)
+			queue_delayed_work(td->esd_wq, &td->esd_work,
+					TAAL_ESD_CHECK_PERIOD);
 	}
 
 	mutex_unlock(&td->lock);
-- 
1.6.5.2

