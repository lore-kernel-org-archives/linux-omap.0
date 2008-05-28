From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH] Add SDTI device for the OMAP3 boards.
Date: Wed, 28 May 2008 15:02:52 +0300
Message-ID: <1211976172-3215-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51950 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbYE1MD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 08:03:27 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4SC3L3Y000761
	for <linux-omap@vger.kernel.org>; Wed, 28 May 2008 15:03:24 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Roman Tereshonkov <roman.tereshonkov@nokia.com>


Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 arch/arm/mach-omap2/devices.c |   23 ++++++++++++++++++++++-
 drivers/misc/sti/sti.c        |    2 +-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d02e9e5..7b38522 100644
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
+		.start          = OMAP3_SDTI_BASE,
+		.end            = OMAP3_SDTI_BASE + 0xFFF,
+		.flags          = IORESOURCE_MEM,
+	},
+	{
+		.start          = OMAP3_SDTI_CHANNEL_BASE,
+		.end            = OMAP3_SDTI_CHANNEL_BASE + SZ_1M - 1,
+		.flags          = IORESOURCE_MEM,
+	}
+};
+
+#endif
 
 static struct platform_device sti_device = {
 	.name		= "sti",
diff --git a/drivers/misc/sti/sti.c b/drivers/misc/sti/sti.c
index e828860..e18d7d0 100644
--- a/drivers/misc/sti/sti.c
+++ b/drivers/misc/sti/sti.c
@@ -368,7 +368,7 @@ static int __devinit sti_probe(struct platform_device *pdev)
 	else if (cpu_is_omap24xx()) {
 		unsigned int size = cres->end - cres->start;
 
-		sti_channel_base = (unsigned long)ioremap(cres->start, size);
+		sti_channel_base = (unsigned long)ioremap(io_p2v(cres->start), size);
 		if (unlikely(!sti_channel_base)) {
 			ret = -ENODEV;
 			goto err_badremap;
-- 
1.5.5.1

