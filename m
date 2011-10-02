From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 20/30] media/omap_vout: disable driver for now
Date: Sun,  2 Oct 2011 16:45:50 +0200
Message-ID: <1317566760-25681-21-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@infradead.org>, Archit Taneja <archit@ti.com>, Amber Jain <amber@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

This driver was broken by 8cff88c5d "OMAP: DSS2: remove update_mode
from omapdss":

/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c: In function 'omap_vout_probe':
/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c:2202:15: error: 'struct omap_dss_driver' has no member
named 'set_update_mode'
/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c:2203:12: error: 'struct omap_dss_driver' has no member
named 'set_update_mode'
/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c:2204:8: error: 'OMAP_DSS_UPDATE_MANUAL' undeclared (first
use in this function)
/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c:2204:8: note: each undeclared identifier is reported only
once for each function it appears in
/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c:2206:15: error: 'struct omap_dss_driver' has no member
named 'set_update_mode'
/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c:2207:12: error: 'struct omap_dss_driver' has no member
named 'set_update_mode'
/home/arnd/linux-arm/drivers/media/video/omap/omap_vout.c:2208:8: error: 'OMAP_DSS_UPDATE_AUTO' undeclared (first use
in this function)
make[3]: *** [drivers/media/video/omap/omap_vout.o] Error 1
make[2]: *** [drivers/media/video/omap] Error 2
make[1]: *** [drivers/media/video/] Error 2
make: *** [sub-make] Error 2

Let's disable it for now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Archit Taneja <archit@ti.com>
Cc: Amber Jain <amber@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/media/video/omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/omap/Kconfig
index 390ab09..ee21f36 100644
--- a/drivers/media/video/omap/Kconfig
+++ b/drivers/media/video/omap/Kconfig
@@ -4,6 +4,7 @@ config VIDEO_OMAP2_VOUT_VRFB
 config VIDEO_OMAP2_VOUT
 	tristate "OMAP2/OMAP3 V4L2-Display driver"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on BROKEN # broken by 8cff88c5da "OMAP: DSS2: remove update_mode from omapdss"
 	select VIDEOBUF_GEN
 	select VIDEOBUF_DMA_CONTIG
 	select OMAP2_DSS
-- 
1.7.5.4
