From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/10] ARM: OMAP3: remove deprecated CONFIG_OMAP_IOMMU_IVA2
Date: Wed, 5 Mar 2014 18:24:10 -0600
Message-ID: <1394065459-16409-2-git-send-email-s-anna@ti.com>
References: <1394065459-16409-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394065459-16409-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>

CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
usage by tidspbridge and other iommu users. The same can be achieved
by marking the DT node disabled, so remove this obsolete flag and
the corresponding hwmod data can be enabled.

Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
[s-anna-l0cyMroinI0@public.gmane.org: revise commit log]
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Acked-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 8 --------
 arch/arm/plat-omap/Kconfig                 | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 4c3b1e6..81dd071 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3029,8 +3029,6 @@ static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-#ifdef CONFIG_OMAP_IOMMU_IVA2
-
 /* mmu iva */
 
 static struct omap_mmu_dev_attr mmu_iva_dev_attr = {
@@ -3082,8 +3080,6 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-#endif
-
 /* l4_per -> gpio4 */
 static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
 	{
@@ -3855,9 +3851,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__hdq1w,
 	&omap3xxx_sad2d__l3,
 	&omap3xxx_l4_core__mmu_isp,
-#ifdef CONFIG_OMAP_IOMMU_IVA2
 	&omap3xxx_l3_main__mmu_iva,
-#endif
 	&omap34xx_l4_core__ssi,
 	NULL
 };
@@ -3881,9 +3875,7 @@ static struct omap_hwmod_ocp_if *omap36xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__hdq1w,
 	&omap3xxx_sad2d__l3,
 	&omap3xxx_l4_core__mmu_isp,
-#ifdef CONFIG_OMAP_IOMMU_IVA2
 	&omap3xxx_l3_main__mmu_iva,
-#endif
 	NULL
 };
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 436ea97..02fc10d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -86,9 +86,6 @@ config OMAP_MUX_WARNINGS
 	  to change the pin multiplexing setup.	 When there are no warnings
 	  printed, it's safe to deselect OMAP_MUX for your product.
 
-config OMAP_IOMMU_IVA2
-	bool
-
 config OMAP_MPU_TIMER
 	bool "Use mpu timer"
 	depends on ARCH_OMAP1
-- 
1.9.0
