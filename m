From: Jane Wang <jwang@ti.com>
Subject: [PATCH 1/2] OMAP3: MCBSP: Suspend/resume failure fix
Date: Fri, 13 Nov 2009 11:39:47 -0600
Message-ID: <1258133987-20488-1-git-send-email-jwang@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, Jane Wang <jwang@ti.com>
List-Id: linux-omap@vger.kernel.org

McBSP fucntional clock is not disabled when suspend is triggerd which
prevents PER domain entering target low-power state. To fix the problem:

1. Disable/enable McBSP functional clock for suspend/resume.

2. In addition, reconfigure McBSP, this is needed when systerm comes out of OFF state.

Signed-off-by: Jane Wang <jwang@ti.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    2 ++
 arch/arm/plat-omap/mcbsp.c              |   27 +++++++++++++++++++++++++++
 sound/soc/omap/omap-mcbsp.c             |   14 ++++++++++++--
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index e0d6eca..94e1c66 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -440,6 +440,8 @@ static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
 #endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
+void omap_mcbsp_disable_fclk(unsigned int id);
+void omap_mcbsp_enable_fclk(unsigned int id);
 void omap_mcbsp_start(unsigned int id, int tx, int rx);
 void omap_mcbsp_stop(unsigned int id, int tx, int rx);
 void omap_mcbsp_xmit_word(unsigned int id, u32 word);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e664b91..bfe3c61 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -459,6 +459,33 @@ int omap_mcbsp_request(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_request);
 
+void omap_mcbsp_disable_fclk(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	clk_disable(mcbsp->fclk);
+}
+EXPORT_SYMBOL(omap_mcbsp_disable_fclk);
+
+
+void omap_mcbsp_enable_fclk(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	clk_enable(mcbsp->fclk);
+}
+EXPORT_SYMBOL(omap_mcbsp_enable_fclk);
+
 void omap_mcbsp_free(unsigned int id)
 {
 	struct omap_mcbsp *mcbsp;
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 45be942..e56b5ff 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -229,18 +229,28 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		mcbsp_data->active++;
 		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
 		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+		mcbsp_data->active++;
+		omap_mcbsp_enable_fclk(mcbsp_data->bus_id);
+		omap_mcbsp_config(mcbsp_data->bus_id,
+					&mcbsp_data->regs);
+		omap_mcbsp_start(mcbsp_data->bus_id, play, !play);
+		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		omap_mcbsp_stop(mcbsp_data->bus_id, play, !play);
 		mcbsp_data->active--;
 		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		omap_mcbsp_stop(mcbsp_data->bus_id, play, !play);
+		omap_mcbsp_disable_fclk(mcbsp_data->bus_id);
+		mcbsp_data->active--;
+		break;
 	default:
 		err = -EINVAL;
 	}
-- 
1.5.4.3
