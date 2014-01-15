From: Suman Anna <s-anna@ti.com>
Subject: [UPDATED PATCHv4 6/7] hwspinlock/omap: enable module before reading
 SYSSTATUS register
Date: Wed, 15 Jan 2014 17:36:48 -0600
Message-ID: <1389829008-31941-1-git-send-email-s-anna@ti.com>
References: <1389658764-39199-7-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389658764-39199-7-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The number of hwspinlocks are determined based on the value read
from the IP block's SYSSTATUS register. However, the module may
not be enabled and clocked, and the read may result in a bus error.

This particular issue is seen rather easily on AM33XX, since the
module wakeup is software controlled, and it is disabled out of
reset. Make sure the module is enabled and clocked before reading
the SYSSTATUS register.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 9f56fb2..7764291 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -101,10 +101,29 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!io_base)
 		return -ENOMEM;
 
+	/*
+	 * make sure the module is enabled and clocked before reading
+	 * the module SYSSTATUS register
+	 */
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		goto iounmap_base;
+	}
+
 	/* Determine number of locks */
 	i = readl(io_base + SYSSTATUS_OFFSET);
 	i >>= SPINLOCK_NUMLOCKS_BIT_OFFSET;
 
+	/*
+	 * runtime PM will make sure the clock of this module is
+	 * enabled again iff at least one lock is requested
+	 */
+	ret = pm_runtime_put_sync(&pdev->dev);
+	if (ret < 0)
+		goto iounmap_base;
+
 	/* one of the four lsb's must be set, and nothing else */
 	if (hweight_long(i & 0xf) != 1 || i > 8) {
 		ret = -EINVAL;
@@ -124,12 +143,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
 		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
-	/*
-	 * runtime PM will make sure the clock of this module is
-	 * enabled iff at least one lock is requested
-	 */
-	pm_runtime_enable(&pdev->dev);
-
 	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
 						base_id, num_locks);
 	if (ret)
@@ -138,9 +151,9 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	return 0;
 
 reg_fail:
-	pm_runtime_disable(&pdev->dev);
 	kfree(bank);
 iounmap_base:
+	pm_runtime_disable(&pdev->dev);
 	iounmap(io_base);
 	return ret;
 }
-- 
1.8.4.3
