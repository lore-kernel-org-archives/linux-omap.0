From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 11/41] OMAPDSS: Add DT support to HDMI
Date: Tue, 21 Jan 2014 12:56:43 +0200
Message-ID: <1390301833-24944-12-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34844 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbaAUK7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 05:59:39 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT support to HDMI driver. The only thing needed for DT support here
is the of_match_table.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index 11e7500197c1..064bec4e08d4 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -682,6 +682,11 @@ static const struct dev_pm_ops hdmi_pm_ops = {
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
@@ -689,6 +694,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
+		.of_match_table = hdmi_of_match,
 	},
 };
 
-- 
1.8.3.2

