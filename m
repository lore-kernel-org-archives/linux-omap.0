From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAPFB: cannot parse default modes
Date: Thu, 04 Mar 2010 17:58:01 +0200
Message-ID: <1267718281.25148.41.camel@tubuntu.research.nokia.com>
References: <70c9a9111003040725j63355a27j38e3f7b07e7ba43a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ktOwlIJtgi9JmQlzIoWA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62589 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0CDP6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 10:58:25 -0500
In-Reply-To: <70c9a9111003040725j63355a27j38e3f7b07e7ba43a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Enric =?ISO-8859-1?Q?Balletb=F2?= i Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--=-ktOwlIJtgi9JmQlzIoWA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2010-03-04 at 16:25 +0100, ext Enric Balletbò i Serra wrote:
> Hello,
> 
> Testing the Linux Omap master branch on IGEP v2 board I get this feature
> 
> [   17.565155] omapfb omapfb: cannot parse default modes
> 
> My kernel command line is something like  '..
> omapfb.mode=dvi:1280x720MR-24@60' which works without problems with
> latest 2.6.33-rc8. Any idea about this ? There is something different
> between 2.6.33 and 2.633-rc8 ? I'm missing something ?

There's no difference between the tagged 2.6.33-rc8 and 2.6.33. But in
the current merge window there went a big bunch of DSS patches in, and
you are right, setting modes doesn't work in git HEAD.

There's some code missing related to mode setting, and it needs some
thinking how to make it properly. But here's a quick hack patch I made,
that makes mode setting work at least for me on 3430SDP.

 Tomi


--=-ktOwlIJtgi9JmQlzIoWA
Content-Disposition: attachment; filename="0001-hack-for-set-mode.patch"
Content-Type: text/x-patch; name="0001-hack-for-set-mode.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From cfd210495c3f42c700f569f722818c52c6dfc7c3 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Thu, 4 Mar 2010 17:52:43 +0200
Subject: [PATCH] hack for set mode

---
 drivers/video/omap2/displays/panel-generic.c |   33 ++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
index c59e4ba..57c3a26 100644
--- a/drivers/video/omap2/displays/panel-generic.c
+++ b/drivers/video/omap2/displays/panel-generic.c
@@ -116,6 +116,35 @@ static int generic_panel_resume(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+static void generic_panel_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	int r;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		omapdss_dpi_display_disable(dssdev);
+
+	dssdev->panel.timings = *timings;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		r = omapdss_dpi_display_enable(dssdev);
+		if (r)
+			printk("enable failed\n");
+	}
+}
+
+static void generic_panel_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static int generic_panel_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	return 0;
+}
+
 static struct omap_dss_driver generic_driver = {
 	.probe		= generic_panel_probe,
 	.remove		= generic_panel_remove,
@@ -125,6 +154,10 @@ static struct omap_dss_driver generic_driver = {
 	.suspend	= generic_panel_suspend,
 	.resume		= generic_panel_resume,
 
+	.set_timings	= generic_panel_set_timings,
+	.get_timings	= generic_panel_get_timings,
+	.check_timings	= generic_panel_check_timings,
+
 	.driver         = {
 		.name   = "generic_panel",
 		.owner  = THIS_MODULE,
-- 
1.6.5


--=-ktOwlIJtgi9JmQlzIoWA--

