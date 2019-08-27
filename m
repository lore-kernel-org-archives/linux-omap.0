From: Suman Anna via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH 2/2] ARM: OMAP2+: Add pdata for OMAP3 ISP IOMMU
Date: Mon, 26 Aug 2019 19:14:52 -0500
Message-ID: <20190827001452.31930-3-s-anna@ti.com>
References: <20190827001452.31930-1-s-anna@ti.com>
Reply-To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190827001452.31930-1-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The OMAP3 ISP IOMMU does not have any reset lines, so it didn't
need any pdata previously. The OMAP IOMMU driver now requires the
platform data ops for device_enable/idle on all the IOMMU devices
after commit db8918f61d51 ("iommu/omap: streamline enable/disable
through runtime pm callbacks") to enable/disable the clocks properly
and maintain the reference count and the omap_hwmod state machine.
So, add these callbacks through iommu pdata quirks for the OMAP3
ISP IOMMU.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index dbe8d9718f70..3d597fb962e9 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -93,6 +93,11 @@ static struct iommu_platform_data omap3_iommu_pdata = {
 	.device_idle = omap_device_idle,
 };
 
+static struct iommu_platform_data omap3_iommu_isp_pdata = {
+	.device_enable = omap_device_enable,
+	.device_idle = omap_device_idle,
+};
+
 static int omap3_sbc_t3730_twl_callback(struct device *dev,
 					   unsigned gpio,
 					   unsigned ngpio)
@@ -621,6 +626,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
 		       &omap3_iommu_pdata),
+	OF_DEV_AUXDATA("ti,omap2-iommu", 0x480bd400, "480bd400.mmu",
+		       &omap3_iommu_isp_pdata),
 	OF_DEV_AUXDATA("ti,omap3-smartreflex-core", 0x480cb000,
 		       "480cb000.smartreflex", &omap_sr_pdata[OMAP_SR_CORE]),
 	OF_DEV_AUXDATA("ti,omap3-smartreflex-mpu-iva", 0x480c9000,
-- 
2.22.0
