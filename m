From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH/RESEND #3 3/7] arm: omap: smartreflex: use dev_get_drvdata()
Date: Tue, 15 Nov 2011 10:46:01 +0200
Message-ID: <1321346765-16633-4-git-send-email-balbi@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1321346765-16633-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

When we need to fetch struct omap_sr on PM
handlers, there's no need to access platform_data.

Instead, we can use dev_get_drvdata(dev) like
other drivers do.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   51 ++++++------------------------------
 1 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 443591b..bb3bfc0 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1002,22 +1002,9 @@ err_free_devinfo:
 
 static int __devexit omap_sr_remove(struct platform_device *pdev)
 {
-	struct omap_sr_data *pdata = pdev->dev.platform_data;
-	struct omap_sr *sr_info;
+	struct omap_sr *sr_info = platform_get_drvdata(pdev);
 	struct resource *mem;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
 	if (sr_info->dbg_dir)
@@ -1034,20 +1021,10 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 
 static int omap_sr_suspend(struct device *dev)
 {
-	struct omap_sr_data *pdata;
-	struct omap_sr *sr_info;
+	struct omap_sr *sr_info = dev_get_drvdata(dev);
 
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_err(dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
-		return -EINVAL;
-	}
+	if (!sr_info)
+		return 0;
 
 	if (!sr_info->autocomp_active)
 		return 0;
@@ -1055,7 +1032,7 @@ static int omap_sr_suspend(struct device *dev)
 	if (sr_info->is_suspended)
 		return 0;
 
-	omap_sr_disable_reset_volt(pdata->voltdm);
+	omap_sr_disable_reset_volt(sr_info->voltdm);
 	sr_info->is_suspended = true;
 	/* Flag the same info to the other CPUs */
 	smp_wmb();
@@ -1065,20 +1042,10 @@ static int omap_sr_suspend(struct device *dev)
 
 static int omap_sr_resume(struct device *dev)
 {
-	struct omap_sr_data *pdata;
-	struct omap_sr *sr_info;
+	struct omap_sr *sr_info = dev_get_drvdata(dev);
 
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_err(dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(dev, "%s: omap_sr struct not found\n", __func__);
-		return -EINVAL;
-	}
+	if (!sr_info)
+		return 0;
 
 	if (!sr_info->autocomp_active)
 		return 0;
@@ -1089,7 +1056,7 @@ static int omap_sr_resume(struct device *dev)
 	sr_info->is_suspended = false;
 	/* Flag the same info to the other CPUs */
 	smp_wmb();
-	omap_sr_enable(pdata->voltdm);
+	omap_sr_enable(sr_info->voltdm);
 
 	return 0;
 }
-- 
1.7.8.rc0
