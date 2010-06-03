From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [linux-dali PATCH 1/1] omap3isp: video: Fix isp_video_far_end to return the correct entity
Date: Thu,  3 Jun 2010 15:35:23 +0200
Message-ID: <1275572123-23516-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <201006031527.25644.laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.irobotique.be ([92.243.18.41]:51344 "EHLO
	perceval.irobotique.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab0FCNc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 09:32:59 -0400
In-Reply-To: <201006031527.25644.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: svarbanov@mm-sol.com
Cc: linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com

If the pipeline is misconfigured, the isp_video_far_end function could
return a wrong ISP video device. Fix this by ignoring ISP video devices
of the same type as the local end.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/video/isp/ispvideo.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

Running /root/corecam-tests/smoketests/* on RX-71:3110
v4l2t - V4L2 test program May 19 2010
RUNNING video0-1008x754-raw-capt ... PASSED
RUNNING video0-1008x754-raw-fr ... PASSED
RUNNING video0-1280x720-raw-capt ... PASSED
RUNNING video0-1280x720-raw-fr ... PASSED
RUNNING video0-1824x1360-raw-capt ... PASSED
RUNNING video0-1824x1360-raw-fr ... PASSED
RUNNING video0-1824x1364-raw-capt ... PASSED
RUNNING video0-1824x1364-raw-fr ... PASSED
RUNNING video0-2016x1508-raw-capt ... PASSED
RUNNING video0-2016x1508-raw-fr ... PASSED
RUNNING video0-2160x1216-raw-capt ... PASSED
RUNNING video0-2160x1216-raw-fr ... PASSED
RUNNING video0-4016x2242-raw-capt ... PASSED
RUNNING video0-4016x2242-raw-fr ... PASSED
RUNNING video0-4016x3016-raw-capt ... PASSED
RUNNING video0-4016x3016-raw-fr ... PASSED
RUNNING video0-eeprom ... PASSED
RUNNING video0-hires-raw ... PASSED
RUNNING video0-hires-yuv ... PASSED
RUNNING video0-modules ... PASSED
RUNNING video0-vga-raw ... PASSED
RUNNING video0-vga-yuv ... PASSED
RUNNING video1-modules ... PASSED
RUNNING video1-vga-raw ... PASSED
RUNNING video1-vga-yuv ... PASSED

passed 25/25 TESTS

diff --git a/drivers/media/video/isp/ispvideo.c b/drivers/media/video/isp/ispvideo.c
index 7ecd35a..36625d1 100644
--- a/drivers/media/video/isp/ispvideo.c
+++ b/drivers/media/video/isp/ispvideo.c
@@ -59,7 +59,7 @@ isp_video_far_end(struct isp_video *video)
 	struct media_entity_graph graph;
 	struct media_entity *entity = &video->video.entity;
 	struct media_device *mdev = entity->parent;
-	struct video_device *vdev = NULL;
+	struct isp_video *far_end = NULL;
 
 	mutex_lock(&mdev->graph_mutex);
 	media_entity_graph_walk_start(&graph, entity);
@@ -68,14 +68,18 @@ isp_video_far_end(struct isp_video *video)
 		if (entity == &video->video.entity)
 			continue;
 
-		if (entity->type == MEDIA_ENTITY_TYPE_NODE) {
-			vdev = media_entity_to_video_device(entity);
+		if (entity->type != MEDIA_ENTITY_TYPE_NODE)
+			continue;
+
+		far_end = to_isp_video(media_entity_to_video_device(entity));
+		if (far_end->type != video->type)
 			break;
-		}
+
+		far_end = NULL;
 	}
 
 	mutex_unlock(&mdev->graph_mutex);
-	return vdev ? to_isp_video(vdev) : NULL;
+	return far_end;
 }
 
 /*
-- 
1.6.4.4

