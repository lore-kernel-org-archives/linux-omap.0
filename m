From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/9] OMAP: DSS2: VENC: make 20ms venc bug-fix sleep optional
Date: Thu, 31 Mar 2011 13:11:01 +0300
Message-ID: <1301566266-11187-5-git-send-email-tomi.valkeinen@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:56672 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757218Ab1CaKLa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 06:11:30 -0400
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

There's a 20ms sleep after VENC reset. It's unknown what bug this
circumvents and on what platforms. Add a Kconfig option to disable the
sleep.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig |   12 ++++++++++++
 drivers/video/omap2/dss/venc.c  |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 458cfe1..5b45c0c 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -136,4 +136,16 @@ config OMAP2_DSS_SLEEP_BEFORE_RESET
 	  However, 50ms is quite long time to sleep, and with some
 	  configurations the SYNC_LOST may never happen, so the sleep can
 	  be disabled here.
+
+config OMAP2_DSS_SLEEP_AFTER_VENC_RESET
+	bool "Sleep 20ms after VENC reset"
+	default y
+	help
+	  There is a 20ms sleep after VENC reset which seemed to fix the
+	  reset. The reason for the bug is unclear, and it's also unclear
+	  on what platforms this happens.
+
+	  This option enables the sleep, and is enabled by default. You can
+	  disable the sleep if it doesn't cause problems on your platform.
+
 endif
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 8e35a5b..8c7af90 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -373,8 +373,11 @@ static void venc_reset(void)
 		}
 	}
 
+#ifdef CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET
 	/* the magical sleep that makes things work */
+	/* XXX more info? What bug this circumvents? */
 	msleep(20);
+#endif
 }
 
 static void venc_enable_clocks(int enable)
-- 
1.7.1

