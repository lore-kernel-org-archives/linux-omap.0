From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] Add SDTI device for OMAP3 and unify address definitions for OMAP1 and OMAP2.
Date: Wed, 28 May 2008 19:05:58 +0300
Message-ID: <1211990758-4252-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44898 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbYE1QG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 12:06:27 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4SG6HAt032054
	for <linux-omap@vger.kernel.org>; Wed, 28 May 2008 19:06:24 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>


Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap2/devices.c |   23 ++++++++++++++++++++++-
 drivers/misc/sti/sti.c        |    4 ++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index da8a3ac..15ab43c 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -102,7 +102,7 @@ static inline void omap_init_mbox(void) { }
 
 #if defined(CONFIG_OMAP_STI)
 
-#define OMAP1_STI_BASE		IO_ADDRESS(0xfffea000)
+#define OMAP1_STI_BASE		0xfffea000
 #define OMAP1_STI_CHANNEL_BASE	(OMAP1_STI_BASE + 0x400)
 
 static struct resource sti_resources[] = {
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d02e9e5..d8fb3f8 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -92,7 +92,9 @@ static inline void omap_init_mbox(void) { }
 
 #if defined(CONFIG_OMAP_STI)
 
-#define OMAP2_STI_BASE		IO_ADDRESS(0x48068000)
+#if defined(CONFIG_ARCH_OMAP2)
+
+#define OMAP2_STI_BASE		0x48068000
 #define OMAP2_STI_CHANNEL_BASE	0x54000000
 #define OMAP2_STI_IRQ		4
 
@@ -112,6 +114,25 @@ static struct resource sti_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	}
 };
+#elif defined(CONFIG_ARCH_OMAP3)
+
+#define OMAP3_SDTI_BASE		0x54500000
+#define OMAP3_SDTI_CHANNEL_BASE	0x54600000
+
+static struct resource sti_resources[] = {
+	{
+		.start		= OMAP3_SDTI_BASE,
+		.end		= OMAP3_SDTI_BASE + 0xFFF,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3_SDTI_CHANNEL_BASE,
+		.end		= OMAP3_SDTI_CHANNEL_BASE + SZ_1M - 1,
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+#endif
 
 static struct platform_device sti_device = {
 	.name		= "sti",
diff --git a/drivers/misc/sti/sti.c b/drivers/misc/sti/sti.c
index e828860..1140fed 100644
--- a/drivers/misc/sti/sti.c
+++ b/drivers/misc/sti/sti.c
@@ -356,7 +356,7 @@ static int __devinit sti_probe(struct platform_device *pdev)
 	if (unlikely(ret != 0))
 		goto err;
 
-	sti_base = res->start;
+	sti_base = io_p2v(res->start);
 
 	/*
 	 * OMAP 16xx keeps channels in a relatively sane location,
@@ -364,7 +364,7 @@ static int __devinit sti_probe(struct platform_device *pdev)
 	 * remapped.
 	 */
 	if (cpu_is_omap16xx())
-		sti_channel_base = cres->start;
+		sti_channel_base = io_p2v(cres->start);
 	else if (cpu_is_omap24xx()) {
 		unsigned int size = cres->end - cres->start;
 
-- 
1.5.5.1

