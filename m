From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v5 1/5] OMAP2: hwmod data: add mailbox data
Date: Wed,  2 Feb 2011 13:27:19 -0600
Message-ID: <1296674843-12718-2-git-send-email-omar.ramirez@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60484 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab1BBTin (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 14:38:43 -0500
In-Reply-To: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, omar ramirez <omar.ramirez@ti.com>

From: omar ramirez <omar.ramirez@ti.com>

Mailbox hwmod data for omap2430 and 2420.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   74 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   73 +++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b85c630..3f54c20 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -779,6 +779,76 @@ static struct omap_hwmod omap2420_gpio4_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio4_slaves),
 	.class		= &omap242x_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/*
+ * 'mailbox' class
+ * mailbox module allowing communication between the on-chip processors
+ * using a queued mailbox-interrupt mechanism.
+ */
+
+static struct omap_hwmod_class_sysconfig omap2420_mailbox_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2420_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap2420_mailbox_sysc,
+};
+
+/* mailbox */
+static struct omap_hwmod omap2420_mailbox_hwmod;
+static struct omap_hwmod_irq_info omap2420_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = 26, },
+	{ .name = "iva", .irq = 34, },
+};
+
+static struct omap_hwmod_addr_space omap2420_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x48094000,
+		.pa_end		= 0x480941ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_core -> mailbox */
+static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mailbox_hwmod,
+	.clk		= "mailboxes_ick",
+	.addr		= omap2420_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap2420_mailbox_slaves[] = {
+	&omap2420_l4_core__mailbox,
+};
+
+static struct omap_hwmod omap2420_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap2420_mailbox_hwmod_class,
+	.mpu_irqs	= omap2420_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_mailbox_irqs),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.slaves		= omap2420_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mailbox_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
@@ -885,6 +955,10 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 
 	/* dma_system class*/
 	&omap2420_dma_system_hwmod,
+
+	/* mailbox class */
+	&omap2420_mailbox_hwmod,
+
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8ecfbcd..d591aaf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -834,6 +834,75 @@ static struct omap_hwmod omap2430_gpio5_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio5_slaves),
 	.class		= &omap243x_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
+	.omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/*
+ * 'mailbox' class
+ * mailbox module allowing communication between the on-chip processors
+ * using a queued mailbox-interrupt mechanism.
+ */
+
+static struct omap_hwmod_class_sysconfig omap2430_mailbox_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2430_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap2430_mailbox_sysc,
+};
+
+/* mailbox */
+static struct omap_hwmod omap2430_mailbox_hwmod;
+static struct omap_hwmod_irq_info omap2430_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = 26, },
+};
+
+static struct omap_hwmod_addr_space omap2430_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x48094000,
+		.pa_end		= 0x480941ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_core -> mailbox */
+static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mailbox_hwmod,
+	.clk		= "mailboxes_ick",
+	.addr		= omap2430_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap2430_mailbox_slaves[] = {
+	&omap2430_l4_core__mailbox,
+};
+
+static struct omap_hwmod omap2430_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap2430_mailbox_hwmod_class,
+	.mpu_irqs	= omap2430_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_mailbox_irqs),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mailbox_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
@@ -941,6 +1010,10 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 
 	/* dma_system class*/
 	&omap2430_dma_system_hwmod,
+
+	/* mailbox class */
+	&omap2430_mailbox_hwmod,
+
 	NULL,
 };
 
-- 
1.7.1

