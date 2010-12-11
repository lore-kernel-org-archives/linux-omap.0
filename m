From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v3 3/5] OMAP4: hwmod data: add mailbox data
Date: Fri, 10 Dec 2010 19:51:04 -0600
Message-ID: <1292032266-29460-4-git-send-email-omar.ramirez@ti.com>
References: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38655 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab0LKCCY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 21:02:24 -0500
In-Reply-To: <1292032266-29460-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, Charulatha V <charu@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Mailbox hwmod data for omap4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68 ++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ae14bd5..9c6db0e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1380,6 +1380,71 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
+
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
 	&omap44xx_dmm_hwmod,
@@ -1422,6 +1487,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_uart2_hwmod,
 	&omap44xx_uart3_hwmod,
 	&omap44xx_uart4_hwmod,
+
+	/* mailbox class */
+	&omap44xx_mailbox_hwmod,
 	NULL,
 };
 
-- 
1.7.1

