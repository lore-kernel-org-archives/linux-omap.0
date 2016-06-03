From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 01/27] ARM: OMAP: rx51-video: Do not set TV connector_type
Date: Fri, 3 Jun 2016 13:52:55 +0300
Message-ID: <20160603105321.7980-2-peter.ujfalusi@ti.com>
References: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

OMAP_DSS_VENC_TYPE_COMPOSITE is 0. There is no need to explicitly set the
connector_type.
This change is needed for the omapdss header cleanup.

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
