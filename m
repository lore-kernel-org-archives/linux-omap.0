From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v3 10/12] video: da8xx-fb: ensure pdata only for non-dt
Date: Tue, 22 Jan 2013 22:22:59 +0530
Message-ID: <4bd302e9c88c586323327eef990f354f994ea9c5.1358871750.git.afzal@ti.com>
References: <cover.1358871750.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1358871750.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-omap@vger.kernel.org

This driver is DT probe-able, hence ensure presence of platform data
only for non-DT boot.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 0c68712..1c1a616 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1303,7 +1303,7 @@ static int fb_probe(struct platform_device *device)
 	int ret;
 	unsigned long ulcm;
 
-	if (fb_pdata == NULL) {
+	if (fb_pdata == NULL && !device->dev.of_node) {
 		dev_err(&device->dev, "Can not get platform data\n");
 		return -ENOENT;
 	}
-- 
1.7.12
