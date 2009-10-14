From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 09/17] OMAP7XX: McBSP: Add omap850 support
Date: Wed, 14 Oct 2009 20:51:16 +0100
Message-ID: <3d374d00910141251j322d7042nf045d1da4002cbd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch is part of a series which unifies all duplicated code between
omap730 and omap850. All cpu checks are converted to cpu_is_omap7xx() and
CONFIG_ARCH_OMAP850 is added to all CONFIG_ARCH_OMAP730 checks.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/mcbsp.c             |    6 +++---
 arch/arm/plat-omap/include/mach/mcbsp.h |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index 505d98c..06f380b 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -79,7 +79,7 @@ static struct omap_mcbsp_ops omap1_mcbsp_ops = {
 	.free		= omap1_mcbsp_free,
 };

-#ifdef CONFIG_ARCH_OMAP730
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 static struct omap_mcbsp_platform_data omap730_mcbsp_pdata[] = {
 	{
 		.phys_base	= OMAP730_MCBSP1_BASE,
@@ -172,7 +172,7 @@ static struct omap_mcbsp_platform_data
omap16xx_mcbsp_pdata[] = {

 int __init omap1_mcbsp_init(void)
 {
-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		omap_mcbsp_count = OMAP730_MCBSP_PDATA_SZ;
 	if (cpu_is_omap15xx())
 		omap_mcbsp_count = OMAP15XX_MCBSP_PDATA_SZ;
@@ -184,7 +184,7 @@ int __init omap1_mcbsp_init(void)
 	if (!mcbsp_ptr)
 		return -ENOMEM;

-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		omap_mcbsp_register_board_cfg(omap730_mcbsp_pdata,
 						OMAP730_MCBSP_PDATA_SZ);

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h
b/arch/arm/plat-omap/include/mach/mcbsp.h
index e0d6eca..0b476b9 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -58,7 +58,7 @@
 #define OMAP44XX_MCBSP3_BASE	0x49026000
 #define OMAP44XX_MCBSP4_BASE	0x48074000

-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) ||
defined(CONFIG_ARCH_OMAP730)
+#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) ||
defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)

 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02
-- 
1.6.5
