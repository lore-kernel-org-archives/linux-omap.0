From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/26] ARM: OMAP: rx51-video: Do not set TV connector_type
Date: Mon, 30 May 2016 14:42:45 +0300
Message-ID: <20160530114258.30879-14-peter.ujfalusi@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

In legacy mode only composite type is supported by omapdss so there is no
need to specify the connector_type.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-rx51-video.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 9cfebc5c7455..b76f84245ad9 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -32,7 +32,6 @@
 static struct connector_atv_platform_data rx51_tv_pdata = {
 	.name = "tv",
 	.source = "venc.0",
-	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
 	.invert_polarity = false,
 };
 
-- 
2.8.3
