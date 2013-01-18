From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/8] ARM: OMAP2+: twl-common: Add default twl4030 audio configuration
Date: Fri, 18 Jan 2013 15:31:51 +0100
Message-ID: <1358519516-13165-4-git-send-email-peter.ujfalusi@ti.com>
References: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60383 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756114Ab3AROcF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:32:05 -0500
In-Reply-To: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Select the most commonly used audio configuration on boards with twl4030
audio:
Headset, Handsfree output and Line in input

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/twl-common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index e49b40b..cd1cba8 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -528,7 +528,12 @@ void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 	defined(CONFIG_SND_OMAP_SOC_OMAP_TWL4030_MODULE)
 #include <linux/platform_data/omap-twl4030.h>
 
-static struct omap_tw4030_pdata omap_twl4030_audio_data;
+/* Commonly used configuration */
+static struct omap_tw4030_pdata omap_twl4030_audio_data = {
+	.has_hs		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+	.has_hf		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+	.has_linein	= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
+};
 
 static struct platform_device audio_device = {
 	.name		= "omap-twl4030",
-- 
1.8.1

