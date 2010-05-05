From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 17/21] OMAP: DSS2: Taal: Configure ESD check in DSI panel data
Date: Wed,  5 May 2010 17:27:37 +0300
Message-ID: <025c12267d4bd88e1f59d9e13aafec247fe3c730.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
 <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
 <61a89461654fe44174902f6e29b8acded7529b67.1273067195.git.ext-jani.1.nikula@nokia.com>
 <16a98ca1b45ba9b9bb30f23d242449c1d440df07.1273067195.git.ext-jani.1.nikula@nokia.com>
 <aa1e310d0d385db39b5d53ba4d3dcf02b7e2f47f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <0cfff2a3cbb4231b41b382caf8aab7c52f47b0d5.1273067195.git.ext-jani.1.nikula@nokia.com>
 <adb61d94ee2a25284f6bd3f55ec4213501cbe8e3.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4cb510ffbc3216e2a7dac16edaff5fb1980b3315.1273067195.git.ext-jani.1.nikula@nokia.com>
 <8665676eca5bbd3be35b63f7110f629e94a6babe.1273067195.git.ext-jani.1.nikula@nokia.com>
 <a4e7d90e0f036e227a29d94e28b7036c2f9d419b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <ca7ff2e5a165ca8488190520f1f75e6e37642d3b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <4f2a95d67d2b8004f4a2055681690920ebeb8e8f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <690ef5c45aee3fb87a40fa03039356f8238925dc.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65041 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab0EEO2O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:14 -0400
In-Reply-To: <690ef5c45aee3fb87a40fa03039356f8238925dc.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
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
index 538829b..9502a4d 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -62,7 +62,6 @@
 #define DCS_GET_ID2		0xdb
 #define DCS_GET_ID3		0xdc
 
-/* #define TAAL_USE_ESD_CHECK */
 #define TAAL_ESD_CHECK_PERIOD	msecs_to_jiffies(5000)
 
 static irqreturn_t taal_te_isr(int irq, void *data);
@@ -793,6 +792,7 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 static int taal_enable(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "enable\n");
@@ -813,9 +813,9 @@ static int taal_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-#ifdef TAAL_USE_ESD_CHECK
-	queue_delayed_work(td->esd_wq, &td->esd_work, TAAL_ESD_CHECK_PERIOD);
-#endif
+	if (panel_data->use_esd_check)
+		queue_delayed_work(td->esd_wq, &td->esd_work,
+				TAAL_ESD_CHECK_PERIOD);
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -885,6 +885,7 @@ err:
 static int taal_resume(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "resume\n");
@@ -906,10 +907,9 @@ static int taal_resume(struct omap_dss_device *dssdev)
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

