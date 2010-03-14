From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH 2/6 Revised] SPI omap2_mcspi: Add max_clk_div field to
 mcspi platform config
Date: Sun, 14 Mar 2010 13:25:48 -0400
Message-ID: <1268587548.30878.11.camel@quad>
References: <1268407307.14445.51.camel@quad>
	 <20100312172148.GG2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:3887 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab0CNRZv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 14 Mar 2010 13:25:51 -0400
In-Reply-To: <20100312172148.GG2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Roman Tereshonkov <roman.tereshonkov@nokia.com>, linux-omap@vger.kernel.org, Aaro Koskinen <Aaro.Koskinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

The McSPI_CHxCONF.CLKD register field has different limits for
the OMAP3 then the OMAP24xx. New max_clk_div field added to
mcspi platform config structure to keep track of this.

Revised patch to not break multi-omap booting.

Signed-off-by: Scott Ellis <scott@jumpnowtek.com>

 arch/arm/mach-omap2/devices.c           |   14 ++++++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 23e4d77..200f382 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -415,6 +415,11 @@ static inline void omap4_mcspi_fixup(void)
 	defined(CONFIG_ARCH_OMAP4)
 static inline void omap2_mcspi3_init(void)
 {
+	if (cpu_is_omap343x() || cpu_is_omap44xx())
+		omap2_mcspi3_config.max_clk_div = 0x0c;
+	else
+		omap2_mcspi3_config.max_clk_div = 0x0f;
+
 	platform_device_register(&omap2_mcspi3);
 }
 #else
@@ -426,6 +431,7 @@ static inline void omap2_mcspi3_init(void)
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static inline void omap2_mcspi4_init(void)
 {
+	omap2_mcspi4_config.max_clk_div = 0x0c;
 	platform_device_register(&omap2_mcspi4);
 }
 #else
@@ -439,6 +445,14 @@ static void omap_init_mcspi(void)
 	if (cpu_is_omap44xx())
 		omap4_mcspi_fixup();
 
+	if (cpu_is_omap343x() || cpu_is_omap44xx()) {
+		omap2_mcspi1_config.max_clk_div = 0x0c;
+		omap2_mcspi2_config.max_clk_div = 0x0c;
+	} else {
+		omap2_mcspi1_config.max_clk_div = 0x0f;
+		omap2_mcspi2_config.max_clk_div = 0x0f;
+	}
+
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
 
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


