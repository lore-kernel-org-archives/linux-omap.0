From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ASoC: omap-mcbsp: Use sysfs_match_string()
	helper
Date: Fri,  9 Jun 2017 15:06:54 +0300
Message-ID: <20170609120654.21809-1-andriy.shevchenko@linux.intel.com>
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
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Use sysfs_match_string() helper instead of open coded variant.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/omap/mcbsp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 06fec5699cc8..7a54e3083203 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -835,15 +835,11 @@ static ssize_t dma_op_mode_store(struct device *dev,
 				const char *buf, size_t size)
 {
 	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
-	const char * const *s;
-	int i = 0;
-
-	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++)
-		if (sysfs_streq(buf, *s))
-			break;
+	int i;
 
-	if (i == ARRAY_SIZE(dma_op_modes))
-		return -EINVAL;
+	i = sysfs_match_string(dma_op_modes, buf);
+	if (i < 0)
+		return i;
 
 	spin_lock_irq(&mcbsp->lock);
 	if (!mcbsp->free) {
-- 
2.11.0
