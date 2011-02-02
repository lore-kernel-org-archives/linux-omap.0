From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
Date: Wed,  2 Feb 2011 13:27:21 -0600
Message-ID: <1296674843-12718-4-git-send-email-omar.ramirez@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60474 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873Ab1BBTij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 14:38:39 -0500
In-Reply-To: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Mailbox hwmod data for omap4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 ++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c2806bd..c495669 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2001,6 +2001,70 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'mailbox' class
+ * mailbox module allowing communication between the on-chip processors
+ * using a queued mailbox-interrupt mechanism.
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_mailbox_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
+	.name = "mailbox",
+	.sysc = &omap44xx_mailbox_sysc,
+};
+
+/* mailbox */
+static struct omap_hwmod omap44xx_mailbox_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
+	{ .name = "mbox", .irq = 26 + OMAP44XX_IRQ_GIC_START, },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x4a0f4000,
+		.pa_end		= 0x4a0f41ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+/* l4_cfg -> mailbox */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_mailbox_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mailbox_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mailbox_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mailbox slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mailbox_slaves[] = {
+	&omap44xx_l4_cfg__mailbox,
+};
+
+static struct omap_hwmod omap44xx_mailbox_hwmod = {
+	.name		= "mailbox",
+	.class		= &omap44xx_mailbox_hwmod_class,
+	.mpu_irqs	= omap44xx_mailbox_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mailbox_irqs),
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4CFG_MAILBOX_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mailbox_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mailbox_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* dmm class */
@@ -2068,6 +2132,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_wd_timer2_hwmod,
 	&omap44xx_wd_timer3_hwmod,
 
+	/* mailbox class */
+	&omap44xx_mailbox_hwmod,
+
 	NULL,
 };
 
-- 
1.7.1

