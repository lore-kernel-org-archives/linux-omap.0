From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 03/13] iommu/omap: allow enable/disable even without pdata
Date: Fri, 28 Feb 2014 14:42:34 -0600
Message-ID: <1393620164-14633-4-git-send-email-s-anna@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1393620164-14633-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

When booting with a devicetree, no platform data is provided.
Do not prematurely exit iommu_enable() and iommu_disable() in
such a case.

Note: As OMAP do not yet has a proper reset controller driver,
IOMMUs requiring a reset signal should use pdata-quirks as a
transitional solution.

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 647e4ba..217952b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -146,13 +146,10 @@ static int iommu_enable(struct omap_iommu *obj)
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!pdata)
-		return -EINVAL;
-
 	if (!arch_iommu)
 		return -ENODEV;
 
-	if (pdata->deassert_reset) {
+	if (pdata && pdata->deassert_reset) {
 		err = pdata->deassert_reset(pdev, pdata->reset_name);
 		if (err) {
 			dev_err(obj->dev, "deassert_reset failed: %d\n", err);
@@ -172,14 +169,11 @@ static void iommu_disable(struct omap_iommu *obj)
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!pdata)
-		return;
-
 	arch_iommu->disable(obj);
 
 	pm_runtime_put_sync(obj->dev);
 
-	if (pdata->assert_reset)
+	if (pdata && pdata->assert_reset)
 		pdata->assert_reset(pdev, pdata->reset_name);
 }
 
-- 
1.9.0
