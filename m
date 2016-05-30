From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v1 12/14] ASoC: omap-mcpdm: Move the WD enable write inside omap_mcpdm_open_streams()
Date: Mon, 30 May 2016 11:55:20 +0300
Message-ID: <20160530085522.30398-13-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The DS4_WD_EN bit is only touched before calling omap_mcpdm_open_streams().
Move it inside of that function for simplicity.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index b837265ac3e9..11bd07cdce22 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -173,6 +173,10 @@ static inline int omap_mcpdm_active(struct omap_mcpdm *mcpdm)
  */
 static void omap_mcpdm_open_streams(struct omap_mcpdm *mcpdm)
 {
+	u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+
+	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl | MCPDM_WD_EN);
+
 	omap_mcpdm_write(mcpdm, MCPDM_REG_IRQENABLE_SET,
 			MCPDM_DN_IRQ_EMPTY | MCPDM_DN_IRQ_FULL |
 			MCPDM_UP_IRQ_EMPTY | MCPDM_UP_IRQ_FULL);
@@ -258,12 +262,9 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 
 	mutex_lock(&mcpdm->mutex);
 
-	if (!dai->active) {
-		u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
-
-		omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl | MCPDM_WD_EN);
+	if (!dai->active)
 		omap_mcpdm_open_streams(mcpdm);
-	}
+
 	mutex_unlock(&mcpdm->mutex);
 
 	return 0;
-- 
2.8.3
