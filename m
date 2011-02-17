From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/8] OMAP4: hwmod data: Add mailbox
Date: Thu, 17 Feb 2011 11:24:46 +0100
Message-ID: <1297938289-8678-6-git-send-email-b-cousson@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42674 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab1BQKZ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 05:25:26 -0500
In-Reply-To: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Mailbox hwmod data for omap4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
[b-cousson@ti.com: Re-order the structures
and remove the irq line name]
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68 +++++++++++++++++++++++++++-
 1 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index aafe60d..efdf266 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -530,7 +530,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  ipu
  *  iss
  *  kbd
- *  mailbox
  *  mcasp
  *  mcbsp1
  *  mcbsp2
@@ -2006,6 +2005,70 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 };
 
 /*
+ * 'mailbox' class
+ * mailbox module allowing communication between the on-chip processors using a
+ * queued mailbox-interrupt mechanism.
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
+	.name	= "mailbox",
+	.sysc	= &omap44xx_mailbox_sysc,
+};
+
+/* mailbox */
+static struct omap_hwmod omap44xx_mailbox_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
+	{ .irq = 26 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x4a0f4000,
+		.pa_end		= 0x4a0f41ff,
+		.flags		= ADDR_TYPE_RT
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
+/*
  * 'mcspi' class
  * multichannel serial port interface (mcspi) / master/slave synchronous serial
  * bus
@@ -3539,6 +3602,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_iva_seq0_hwmod,
 	&omap44xx_iva_seq1_hwmod,
 
+	/* mailbox class */
+	&omap44xx_mailbox_hwmod,
+
 	/* mcspi class */
 	&omap44xx_mcspi1_hwmod,
 	&omap44xx_mcspi2_hwmod,
-- 
1.7.0.4

