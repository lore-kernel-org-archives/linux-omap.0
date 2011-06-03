From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/27] OMAP: DSS2: Remove CONFIG_OMAP2_DSS_SLEEP_BEFORE_RESET
Date: Fri,  3 Jun 2011 13:00:24 +0300
Message-ID: <1307095237-14805-15-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40887 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753811Ab1FCKBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:30 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

CONFIG_OMAP2_DSS_SLEEP_BEFORE_RESET is used to avoid an unclear bug at
DSS reset time. The pm runtime will handle reset in the future, and this
code has to be removed. Hopefully we won't see this error anymore.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig |   12 ------------
 drivers/video/omap2/dss/dss.c   |   13 -------------
 2 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 6b3e2da..0d12524 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -117,18 +117,6 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
 	  Max FCK is 173MHz, so this doesn't work if your PCK
 	  is very high.
 
-config OMAP2_DSS_SLEEP_BEFORE_RESET
-	bool "Sleep 50ms before DSS reset"
-	default y
-	help
-	  For some unknown reason we may get SYNC_LOST errors from the display
-	  subsystem at initialization time if we don't sleep before resetting
-	  the DSS. See the source (dss.c) for more comments.
-
-	  However, 50ms is quite long time to sleep, and with some
-	  configurations the SYNC_LOST may never happen, so the sleep can
-	  be disabled here.
-
 config OMAP2_DSS_SLEEP_AFTER_VENC_RESET
 	bool "Sleep 20ms after VENC reset"
 	default y
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 951c849..a0e933a 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -1037,19 +1037,6 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	 * the kernel resets it */
 	omap_writel(omap_readl(0x48050440) & ~0x3, 0x48050440);
 
-#ifdef CONFIG_OMAP2_DSS_SLEEP_BEFORE_RESET
-	/* We need to wait here a bit, otherwise we sometimes start to
-	 * get synclost errors, and after that only power cycle will
-	 * restore DSS functionality. I have no idea why this happens.
-	 * And we have to wait _before_ resetting the DSS, but after
-	 * enabling clocks.
-	 *
-	 * This bug was at least present on OMAP3430. It's unknown
-	 * if it happens on OMAP2 or OMAP3630.
-	 */
-	msleep(50);
-#endif
-
 	_omap_dss_reset();
 
 	/* autoidle */
-- 
1.7.4.1

