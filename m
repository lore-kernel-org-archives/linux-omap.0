From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 1/2] ASoC: davinci-mcasp: Add dependecy to SND_DAVINCI_SOC or SND_OMAP_SOC
Date: Fri, 13 Jun 2014 12:49:59 +0300
Message-ID: <d2504eb8a058681b7ef67f6c41da020c4d1b1bed.1402652359.git.jsarha@ti.com>
References: <cover.1402652359.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54380 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbaFMJuM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2014 05:50:12 -0400
In-Reply-To: <cover.1402652359.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Fixes build with SND_DAVINCI_SOC or SND_OMAP_SOC alone and adds build
dependecy to SND_DAVINCI_SOC or SND_OMAP_SOC.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/Kconfig         |    1 +
 sound/soc/davinci/davinci-mcasp.c |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 50a0987..fdbb16f 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -6,6 +6,7 @@ config SND_DAVINCI_SOC_I2S
 	tristate
 
 config SND_DAVINCI_SOC_MCASP
+	depends on SND_DAVINCI_SOC || SND_OMAP_SOC
 	tristate
 
 config SND_DAVINCI_SOC_VCIF
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 9afb146..0ee4986 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1223,14 +1223,22 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 
 	switch (mcasp->version) {
+#if IS_BUILTIN(CONFIG_SND_DAVINCI_SOC) || \
+	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
+	 IS_MODULE(CONFIG_SND_DAVINCI_SOC))
 	case MCASP_VERSION_1:
 	case MCASP_VERSION_2:
 	case MCASP_VERSION_3:
 		ret = davinci_soc_platform_register(&pdev->dev);
 		break;
+#endif
+#if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
+	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
+	 IS_MODULE(CONFIG_SND_OMAP_SOC))
 	case MCASP_VERSION_4:
 		ret = omap_pcm_platform_register(&pdev->dev);
 		break;
+#endif
 	default:
 		dev_err(&pdev->dev, "Invalid McASP version: %d\n",
 			mcasp->version);
-- 
1.7.9.5

