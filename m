From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ASoC: OMAP: mcbsp fixes for enabling ARM multiplatform
 support
Date: Wed, 21 Nov 2012 09:42:25 -0800
Message-ID: <20121121174225.25576.54891.stgit@muffinssi.local>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:63802 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751821Ab2KURme (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 12:42:34 -0500
In-Reply-To: <20121121174201.25576.61961.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

We cannot include any plat or mach headers for the multiplatform
support.

Fix the issue by defining local mcbsp_omap1().

cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
cc: Liam Girdwood <lrg@ti.com>
cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
cc: Jaroslav Kysela <perex@perex.cz>
cc: Takashi Iwai <tiwai@suse.de>
cc: alsa-devel@alsa-project.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/omap/mcbsp.c      |    4 +---
 sound/soc/omap/mcbsp.h      |    6 ++++++
 sound/soc/omap/omap-mcbsp.c |    5 ++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index afb8d4f..a9a2438 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -28,8 +28,6 @@
 
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include <plat/cpu.h>
-
 #include "mcbsp.h"
 
 static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
@@ -612,7 +610,7 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 	 * system will refuse to enter idle if the CLKS pin source is not reset
 	 * back to internal source.
 	 */
-	if (!cpu_class_is_omap1())
+	if (!mcbsp_omap1())
 		omap2_mcbsp_set_clks_src(mcbsp, MCBSP_CLKS_PRCM_SRC);
 
 	spin_lock(&mcbsp->lock);
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 49a6725..a89791c 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -26,6 +26,12 @@
 
 #include "omap-pcm.h"
 
+#ifdef CONFIG_ARCH_OMAP1
+#define mcbsp_omap1()	1
+#else
+#define mcbsp_omap1()	0
+#endif
+
 /* McBSP register numbers. Register address offset = num * reg_step */
 enum {
 	/* Common registers */
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a6ee157..0916760 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -34,7 +34,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include <plat/cpu.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
@@ -512,7 +511,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		regs->srgr2	|= CLKSM;
 		break;
 	case OMAP_MCBSP_SYSCLK_CLKS_FCLK:
-		if (cpu_class_is_omap1()) {
+		if (mcbsp_omap1()) {
 			err = -EINVAL;
 			break;
 		}
@@ -520,7 +519,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 					       MCBSP_CLKS_PRCM_SRC);
 		break;
 	case OMAP_MCBSP_SYSCLK_CLKS_EXT:
-		if (cpu_class_is_omap1()) {
+		if (mcbsp_omap1()) {
 			err = 0;
 			break;
 		}

