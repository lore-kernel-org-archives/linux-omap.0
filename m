From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH] omap: dss: connector-analog-tv: Add missing module device table
Date: Mon, 27 Oct 2014 21:24:03 +0100
Message-ID: <1414441443-10224-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com
Cc: hns@goldelico.com, marek@goldelico.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Without that fix connector-analog-tv driver isn't probed when compiled
as module.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
index 5ee3b55..d29cf72 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
@@ -301,6 +301,8 @@ static const struct of_device_id tvc_of_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, tvc_of_match);
+
 static struct platform_driver tvc_connector_driver = {
 	.probe	= tvc_probe,
 	.remove	= __exit_p(tvc_remove),
-- 
1.9.1
