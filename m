From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 6/6] ASoC: omap: Remove OMAP_MUX dependency
	from Nokia N810 audio support
Date: Fri, 27 Apr 2018 11:17:15 +0300
Message-ID: <20180427081715.28791-7-peter.ujfalusi@ti.com>
References: <20180427081715.28791-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180427081715.28791-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@bitmer.com>

Commit e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code") removed
CONFIG_OMAP_MUX making impossible to build Nokia N810 audio support. Remove
this dependency so we can do at least build tests.

Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index ba56d71c3ca7..65864a60d0e2 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -42,7 +42,6 @@ config SND_OMAP_SOC_HDMI_AUDIO
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
-	depends on OMAP_MUX
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	help
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
