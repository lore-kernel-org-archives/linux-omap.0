From: jean.pihet@newoldbits.com
Subject: [PATCH 6/9] ARM: OMAP2+: SmartReflex: introduce a busy loop condition
 test macro
Date: Mon, 19 Mar 2012 17:12:55 +0100
Message-ID: <1332173578-27422-7-git-send-email-j-pihet@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Now that omap_test_timeout is only accessible from mach-omap2/,
introduce a similar function for SR.

This change makes the SmartReflex implementation ready for the move
to drivers/.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 ++++++------
 arch/arm/mach-omap2/smartreflex.h |   23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index b2728a5..5f3faf3 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -290,9 +290,9 @@ static void sr_v1_disable(struct omap_sr *sr)
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
@@ -335,9 +335,9 @@ static void sr_v2_disable(struct omap_sr *sr)
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
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 6f9b677..a87bac1 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -21,6 +21,7 @@
 #define __ASM_ARM_OMAP_SMARTREFLEX_H
 
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <linux/power/smartreflex.h>
 
 #include <plat/voltage.h>
@@ -144,6 +145,28 @@
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
 
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
+ * Copied from omap_test_timeout
+ */
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
