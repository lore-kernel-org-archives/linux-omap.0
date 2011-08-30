From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: tpa6130a2: Remove model_id from
	platform data
Date: Tue, 30 Aug 2011 14:39:54 +0300
Message-ID: <1314704394-31298-4-git-send-email-peter.ujfalusi@ti.com>
References: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1314704394-31298-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

The model_id is no longer needed within the platform_data
for the TPA driver since the model of TPA specified
with the device name (tpa6130a2/tpa6140a2).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/tpa6130a2-plat.h |    6 ------
 sound/soc/codecs/tpa6130a2.c   |    5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/sound/tpa6130a2-plat.h b/include/sound/tpa6130a2-plat.h
index 89beccb..4cc1093 100644
--- a/include/sound/tpa6130a2-plat.h
+++ b/include/sound/tpa6130a2-plat.h
@@ -23,13 +23,7 @@
 #ifndef TPA6130A2_PLAT_H
 #define TPA6130A2_PLAT_H
 
-enum tpa_model {
-	TPA6130A2,
-	TPA6140A2,
-};
-
 struct tpa6130a2_platform_data {
-	enum tpa_model id;
 	int power_gpio;
 };
 
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 0c0fcb3..f37a02b 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -33,6 +33,11 @@
 
 #include "tpa6130a2.h"
 
+enum tpa_model {
+	TPA6130A2,
+	TPA6140A2,
+};
+
 static struct i2c_client *tpa6130a2_client;
 
 /* This struct is used to save the context */
-- 
1.7.6.1
