From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 4/4] OMAP: mcbsp - remove sysfs set for DMA op mode.
Date: Tue, 18 May 2010 21:13:14 +0100
Message-ID: <1274213594-26554-5-git-send-email-lrg@slimlogic.co.uk>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:39291 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab0ERUNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 16:13:55 -0400
Received: by mail-ww0-f46.google.com with SMTP id 22so61884wwb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 13:13:55 -0700 (PDT)
In-Reply-To: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>

The mcbsp DMA op mode is tightly integrated with the
mcbsp client driver operation and hence is unsuitable
for userspace configuration via sysfs.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/plat-omap/mcbsp.c |   30 +-----------------------------
 1 files changed, 1 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 7785050..b7b8b5e 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1546,35 +1546,7 @@ static ssize_t dma_op_mode_show(struct device *dev,
 	return len;
 }
 
-static ssize_t dma_op_mode_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t size)
-{
-	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
-	const char * const *s;
-	int i = 0;
-
-	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++)
-		if (sysfs_streq(buf, *s))
-			break;
-
-	if (i == ARRAY_SIZE(dma_op_modes))
-		return -EINVAL;
-
-	spin_lock_irq(&mcbsp->lock);
-	if (!mcbsp->free) {
-		size = -EBUSY;
-		goto unlock;
-	}
-	mcbsp->dma_op_mode = i;
-
-unlock:
-	spin_unlock_irq(&mcbsp->lock);
-
-	return size;
-}
-
-static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, dma_op_mode_store);
+static DEVICE_ATTR(dma_op_mode, 0644, dma_op_mode_show, NULL);
 
 static ssize_t st_taps_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
-- 
1.7.0.4

