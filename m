From: Suman Anna via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH 1/2] ARM: OMAP2+: Plug in device_enable/idle ops for IOMMUs
Date: Mon, 26 Aug 2019 19:14:51 -0500
Message-ID: <20190827001452.31930-2-s-anna@ti.com>
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

The OMAP IOMMU driver requires the device_enable/idle platform
data ops on all the IOMMU devices to be able to enable and disable
the clocks after commit db8918f61d51 ("iommu/omap: streamline
enable/disable through runtime pm callbacks"). Plug in these
pdata ops for all the existing IOMMUs through pdata quirks to
maintain functionality.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 6c6f8fce854e..dbe8d9718f70 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -89,6 +89,8 @@ static struct iommu_platform_data omap3_iommu_pdata = {
 	.reset_name = "mmu",
 	.assert_reset = omap_device_assert_hardreset,
 	.deassert_reset = omap_device_deassert_hardreset,
+	.device_enable = omap_device_enable,
+	.device_idle = omap_device_idle,
 };
 
 static int omap3_sbc_t3730_twl_callback(struct device *dev,
@@ -424,6 +426,8 @@ static struct iommu_platform_data omap4_iommu_pdata = {
 	.reset_name = "mmu_cache",
 	.assert_reset = omap_device_assert_hardreset,
 	.deassert_reset = omap_device_deassert_hardreset,
+	.device_enable = omap_device_enable,
+	.device_idle = omap_device_idle,
 };
 #endif
 
-- 
2.22.0
