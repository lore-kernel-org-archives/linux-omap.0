From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/5] omap: mailbox: initial hwmod support for omap2
Date: Tue, 26 Oct 2010 16:53:01 -0500
Message-ID: <1288129984-22957-3-git-send-email-omar.ramirez@ti.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59991 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760543Ab0JZWDR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 18:03:17 -0400
In-Reply-To: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

HWMOD support for omap2430 and 2420.

Compiled tested only.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   55 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   54 +++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a1a3dd6..e417fb4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -81,6 +81,7 @@ static struct omap_hwmod omap2420_uart2_hwmod;
 static struct omap_hwmod omap2420_uart3_hwmod;
 static struct omap_hwmod omap2420_i2c1_hwmod;
 static struct omap_hwmod omap2420_i2c2_hwmod;
+static struct omap_hwmod omap2420_mailbox_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
@@ -557,6 +558,59 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG,
 };
 
+/* Mailbox */
+
+static struct omap_hwmod_class omap2420_mailbox_hwmod_class = {
+	.name = "mailbox",
+};
+
+static struct omap_hwmod_irq_info omap2420_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = INT_24XX_MAIL_U0_MPU },
+	{ .name = "iva", .irq = INT_24XX_MAIL_U3_MPU },
+};
+
+static struct omap_hwmod_addr_space omap2420_mailbox_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_MAILBOX_BASE,
+		.pa_end		= OMAP24XX_MAILBOX_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* L4_CORE -> Mailbox */
+static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mailbox_hwmod,
+	.addr		= omap2420_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* Mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap2420_mailbox_slaves[] = {
+	&omap2420_l4_core__mailbox,
+};
+
+static struct omap_hwmod omap2420_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap2420_mailbox_hwmod_class,
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.main_clk	= "mailboxes_ick",
+	.mpu_irqs	= omap2420_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_mailbox_irqs),
+	.slaves		= omap2420_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -569,6 +623,7 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_uart3_hwmod,
 	&omap2420_i2c1_hwmod,
 	&omap2420_i2c2_hwmod,
+	&omap2420_mailbox_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 7cf0d3a..1a7d2d9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -81,6 +81,7 @@ static struct omap_hwmod omap2430_uart2_hwmod;
 static struct omap_hwmod omap2430_uart3_hwmod;
 static struct omap_hwmod omap2430_i2c1_hwmod;
 static struct omap_hwmod omap2430_i2c2_hwmod;
+static struct omap_hwmod omap2430_mailbox_hwmod;
 
 /* I2C IP block address space length (in bytes) */
 #define OMAP2_I2C_AS_LEN		128
@@ -569,6 +570,58 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/* Mailbox */
+
+static struct omap_hwmod_class omap2430_mailbox_hwmod_class = {
+	.name = "mailbox",
+};
+
+static struct omap_hwmod_irq_info omap2430_mailbox_irqs[] = {
+	{ .name = "dsp", .irq = INT_24XX_MAIL_U0_MPU },
+};
+
+static struct omap_hwmod_addr_space omap2430_mailbox_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_MAILBOX_BASE,
+		.pa_end		= OMAP24XX_MAILBOX_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* L4_CORE -> Mailbox */
+static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mailbox_hwmod,
+	.addr		= omap2430_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* Mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap2430_mailbox_slaves[] = {
+	&omap2430_l4_core__mailbox,
+};
+
+static struct omap_hwmod omap2430_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap2430_mailbox_hwmod_class,
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.main_clk	= "mailboxes_ick",
+	.mpu_irqs	= omap2430_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_mailbox_irqs),
+	.slaves		= omap2430_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -581,6 +634,7 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_uart3_hwmod,
 	&omap2430_i2c1_hwmod,
 	&omap2430_i2c2_hwmod,
+	&omap2430_mailbox_hwmod,
 	NULL,
 };
 
-- 
1.7.1

