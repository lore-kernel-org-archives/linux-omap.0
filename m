From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC/PATCH v3 3/7] v4l: Add subdev sensor g_skip_frames operation
Date: Thu, 25 Nov 2010 03:54:34 +0100
Message-ID: <1290653678-15556-4-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53697 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668Ab0KYCyc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 21:54:32 -0500
In-Reply-To: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sakari.ailus@maxwell.research.nokia.com

Some buggy sensors generate corrupt frames when the stream is started.
This new operation return the number of corrupt frames to skip when
starting the stream.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/media/v4l2-subdev.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 4704a0a..356d16475e 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -343,9 +343,13 @@ struct v4l2_subdev_vbi_ops {
  *		      This is needed for some sensors, which always corrupt
  *		      several top lines of the output image, or which send their
  *		      metadata in them.
+ * @g_skip_frames: number of frames to skip at stream start. This is needed for
+ *		   buggy sensors that generate faulty frames when they are
+ *		   turned on.
  */
 struct v4l2_subdev_sensor_ops {
 	int (*g_skip_top_lines)(struct v4l2_subdev *sd, u32 *lines);
+	int (*g_skip_frames)(struct v4l2_subdev *sd, u32 *frames);
 };
 
 /*
-- 
1.7.2.2

