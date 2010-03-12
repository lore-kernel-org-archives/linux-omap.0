From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH 2/6] SPI omap2_mcspi: Add max_clk_div field to mcspi
 platform config
Date: Fri, 12 Mar 2010 10:21:47 -0500
Message-ID: <1268407307.14445.51.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:3108 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934020Ab0CLPVt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 10:21:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org

The McSPI_CHxCONF.CLKD register field has different limits for the
OMAP3 then the OMAP24xx. As per recommendation from the linux-omap
list, added a field for max_clk_div to the platform data for use in 
omap2_mcspi.c.

Used in a subsequent patch. 

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 arch/arm/mach-omap2/devices.c           |   16 ++++++++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 23e4d77..d4ad126 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -302,6 +302,11 @@ static inline void omap_init_sti(void) {}
 
 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	.max_clk_div	= 0x0c,
+#else
+	.max_clk_div	= 0x0f,
+#endif
 };
 
 static struct resource omap2_mcspi1_resources[] = {
@@ -324,6 +329,11 @@ static struct platform_device omap2_mcspi1 = {
 
 static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
 	.num_cs		= 2,
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	.max_clk_div	= 0x0c,
+#else
+	.max_clk_div	= 0x0f,
+#endif
 };
 
 static struct resource omap2_mcspi2_resources[] = {
@@ -348,6 +358,11 @@ static struct platform_device omap2_mcspi2 = {
 	defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
 	.num_cs		= 2,
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	.max_clk_div	= 0x0c,
+#else
+	.max_clk_div	= 0x0f,
+#endif
 };
 
 static struct resource omap2_mcspi3_resources[] = {
@@ -372,6 +387,7 @@ static struct platform_device omap2_mcspi3 = {
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
 	.num_cs		= 1,
+	.max_clk_div	= 0x0c,
 };
 
 static struct resource omap2_mcspi4_resources[] = {
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 1254e49..9fadddd 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -3,6 +3,7 @@
 
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
+	unsigned short	max_clk_div;
 };
 
 struct omap2_mcspi_device_config {






