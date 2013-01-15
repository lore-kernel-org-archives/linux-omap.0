From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 10/12] video: da8xx-fb: ensure pdata only for non-dt
Date: Tue, 15 Jan 2013 19:13:07 +0530
Message-ID: <5ffb4ab8d7f0698e4235cf6b85f2f096c5256f04.1358251448.git.afzal@ti.com>
References: <cover.1358251447.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1358251447.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This driver is DT probe-able, hence ensure presence of platform data
only for non-DT boot.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c |    2 +-
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
1.7.9.5
