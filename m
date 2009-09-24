From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/12] omap: Fix mcspi compile for 2420
Date: Thu, 24 Sep 2009 16:34:12 -0700
Message-ID: <20090924233412.6065.46957.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64770 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbZIXXeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:34:10 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Commit 7869c0b9ed44404bbc675ef76f8ccb3be5496f39 added support for
additional McSPI ports. Unfortunately that broke compile for 2420.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |   65 ++++++++++++++++++++++++++++++-----------
 1 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index bcfcfc7..faf7a1e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -355,29 +355,60 @@ static struct platform_device omap2_mcspi4 = {
 };
 #endif
 
-static void omap_init_mcspi(void)
+#ifdef CONFIG_ARCH_OMAP4
+static inline void omap4_mcspi_fixup(void)
 {
-	if (cpu_is_omap44xx()) {
-		omap2_mcspi1_resources[0].start	= OMAP4_MCSPI1_BASE;
-		omap2_mcspi1_resources[0].end	= OMAP4_MCSPI1_BASE + 0xff;
-		omap2_mcspi2_resources[0].start	= OMAP4_MCSPI2_BASE;
-		omap2_mcspi2_resources[0].end	= OMAP4_MCSPI2_BASE + 0xff;
-		omap2_mcspi3_resources[0].start	= OMAP4_MCSPI3_BASE;
-		omap2_mcspi3_resources[0].end	= OMAP4_MCSPI3_BASE + 0xff;
-		omap2_mcspi4_resources[0].start	= OMAP4_MCSPI4_BASE;
-		omap2_mcspi4_resources[0].end	= OMAP4_MCSPI4_BASE + 0xff;
-	}
-	platform_device_register(&omap2_mcspi1);
-	platform_device_register(&omap2_mcspi2);
+	omap2_mcspi1_resources[0].start	= OMAP4_MCSPI1_BASE;
+	omap2_mcspi1_resources[0].end	= OMAP4_MCSPI1_BASE + 0xff;
+	omap2_mcspi2_resources[0].start	= OMAP4_MCSPI2_BASE;
+	omap2_mcspi2_resources[0].end	= OMAP4_MCSPI2_BASE + 0xff;
+	omap2_mcspi3_resources[0].start	= OMAP4_MCSPI3_BASE;
+	omap2_mcspi3_resources[0].end	= OMAP4_MCSPI3_BASE + 0xff;
+	omap2_mcspi4_resources[0].start	= OMAP4_MCSPI4_BASE;
+	omap2_mcspi4_resources[0].end	= OMAP4_MCSPI4_BASE + 0xff;
+}
+#else
+static inline void omap4_mcspi_fixup(void)
+{
+}
+#endif
+
 #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
 	defined(CONFIG_ARCH_OMAP4)
-	if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
-		platform_device_register(&omap2_mcspi3);
+static inline void omap2_mcspi3_init(void)
+{
+	platform_device_register(&omap2_mcspi3);
+}
+#else
+static inline void omap2_mcspi3_init(void)
+{
+}
 #endif
+
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	if (cpu_is_omap343x() || cpu_is_omap44xx())
-		platform_device_register(&omap2_mcspi4);
+static inline void omap2_mcspi4_init(void)
+{
+	platform_device_register(&omap2_mcspi4);
+}
+#else
+static inline void omap2_mcspi4_init(void)
+{
+}
 #endif
+
+static void omap_init_mcspi(void)
+{
+	if (cpu_is_omap44xx())
+		omap4_mcspi_fixup();
+
+	platform_device_register(&omap2_mcspi1);
+	platform_device_register(&omap2_mcspi2);
+
+	if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
+		omap2_mcspi3_init();
+
+	if (cpu_is_omap343x() || cpu_is_omap44xx())
+		omap2_mcspi4_init();
 }
 
 #else

