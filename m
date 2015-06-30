From: Nik Nyby <nikolas@gnu.org>
Subject: [PATCH] ASoC: omap: Fix typo in config option
	description
Date: Tue, 30 Jun 2015 17:03:18 -0400
Message-ID: <1435698198-9746-1-git-send-email-nikolas@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, trivial@kernel.org
Cc: Nik Nyby <nikolas@gnu.org>
List-Id: linux-omap@vger.kernel.org

This fixes a typo in the description for SND_OMAP_SOC_HDMI_AUDIO.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
---
 sound/soc/omap/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 30d0109..5185a38 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -24,7 +24,7 @@ config SND_OMAP_SOC_HDMI_AUDIO
 	  component also under DSS HDMI device. Dummy codec is used as
 	  as codec component. The hdmi audio driver implements also
 	  the card and registers it under its own platform device.
-	  The device for the dirver is registered by OMAPDSS hdmi
+	  The device for the driver is registered by OMAPDSS hdmi
 	  driver.
 
 config SND_OMAP_SOC_N810
-- 
2.1.4
