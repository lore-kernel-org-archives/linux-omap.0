From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 26/33] drivers/video/omap2/dss: don't check resource with devm_ioremap_resource
Date: Thu, 16 May 2013 13:15:54 +0200
Message-ID: <1368702961-4325-27-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/video/omap2/dss/hdmi.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 17f4d55..a109934 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1065,10 +1065,6 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	mutex_init(&hdmi.ip_data.lock);
 
 	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		DSSERR("can't get IORESOURCE_MEM HDMI\n");
-		return -EINVAL;
-	}
 
 	/* Base address taken from platform */
 	hdmi.ip_data.base_wp = devm_ioremap_resource(&pdev->dev, res);
-- 
1.7.10.4
