From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 8/9] ARM: OMAP2+: McBSP: Do not create legacy devices when booting with DT data
Date: Mon, 13 Aug 2012 17:22:47 +0300
Message-ID: <1344867768-26335-9-git-send-email-peter.ujfalusi@ti.com>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:38978 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752225Ab2HMOW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 10:22:58 -0400
Received: by obbwc18 with SMTP id wc18so12515528obb.1
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 07:22:57 -0700 (PDT)
In-Reply-To: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Only create the devices in a legacy way if we do not have the DT data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 660e00b..d57a357 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -113,7 +114,8 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 
 static int __init omap2_mcbsp_init(void)
 {
-	omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
+	if (!of_have_populated_dt())
+		omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
 
 	return 0;
 }
-- 
1.7.8.6

