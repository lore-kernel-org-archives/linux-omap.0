From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH V3 05/10] ARM: OMAP2+: SmartReflex: introduce a busy loop
 condition test macro
Date: Thu, 26 Apr 2012 23:10:36 +0530
Message-ID: <1335462041-4949-6-git-send-email-j-keerthy@ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: j-keerthy@ti.com, j-pihet@ti.com
List-Id: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Now that omap_test_timeout is only accessible from mach-omap2/,
introduce a similar function for SR.

This change makes the SmartReflex implementation ready for the move
to drivers/.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 ++++++------
 include/linux/power/smartreflex.h |   23 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d859277..acef08d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -289,9 +289,9 @@ static void sr_v1_disable(struct omap_sr *sr)
 	 * Wait for SR to be disabled.
 	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
 	 */
-	omap_test_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
-			ERRCONFIG_MCUDISACKINTST), SR_DISABLE_TIMEOUT,
-			timeout);
+	sr_test_cond_timeout((sr_read_reg(sr, ERRCONFIG_V1) &
+			     ERRCONFIG_MCUDISACKINTST), SR_DISABLE_TIMEOUT,
+			     timeout);
 
 	if (timeout >= SR_DISABLE_TIMEOUT)
 		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
@@ -334,9 +334,9 @@ static void sr_v2_disable(struct omap_sr *sr)
 	 * Wait for SR to be disabled.
 	 * wait until IRQSTATUS.MCUDISACKINTST = 1. Typical latency is 1us.
 	 */
-	omap_test_timeout((sr_read_reg(sr, IRQSTATUS) &
-			IRQSTATUS_MCUDISABLEACKINT), SR_DISABLE_TIMEOUT,
-			timeout);
+	sr_test_cond_timeout((sr_read_reg(sr, IRQSTATUS) &
+			     IRQSTATUS_MCUDISABLEACKINT), SR_DISABLE_TIMEOUT,
+			     timeout);
 
 	if (timeout >= SR_DISABLE_TIMEOUT)
 		dev_warn(&sr->pdev->dev, "%s: Smartreflex disable timedout\n",
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 884eaee..78b795e 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -22,7 +22,7 @@
 
 #include <linux/types.h>
 #include <linux/platform_device.h>
-
+#include <linux/delay.h>
 #include <plat/voltage.h>
 
 /*
@@ -168,6 +168,27 @@ struct omap_sr {
 };
 
 /**
+ * test_cond_timeout - busy-loop, testing a condition
+ * @cond: condition to test until it evaluates to true
+ * @timeout: maximum number of microseconds in the timeout
+ * @index: loop index (integer)
+ *
+ * Loop waiting for @cond to become true or until at least @timeout
+ * microseconds have passed.  To use, define some integer @index in the
+ * calling code.  After running, if @index == @timeout, then the loop has
+ * timed out.
+ *
+ * Copied from omap_test_timeout */
+#define sr_test_cond_timeout(cond, timeout, index)		\
+({								\
+	for (index = 0; index < timeout; index++) {		\
+		if (cond)					\
+			break;					\
+		udelay(1);					\
+	}							\
+})
+
+/**
  * struct omap_sr_pmic_data - Strucutre to be populated by pmic code to pass
  *				pmic specific info to smartreflex driver
  *
-- 
1.7.5.4
