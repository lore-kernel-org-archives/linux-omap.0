From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/5] omap: mailbox: initial hwmod support for omap3
Date: Tue, 26 Oct 2010 16:53:00 -0500
Message-ID: <1288129984-22957-2-git-send-email-omar.ramirez@ti.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35620 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758276Ab0JZWDQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 18:03:16 -0400
In-Reply-To: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

HWMOD support for omap3.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/devices.c              |  100 ++++-----------------------
 arch/arm/mach-omap2/mailbox.c              |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   54 +++++++++++++++
 3 files changed, 70 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index eaf3799..d977572 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -141,95 +141,25 @@ static inline void omap_init_camera(void)
 #endif
 
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
-
-#define MBOX_REG_SIZE   0x120
-
-#ifdef CONFIG_ARCH_OMAP2
-static struct resource omap2_mbox_resources[] = {
-	{
-		.start		= OMAP24XX_MAILBOX_BASE,
-		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= INT_24XX_MAIL_U0_MPU,
-		.flags		= IORESOURCE_IRQ,
-		.name		= "dsp",
-	},
-	{
-		.start		= INT_24XX_MAIL_U3_MPU,
-		.flags		= IORESOURCE_IRQ,
-		.name		= "iva",
-	},
-};
-static int omap2_mbox_resources_sz = ARRAY_SIZE(omap2_mbox_resources);
-#else
-#define omap2_mbox_resources		NULL
-#define omap2_mbox_resources_sz		0
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct resource omap3_mbox_resources[] = {
-	{
-		.start		= OMAP34XX_MAILBOX_BASE,
-		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= INT_24XX_MAIL_U0_MPU,
-		.flags		= IORESOURCE_IRQ,
-		.name		= "dsp",
-	},
-};
-static int omap3_mbox_resources_sz = ARRAY_SIZE(omap3_mbox_resources);
-#else
-#define omap3_mbox_resources		NULL
-#define omap3_mbox_resources_sz		0
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-
-#define OMAP4_MBOX_REG_SIZE	0x130
-static struct resource omap4_mbox_resources[] = {
-	{
-		.start          = OMAP44XX_MAILBOX_BASE,
-		.end            = OMAP44XX_MAILBOX_BASE +
-					OMAP4_MBOX_REG_SIZE - 1,
-		.flags          = IORESOURCE_MEM,
-	},
-	{
-		.start          = OMAP44XX_IRQ_MAIL_U0,
-		.flags          = IORESOURCE_IRQ,
-		.name		= "mbox",
-	},
-};
-static int omap4_mbox_resources_sz = ARRAY_SIZE(omap4_mbox_resources);
-#else
-#define omap4_mbox_resources		NULL
-#define omap4_mbox_resources_sz		0
-#endif
-
-static struct platform_device mbox_device = {
-	.name		= "omap-mailbox",
-	.id		= -1,
-};
-
 static inline void omap_init_mbox(void)
 {
-	if (cpu_is_omap24xx()) {
-		mbox_device.resource = omap2_mbox_resources;
-		mbox_device.num_resources = omap2_mbox_resources_sz;
-	} else if (cpu_is_omap34xx()) {
-		mbox_device.resource = omap3_mbox_resources;
-		mbox_device.num_resources = omap3_mbox_resources_sz;
-	} else if (cpu_is_omap44xx()) {
-		mbox_device.resource = omap4_mbox_resources;
-		mbox_device.num_resources = omap4_mbox_resources_sz;
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+
+	oh = omap_hwmod_lookup("mailbox");
+	if (!oh) {
+		pr_err("%s: unable to find hwmod\n", __func__);
+		return;
+	}
+
+	od = omap_device_build("omap-mailbox", -1, oh,
+			NULL, 0,
+			NULL, 0,
+			0);
+	if (!od) {
+		pr_err("%s: could not build device\n", __func__);
 		return;
 	}
-	platform_device_register(&mbox_device);
 }
 #else
 static inline void omap_init_mbox(void) { }
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 40ddeca..1ddb82d 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <plat/mailbox.h>
+#include <plat/omap_hwmod.h>
 #include <mach/irqs.h>
 
 #define MAILBOX_REVISION		0x000
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ed6bf4a..9e9e843 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -45,6 +45,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
 static struct omap_hwmod omap3xxx_i2c1_hwmod;
 static struct omap_hwmod omap3xxx_i2c2_hwmod;
 static struct omap_hwmod omap3xxx_i2c3_hwmod;
+static struct omap_hwmod omap3xxx_mailbox_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -736,6 +737,58 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* Mailbox */
+
+static struct omap_hwmod_class omap3xxx_mailbox_hwmod_class = {
+	.name = "mailbox",
+};
+
+static struct omap_hwmod_irq_info omap3xxx_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = INT_24XX_MAIL_U0_MPU },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mailbox_addrs[] = {
+	{
+		.pa_start	= OMAP34XX_MAILBOX_BASE,
+		.pa_end		= OMAP34XX_MAILBOX_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* L4_CORE -> Mailbox */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mailbox = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mailbox_hwmod,
+	.addr		= omap3xxx_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* Mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mailbox_slaves[] = {
+	&omap3xxx_l4_core__mailbox,
+};
+
+static struct omap_hwmod omap3xxx_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap3xxx_mailbox_hwmod_class,
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.main_clk	= "mailboxes_ick",
+	.mpu_irqs	= omap3xxx_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mailbox_irqs),
+	.slaves		= omap3xxx_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -751,6 +804,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
+	&omap3xxx_mailbox_hwmod,
 	NULL,
 };
 
-- 
1.7.1

