From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 5/7] ASoC: omap-mcbsp: Rename omap_mcbsp_sysfs_remove() to omap_mcbsp_cleanup()
Date: Wed, 25 May 2016 17:20:59 +0300
Message-ID: <1464186061-28639-6-git-send-email-peter.ujfalusi@ti.com>
References: <1464186061-28639-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464186061-28639-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, jarkko.nikula@bitmer.com, paul@pwsan.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The function will do more then removing the sysfs files in the future.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/mcbsp.c      | 2 +-
 sound/soc/omap/mcbsp.h      | 2 +-
 sound/soc/omap/omap-mcbsp.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index c7563e230c7d..75cd1761d383 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -1080,7 +1080,7 @@ err_thres:
 	return ret;
 }
 
-void omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp)
+void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp)
 {
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 96d1b086bcf8..ce6cbbf923a4 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -349,6 +349,6 @@ int omap_st_disable(struct omap_mcbsp *mcbsp);
 int omap_st_is_enabled(struct omap_mcbsp *mcbsp);
 
 int omap_mcbsp_init(struct platform_device *pdev);
-void omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp);
+void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp);
 
 #endif /* __ASOC_MCBSP_H */
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index fd99d89de6a8..db07debb4a9c 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -832,7 +832,7 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 	if (mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id);
 
-	omap_mcbsp_sysfs_remove(mcbsp);
+	omap_mcbsp_cleanup(mcbsp);
 
 	clk_put(mcbsp->fclk);
 
-- 
2.8.2
