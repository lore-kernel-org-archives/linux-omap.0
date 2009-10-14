From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 03/17] OMAP7XX: IO: Remove duplicate omap850 code
Date: Wed, 14 Oct 2009 20:50:28 +0100
Message-ID: <3d374d00910141250o2338b9cdl14a80df488f55e27@mail.gmail.com>
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
 arch/arm/mach-omap1/io.c |   29 +++--------------------------
 arch/arm/plat-omap/io.c  |    2 +-
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 7030f92..19de57f 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -36,7 +36,7 @@ static struct map_desc omap_io_desc[] __initdata = {
 	}
 };

-#ifdef CONFIG_ARCH_OMAP730
+#if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
 static struct map_desc omap730_io_desc[] __initdata = {
 	{
 		.virtual	= OMAP730_DSP_BASE,
@@ -52,22 +52,6 @@ static struct map_desc omap730_io_desc[] __initdata = {
 };
 #endif

-#ifdef CONFIG_ARCH_OMAP850
-static struct map_desc omap850_io_desc[] __initdata = {
-	{
-		.virtual	= OMAP850_DSP_BASE,
-		.pfn		= __phys_to_pfn(OMAP850_DSP_START),
-		.length		= OMAP850_DSP_SIZE,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	= OMAP850_DSPREG_BASE,
-		.pfn		= __phys_to_pfn(OMAP850_DSPREG_START),
-		.length		= OMAP850_DSPREG_SIZE,
-		.type		= MT_DEVICE
-	}
-};
-#endif
-
 #ifdef CONFIG_ARCH_OMAP15XX
 static struct map_desc omap1510_io_desc[] __initdata = {
 	{
@@ -120,18 +104,11 @@ void __init omap1_map_common_io(void)
 	 */
 	omap_check_revision();

-#ifdef CONFIG_ARCH_OMAP730
-	if (cpu_is_omap730()) {
+#if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
+	if (cpu_is_omap7xx()) {
 		iotable_init(omap730_io_desc, ARRAY_SIZE(omap730_io_desc));
 	}
 #endif
-
-#ifdef CONFIG_ARCH_OMAP850
-	if (cpu_is_omap850()) {
-		iotable_init(omap850_io_desc, ARRAY_SIZE(omap850_io_desc));
-	}
-#endif
-
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap15xx()) {
 		iotable_init(omap1510_io_desc, ARRAY_SIZE(omap1510_io_desc));
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index b6defa2..388fd94 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -33,7 +33,7 @@ void __iomem *omap_ioremap(unsigned long p, size_t
size, unsigned int type)
 		if (BETWEEN(p, OMAP1_IO_PHYS, OMAP1_IO_SIZE))
 			return XLATE(p, OMAP1_IO_PHYS, OMAP1_IO_VIRT);
 	}
-	if (cpu_is_omap730()) {
+	if (cpu_is_omap7xx()) {
 		if (BETWEEN(p, OMAP730_DSP_BASE, OMAP730_DSP_SIZE))
 			return XLATE(p, OMAP730_DSP_BASE, OMAP730_DSP_START);

-- 
1.6.5
