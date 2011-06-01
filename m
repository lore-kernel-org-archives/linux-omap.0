From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] media: omap3isp: fix a pontential NULL deref
Date: Wed,  1 Jun 2011 19:39:46 +0300
Message-ID: <1306946386-31869-1-git-send-email-ohad@wizery.com>
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>
List-Id: linux-omap@vger.kernel.org

Fix a potential NULL pointer dereference by skipping registration of
external entities in case none are provided.

This is useful at least when testing mere memory-to-memory scenarios.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/media/video/omap3isp/isp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/omap3isp/isp.c b/drivers/media/video/omap3isp/isp.c
index 2a5fbe6..367ced3 100644
--- a/drivers/media/video/omap3isp/isp.c
+++ b/drivers/media/video/omap3isp/isp.c
@@ -1756,7 +1756,7 @@ static int isp_register_entities(struct isp_device *isp)
 		goto done;
 
 	/* Register external entities */
-	for (subdevs = pdata->subdevs; subdevs->subdevs; ++subdevs) {
+	for (subdevs = pdata->subdevs; subdevs && subdevs->subdevs; ++subdevs) {
 		struct v4l2_subdev *sensor;
 		struct media_entity *input;
 		unsigned int flags;
-- 
1.7.1
