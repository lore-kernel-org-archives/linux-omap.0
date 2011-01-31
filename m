From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] video: omap24xxcam: Fix compilation
Date: Mon, 31 Jan 2011 13:16:09 +0100
Message-ID: <1296476169-10862-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add linux/sched.h because of missing declaration of TASK_NORMAL.

This patch fixes the following error:

drivers/media/video/omap24xxcam.c: In function
'omap24xxcam_vbq_complete':
drivers/media/video/omap24xxcam.c:415: error: 'TASK_NORMAL' undeclared
(first use in this function)
drivers/media/video/omap24xxcam.c:415: error: (Each undeclared
identifier is reported only once
drivers/media/video/omap24xxcam.c:415: error: for each function it
appears in.)

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/media/video/omap24xxcam.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/omap24xxcam.c b/drivers/media/video/omap24xxcam.c
index 0175527..f6626e8 100644
--- a/drivers/media/video/omap24xxcam.c
+++ b/drivers/media/video/omap24xxcam.c
@@ -36,6 +36,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 
 #include <media/v4l2-common.h>
 #include <media/v4l2-ioctl.h>
-- 
1.7.4.rc3
