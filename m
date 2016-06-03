From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 16/27] omapdss: omap-panel-data.h: Remove struct omap_dss_device declaration
Date: Fri, 3 Jun 2016 13:53:10 +0300
Message-ID: <20160603105321.7980-17-peter.ujfalusi@ti.com>
References: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The omap_dss_device is not needed by anything in the header file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/video/omap-panel-data.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index a64e9ba12b0d..7b4fadf82cd5 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -30,8 +30,6 @@
 #include <video/omapdss.h>
 #include <video/display_timing.h>
 
-struct omap_dss_device;
-
 /**
  * connector_atv platform data
  * @name: name for this display entity
-- 
2.8.3
