From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] ASoC: OMAP: enable Overo driver for CM-T35
Date: Mon, 16 Nov 2009 15:53:23 +0200
Message-ID: <1258379603-29089-1-git-send-email-mike@compulab.co.il>
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
To: broonie@opensource.wolfsonmicro.com
Cc: linux-omap@vger.kernel.org, steve@sakoman.com, alsa-devel@alsa-project.org, Mike Rapoport <mike@compulab.co.il>, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 sound/soc/omap/Kconfig |    7 ++++---
 sound/soc/omap/overo.c |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 653a362..bb42681 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -43,12 +43,13 @@ config SND_OMAP_SOC_OSK5912
 	  Say Y if you want to add support for SoC audio on osk5912.
 
 config SND_OMAP_SOC_OVERO
-	tristate "SoC Audio support for Gumstix Overo"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OVERO
+	tristate "SoC Audio support for Gumstix Overo and CompuLab CM-T35"
+	depends on TWL4030_CORE && SND_OMAP_SOC && (MACH_OVERO || MACH_CM_T35)
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
-	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
+	  Say Y if you want to add support for SoC audio on the
+	  Gumstix Overo or CompuLab CM-T35
 
 config SND_OMAP_SOC_OMAP2EVM
 	tristate "SoC Audio support for OMAP2EVM board"
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index 624f40e..1bf440b 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -107,7 +107,7 @@ static int __init overo_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_overo()) {
+	if (!(machine_is_overo() || machine_is_cm_t35())) {
 		pr_debug("Not Overo!\n");
 		return -ENODEV;
 	}
-- 
1.6.4.4
