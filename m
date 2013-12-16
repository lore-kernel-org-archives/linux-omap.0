From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 10/27] OMAPDSS: Add DT support to HDMI
Date: Mon, 16 Dec 2013 16:56:17 +0200
Message-ID: <1387205794-32246-11-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55720 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab3LPO6O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:14 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 16e598787522..97dd05f602f7 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -671,6 +671,11 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 	.runtime_resume = hdmi_runtime_resume,
 };
 
+static const struct of_device_id hdmi_of_match[] = {
+	{ .compatible = "ti,omap4-hdmi", },
+	{},
+};
+
 static struct platform_driver omapdss_hdmihw_driver = {
 	.probe		= omapdss_hdmihw_probe,
 	.remove         = __exit_p(omapdss_hdmihw_remove),
@@ -678,6 +683,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
+		.of_match_table = hdmi_of_match,
 	},
 };
 
-- 
1.8.3.2

