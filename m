From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] OMAP: McBSP: Use textual values in DMA
	operating mode sysfs files
Date: Sun, 23 Aug 2009 12:24:25 +0300
Message-ID: <1251019467-11677-2-git-send-email-jhnikula@gmail.com>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tony@atomide.com, Eduardo Valentin <eduardo.valentin@nokia.com>, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Use more descriptive than numerical value when showing and storing the
McBSP DMA operating mode. Show function is using similar syntax than e.g.
the led triggers so that all possible values for store function are
printed but with current value surrounded with square brackets.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   52 ++++++++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index b63a720..28e29b9 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1161,25 +1161,31 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
+static const char *dma_op_modes[] = {
+	"element", "threshold", "frame",
+};
+
 static ssize_t dma_op_mode_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
-	int dma_op_mode;
+	int dma_op_mode, i = 0;
+	ssize_t len = 0;
+	const char * const *s;
 
 	spin_lock_irq(&mcbsp->lock);
 	dma_op_mode = mcbsp->dma_op_mode;
 	spin_unlock_irq(&mcbsp->lock);
 
-	return sprintf(buf, "current mode: %d\n"
-			"possible mode values are:\n"
-			"%d - %s\n"
-			"%d - %s\n"
-			"%d - %s\n",
-			dma_op_mode,
-			MCBSP_DMA_MODE_ELEMENT, "element mode",
-			MCBSP_DMA_MODE_THRESHOLD, "threshold mode",
-			MCBSP_DMA_MODE_FRAME, "frame mode");
+	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++) {
+		if (dma_op_mode == i)
+			len += sprintf(buf + len, "[%s] ", *s);
+		else
+			len += sprintf(buf + len, "%s ", *s);
+	}
+	len += sprintf(len+buf, "\n");
+
+	return len;
 }
 
 static ssize_t dma_op_mode_store(struct device *dev,
@@ -1187,26 +1193,26 @@ static ssize_t dma_op_mode_store(struct device *dev,
 				const char *buf, size_t size)
 {
 	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
-	unsigned long val;
-	int status;
+	const char * const *s;
+	char *p;
+	int len, i = 0;
 
-	status = strict_strtoul(buf, 0, &val);
-	if (status)
-		return status;
+	p = memchr(buf, '\n', size);
+	len = p ? p - buf : size;
 
-	spin_lock_irq(&mcbsp->lock);
+	for (s = &dma_op_modes[i]; i < ARRAY_SIZE(dma_op_modes); s++, i++)
+		if (*s && len == strlen(*s) && !strncmp(buf, *s, len))
+			break;
 
+	if (i == ARRAY_SIZE(dma_op_modes))
+		return -EINVAL;
+
+	spin_lock_irq(&mcbsp->lock);
 	if (!mcbsp->free) {
 		size = -EBUSY;
 		goto unlock;
 	}
-
-	if (val > MCBSP_DMA_MODE_FRAME || val < MCBSP_DMA_MODE_ELEMENT) {
-		size = -EINVAL;
-		goto unlock;
-	}
-
-	mcbsp->dma_op_mode = val;
+	mcbsp->dma_op_mode = i;
 
 unlock:
 	spin_unlock_irq(&mcbsp->lock);
-- 
1.6.3.3
