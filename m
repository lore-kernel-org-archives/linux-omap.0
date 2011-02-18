From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v6 2/4] OMAP3: hwmod data: add mailbox data
Date: Thu, 17 Feb 2011 19:42:25 -0600
Message-ID: <1297993347-5654-3-git-send-email-omar.ramirez@ti.com>
References: <1297993347-5654-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46005 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab1BRBxy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 20:53:54 -0500
In-Reply-To: <1297993347-5654-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Sourav Poddar <sourav.poddar@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, Felipe Contreras <felipe.contreras@gmail.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Felipe Contreras <felipe.contreras@gmail.com>

Mailbox hwmod data for omap3.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   71 ++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 800eda4..b697c98 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1361,6 +1361,74 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
+/*
+ * 'mailbox' class
+ * mailbox module allowing communication between the on-chip processors
+ * using a queued mailbox-interrupt mechanism.
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_mailbox_sysc = {
+	.rev_offs	= 0x000,
+	.sysc_offs	= 0x010,
+	.syss_offs	= 0x014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap3xxx_mailbox_sysc,
+};
+
+static struct omap_hwmod omap3xxx_mailbox_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_mailbox_irqs[] = {
+	{ .irq = 26 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x48094000,
+		.pa_end		= 0x480941ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_core -> mailbox */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mailbox = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mailbox_hwmod,
+	.addr		= omap3xxx_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mailbox_slaves[] = {
+	&omap3xxx_l4_core__mailbox,
+};
+
+static struct omap_hwmod omap3xxx_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap3xxx_mailbox_hwmod_class,
+	.mpu_irqs	= omap3xxx_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mailbox_irqs),
+	.main_clk	= "mailboxes_ick",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MAILBOXES_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_MAILBOXES_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 /* l4 core -> mcspi1 interface */
 static struct omap_hwmod_addr_space omap34xx_mcspi1_addr_space[] = {
 	{
@@ -1662,6 +1730,9 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	/* dma_system class*/
 	&omap3xxx_dma_system_hwmod,
 
+	/* mailbox class */
+	&omap3xxx_mailbox_hwmod,
+
 	/* mcspi class */
 	&omap34xx_mcspi1,
 	&omap34xx_mcspi2,
-- 
1.7.1

