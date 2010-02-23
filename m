From: hvaibhav@ti.com
Subject: [PATCH-V1 02/10] tvp514x: add YUYV format support
Date: Tue, 23 Feb 2010 14:04:25 +0530
Message-ID: <1266914073-30135-3-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: linux-omap@vger.kernel.org, hverkuil@xs4all.nl, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/media/video/tvp514x.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/tvp514x.c b/drivers/media/video/tvp514x.c
index 26b4e71..08fe579 100644
--- a/drivers/media/video/tvp514x.c
+++ b/drivers/media/video/tvp514x.c
@@ -212,6 +212,13 @@ static const struct v4l2_fmtdesc tvp514x_fmt_list[] = {
 	 .description = "8-bit UYVY 4:2:2 Format",
 	 .pixelformat = V4L2_PIX_FMT_UYVY,
 	},
+	{
+	 .index = 1,
+	 .type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+	 .flags = 0,
+	 .description = "8-bit YUYV 4:2:2 Format",
+	 .pixelformat = V4L2_PIX_FMT_YUYV,
+	},
 };

 /**
--
1.6.2.4
