From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/14] omap2/3/4: Fix mbox init for multi-omap
Date: Tue, 26 Jan 2010 12:12:53 -0800
Message-ID: <20100126201253.15382.2247.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58121 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab0AZUMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:33 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Fix mbox init for multi-omap

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 18ad931..935e36c 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -141,7 +141,7 @@ static inline void omap_init_camera(void)
 #define MBOX_REG_SIZE   0x120
 
 #ifdef CONFIG_ARCH_OMAP2
-static struct resource omap_mbox_resources[] = {
+static struct resource omap2_mbox_resources[] = {
 	{
 		.start		= OMAP24XX_MAILBOX_BASE,
 		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -156,10 +156,14 @@ static struct resource omap_mbox_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	},
 };
+static int omap2_mbox_resources_sz = ARRAY_SIZE(omap2_mbox_resources);
+#else
+#define omap2_mbox_resources		NULL
+#define omap2_mbox_resources_sz		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-static struct resource omap_mbox_resources[] = {
+static struct resource omap3_mbox_resources[] = {
 	{
 		.start		= OMAP34XX_MAILBOX_BASE,
 		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
@@ -170,12 +174,16 @@ static struct resource omap_mbox_resources[] = {
 		.flags		= IORESOURCE_IRQ,
 	},
 };
+static int omap3_mbox_resources_sz = ARRAY_SIZE(omap3_mbox_resources);
+#else
+#define omap3_mbox_resources		NULL
+#define omap3_mbox_resources_sz		0
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
 
 #define OMAP4_MBOX_REG_SIZE	0x130
-static struct resource omap_mbox_resources[] = {
+static struct resource omap4_mbox_resources[] = {
 	{
 		.start          = OMAP44XX_MAILBOX_BASE,
 		.end            = OMAP44XX_MAILBOX_BASE +
@@ -187,6 +195,10 @@ static struct resource omap_mbox_resources[] = {
 		.flags          = IORESOURCE_IRQ,
 	},
 };
+static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
+#else
+#define omap4_mbox_resources		NULL
+#define omap4_mbox_resources_sz		0
 #endif
 
 static struct platform_device mbox_device = {
@@ -196,9 +208,15 @@ static struct platform_device mbox_device = {
 
 static inline void omap_init_mbox(void)
 {
-	if (cpu_is_omap2420() || cpu_is_omap3430() || cpu_is_omap44xx()) {
-		mbox_device.num_resources = ARRAY_SIZE(omap_mbox_resources);
-		mbox_device.resource = omap_mbox_resources;
+	if (cpu_is_omap24xx()) {
+		mbox_device.resource = omap2_mbox_resources;
+		mbox_device.num_resources = omap2_mbox_resources_sz;
+	} else if (cpu_is_omap34xx()) {
+		mbox_device.resource = omap3_mbox_resources;
+		mbox_device.num_resources = omap3_mbox_resources_sz;
+	} else if (cpu_is_omap44xx()) {
+		mbox_device.resource = omap4_mbox_resources;
+		mbox_device.num_resources = omap4_mbox_resources_sz;
 	} else {
 		pr_err("%s: platform not supported\n", __func__);
 		return;

