From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] omap3isp: Don't include <plat/cpu.h>
Date: Thu,  3 Jan 2013 22:23:24 +0100
Message-ID: <1357248204-9863-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@iki.fi>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

The plat/*.h headers are not available to drivers in multiplatform
kernels. As the header isn't needed, just remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/omap3isp/isp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 50cea08..07eea5b 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -71,8 +71,6 @@
 #include <media/v4l2-common.h>
 #include <media/v4l2-device.h>
 
-#include <plat/cpu.h>
-
 #include "isp.h"
 #include "ispreg.h"
 #include "ispccdc.h"
-- 
Regards,

Laurent Pinchart
