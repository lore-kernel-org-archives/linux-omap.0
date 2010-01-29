From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 1/1] ASoC: AM3517: ASoC driver not getting
	compiled
Date: Fri, 29 Jan 2010 15:49:22 +0530
Message-ID: <1264760362-25465-1-git-send-email-anuj.aggarwal@ti.com>
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
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Commit 761c9d45 (ASoC: Fix build of OMAP sound drivers) changes
CONFIG_MACH_OMAP3517EVM -> CONFIG_SND_OMAP_SOC_OMAP3517EVM in the
Makefile. Whereas the config option defined in Kconfig is
SND_OMAP_SOC_AM3517EVM. Because of this, ASoC driver for AM3517
was not getting compiled.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 3db8a6c..19283e5 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
-obj-$(CONFIG_SND_OMAP_SOC_OMAP3517EVM) += snd-soc-am3517evm.o
+obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
-- 
1.6.2.4
