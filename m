From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ARM: OMAP: twl-common: Add helper function to register the omap-twl4030 audio driver
Date: Wed,  8 Aug 2012 12:54:08 +0300
Message-ID: <1344419650-5389-3-git-send-email-peter.ujfalusi@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41966 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752609Ab2HHJyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:54:33 -0400
Received: by obbun3 with SMTP id un3so1786886obb.27
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:54:32 -0700 (PDT)
In-Reply-To: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, devicetree-discuss@lists.ozlabs.org

Since several OMAP3 based boards will be using the unified simple audio
driver it is better to not have duplicated code in the board files for this
purpose.
Board files can call omap_twl4030_audio_init(); to set up the needed device
for the audio support.

For example:
omap_twl4030_audio_init("omap3beagle", 26000000);

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl-common.h |    2 ++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index d52be85..639ea02 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -522,3 +522,31 @@ void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 		pmic_data->v2v1 = &omap4_v2v1_idata;
 }
 #endif /* CONFIG_ARCH_OMAP4 */
+
+#if defined(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP_TWL4030_MODULE)
+#include <linux/platform_data/omap-twl4030.h>
+
+static struct omap_tw4030_pdata omap_twl4030_audio_data;
+
+static struct platform_device audio_device = {
+	.name		= "omap-twl4030",
+	.id		= -1,
+	.dev = {
+		.platform_data = &omap_twl4030_audio_data,
+	},
+};
+
+void __init omap_twl4030_audio_init(char *card_name, int codec_sysclk)
+{
+	omap_twl4030_audio_data.card_name = card_name;
+	omap_twl4030_audio_data.codec_sysclk = codec_sysclk;
+	platform_device_register(&audio_device);
+}
+
+#else /* SOC_OMAP_TWL4030 */
+void __init omap_twl4030_audio_init(char *card_name, int codec_sysclk)
+{
+	return;
+}
+#endif /* SOC_OMAP_TWL4030 */
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index de062c7..b774c19 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -60,4 +60,6 @@ void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 			   u32 pdata_flags, u32 regulators_flags);
 
+void omap_twl4030_audio_init(char *card_name, int codec_sysclk);
+
 #endif /* __OMAP_PMIC_COMMON__ */
-- 
1.7.8.6

