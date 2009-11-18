From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] omap: mailbox: Add resources and mailbox register base
	address for OMAP4 mailbox
Date: Wed, 18 Nov 2009 11:20:17 -0800
Message-ID: <20091118192017.31148.23244.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49424 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609AbZKRTUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:20:13 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ramesh Gupta G <grgupta@ti.com>, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, C A Subramaniam <subramaniam.ca@ti.com>

From: C A Subramaniam <subramaniam.ca@ti.com>

This patch adds resource information of mailbox driver for
OMAP4 mailbox module. Register base address also added

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c              |   36 +++++++++++++++++++++-------
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 ++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 8b6cd8c..733d3dc 100644
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
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 3361897..e52902a 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -40,5 +40,7 @@
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
 
+#define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 

