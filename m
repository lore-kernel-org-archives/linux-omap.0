From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 2/10] omap mailbox: OMAP4 - Add resources and mailbox
 register base address for OMAP4 mailbox
Date: Tue, 22 Sep 2009 19:59:01 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39504 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130AbZIVO3D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:29:03 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Gupta, Ramesh" <grgupta@ti.com>

>From c8057dc97d7b3479e2fb73f57f13ff27f6af8b9e Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Tue, 8 Sep 2009 15:26:34 +0530
Subject: [PATCH 2/10] omap mailbox: OMAP4 - Add resources and mailbox register base address for OMAP4 mailbox

This patch adds resource information of mailbox driver for
OMAP4 mailbox module. Register base address also added

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/mach-omap2/devices.c              |   36 +++++++++++++++++++++-------
 arch/arm/plat-omap/include/mach/omap44xx.h |    2 +
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 894cc35..359c715 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -136,9 +136,10 @@ static inline void omap_init_camera(void)
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
 
-#define MBOX_REG_SIZE	0x120
+#define MBOX_REG_SIZE   0x120
 
-static struct resource omap2_mbox_resources[] = {
+#ifdef CONFIG_ARCH_OMAP2
+static struct resource omap_mbox_resources[] = {
 	{
 		.start		= OMAP24XX_MAILBOX_BASE,
 		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -153,8 +154,10 @@ static struct resource omap2_mbox_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	},
 };
+#endif
 
-static struct resource omap3_mbox_resources[] = {
+#ifdef CONFIG_ARCH_OMAP3
+static struct resource omap_mbox_resources[] = {
 	{
 		.start		= OMAP34XX_MAILBOX_BASE,
 		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -165,6 +168,24 @@ static struct resource omap3_mbox_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	},
 };
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+
+#define OMAP4_MBOX_REG_SIZE	0x130
+static struct resource omap_mbox_resources[] = {
+	{
+		.start          = OMAP44XX_MAILBOX_BASE,
+		.end            = OMAP44XX_MAILBOX_BASE +
+					OMAP4_MBOX_REG_SIZE - 1,
+		.flags          = IORESOURCE_MEM,
+	},
+	{
+		.start          = INT_44XX_MAIL_U0_MPU,
+		.flags          = IORESOURCE_IRQ,
+	},
+};
+#endif
 
 static struct platform_device mbox_device = {
 	.name		= "omap2-mailbox",
@@ -173,12 +194,9 @@ static struct platform_device mbox_device = {
 
 static inline void omap_init_mbox(void)
 {
-	if (cpu_is_omap2420()) {
-		mbox_device.num_resources = ARRAY_SIZE(omap2_mbox_resources);
-		mbox_device.resource = omap2_mbox_resources;
-	} else if (cpu_is_omap3430()) {
-		mbox_device.num_resources = ARRAY_SIZE(omap3_mbox_resources);
-		mbox_device.resource = omap3_mbox_resources;
+	if (cpu_is_omap2420() || cpu_is_omap3430() || cpu_is_omap44xx()) {
+		mbox_device.num_resources = ARRAY_SIZE(omap_mbox_resources);
+		mbox_device.resource = omap_mbox_resources;
 	} else {
 		pr_err("%s: platform not supported\n", __func__);
 		return;
diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
index 52f2f85..ef0efaa 100644
--- a/arch/arm/plat-omap/include/mach/omap44xx.h
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -44,5 +44,7 @@
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 #define OMAP44XX_VA_WKUPGEN_BASE	IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
 
+#define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.5.3.2
