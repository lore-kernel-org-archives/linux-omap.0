From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 09/14] OMAPDSS: Kconfig: Update
	OMAP5_DSS_HDMI_AUDIO option
Date: Fri, 8 Aug 2014 16:23:50 +0300
Message-ID: <7c6c5be0fd1df38f8b28e82f24f9cc012fa32b40.1407503813.git.jsarha@ti.com>
References: <cover.1407503813.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: liam.r.girdwood@linux.intel.com, detheridge@ti.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com
List-Id: linux-omap@vger.kernel.org

Add help section to OMAP5_DSS_HDMI_AUDIO with dependency to
OMAP5_DSS_HDMI and select for OMAP_DSS_HDMI_AUDIO.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 701164a..abd2e92 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -103,8 +103,17 @@ config OMAP5_DSS_HDMI
 	  specification.
 
 config OMAP5_DSS_HDMI_AUDIO
+	bool "HDMI audio support for OMAP5"
 	depends on OMAP5_DSS_HDMI
-	bool
+	depends on SND_SOC=y || OMAP2_DSS = SND_SOC
+	select OMAP_DSS_HDMI_AUDIO
+	default y
+	help
+	  HDMI audio support for OMAP5 based SoCs. Adds integrated
+	  ASoC Digital Audio Interface component driver into OMAPDSS
+	  module. If enabled OMAP2_DSS selects SND_OMAP_SOC,
+	  SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD for full HDMI
+	  audio support.
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-- 
1.7.9.5
