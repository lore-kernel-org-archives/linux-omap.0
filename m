From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v6 1/4] OMAP2: hwmod data: add mailbox data
Date: Thu, 17 Feb 2011 19:42:24 -0600
Message-ID: <1297993347-5654-2-git-send-email-omar.ramirez@ti.com>
References: <1297993347-5654-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578Ab1BRBxz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 20:53:55 -0500
In-Reply-To: <1297993347-5654-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Sourav Poddar <sourav.poddar@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Mailbox hwmod data for omap2430 and 2420.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   73 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   72 +++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 7fffd34..bd7f982 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -904,6 +904,76 @@ static struct omap_hwmod omap2420_dma_system_hwmod = {
 };
 
 /*
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
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
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
+	{ .name = "dsp", .irq = 26 },
+	{ .name = "iva", .irq = 34 },
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
+	.main_clk	= "mailboxes_ick",
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
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/*
  * 'mcspi' class
  * multichannel serial port interface (mcspi) / master/slave synchronous serial
  * bus
@@ -1038,6 +1108,9 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	/* dma_system class*/
 	&omap2420_dma_system_hwmod,
 
+	/* mailbox class */
+	&omap2420_mailbox_hwmod,
+
 	/* mcspi class */
 	&omap2420_mcspi1_hwmod,
 	&omap2420_mcspi2_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 60fe4aa..2bd1d1e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -978,6 +978,75 @@ static struct omap_hwmod omap2430_dma_system_hwmod = {
 };
 
 /*
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
+	{ .irq = 26 },
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
+	.main_clk	= "mailboxes_ick",
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
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/*
  * 'mcspi' class
  * multichannel serial port interface (mcspi) / master/slave synchronous serial
  * bus
@@ -1156,6 +1225,9 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	/* dma_system class*/
 	&omap2430_dma_system_hwmod,
 
+	/* mailbox class */
+	&omap2430_mailbox_hwmod,
+
 	/* mcspi class */
 	&omap2430_mcspi1_hwmod,
 	&omap2430_mcspi2_hwmod,
-- 
1.7.1

