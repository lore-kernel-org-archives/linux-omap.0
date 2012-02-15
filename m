From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP: omap_device: Expose omap_device_{alloc,
 delete, register}
Date: Wed, 15 Feb 2012 10:28:23 -0800
Message-ID: <20120215182823.18884.59794.stgit@kaulin.local>
References: <20120215182355.18884.18682.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120215182355.18884.18682.stgit@kaulin.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ohad Ben-Cohen <ohad@wizery.com>

Expose omap_device_{alloc, delete, register} so we can use them outside
of omap_device.c.

This approach allows users, which need to manipulate an archdata member
of a device before it is registered, to do so. This is also useful
for users who have their devices created very early so they can be used
at ->reserve() time to reserve CMA memory.

The immediate use case for this is to set the private iommu archdata
member, which binds a device to its associated iommu controller.
This way, generic code will be able to attach omap devices to their
iommus, without calling any omap-specific API.

With this in hand, we can further clean the existing mainline OMAP iommu
driver and its mainline users, and focus on generic IOMMU approaches
for future users (rpmsg/remoteproc and the upcoming generic DMA API).

This patch is still considered an interim solution until DT fully materializes
for omap; at that point, this functionality will be removed as DT will
take care of creating the devices and configuring them correctly.

Tested on OMAP4 with a generic rpmsg/remoteproc that doesn't use any
omap-specific IOMMU API anymore.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/omap_device.h |    7 +++++++
 arch/arm/plat-omap/omap_device.c              |   13 +++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 51423d2..05f7615 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -100,6 +100,13 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
 					 struct omap_device_pm_latency *pm_lats,
 					 int pm_lats_cnt, int is_early_device);
 
+struct omap_device *omap_device_alloc(struct platform_device *pdev,
+				      struct omap_hwmod **ohs, int oh_cnt,
+				      struct omap_device_pm_latency *pm_lats,
+				      int pm_lats_cnt);
+void omap_device_delete(struct omap_device *od);
+int omap_device_register(struct platform_device *pdev);
+
 void __iomem *omap_device_get_rt_va(struct omap_device *od);
 struct device *omap_device_get_by_hwmod_name(const char *oh_name);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index e8d9869..f72fafc 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -97,14 +97,7 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
 
-static int omap_device_register(struct platform_device *pdev);
 static int omap_early_device_register(struct platform_device *pdev);
-static struct omap_device *omap_device_alloc(struct platform_device *pdev,
-				      struct omap_hwmod **ohs, int oh_cnt,
-				      struct omap_device_pm_latency *pm_lats,
-				      int pm_lats_cnt);
-static void omap_device_delete(struct omap_device *od);
-
 
 static struct omap_device_pm_latency omap_default_latency[] = {
 	{
@@ -509,7 +502,7 @@ static int omap_device_fill_resources(struct omap_device *od,
  *
  * Returns an struct omap_device pointer or ERR_PTR() on error;
  */
-static struct omap_device *omap_device_alloc(struct platform_device *pdev,
+struct omap_device *omap_device_alloc(struct platform_device *pdev,
 					struct omap_hwmod **ohs, int oh_cnt,
 					struct omap_device_pm_latency *pm_lats,
 					int pm_lats_cnt)
@@ -591,7 +584,7 @@ oda_exit1:
 	return ERR_PTR(ret);
 }
 
-static void omap_device_delete(struct omap_device *od)
+void omap_device_delete(struct omap_device *od)
 {
 	if (!od)
 		return;
@@ -817,7 +810,7 @@ static struct dev_pm_domain omap_device_pm_domain = {
  * platform_device_register() on the underlying platform_device.
  * Returns the return value of platform_device_register().
  */
-static int omap_device_register(struct platform_device *pdev)
+int omap_device_register(struct platform_device *pdev)
 {
 	pr_debug("omap_device: %s: registering\n", pdev->name);
