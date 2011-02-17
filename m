From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 3/7] OMAP2430: hwmod data: Add USBOTG
Date: Thu, 17 Feb 2011 14:41:02 +0200
Message-ID: <1297946466-9565-4-git-send-email-balbi@ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:53428 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755035Ab1BQMlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:41:22 -0500
Received: by mail-bw0-f43.google.com with SMTP id 14so2603111bwz.16
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 04:41:20 -0800 (PST)
In-Reply-To: <1297946466-9565-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Hema HK <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

OMAP2430 hwmod data structures are populated with base address, L3 and L4
interface clocks, IRQs and sysconfig register details.

As per OMAP USBOTG specification, need to configure the USBOTG
to smart idle/standby or no idle/standby during data transfer and
force idle/standby when not in use to support retention and off-mode.
By setting HWMOD_SWSUP_SIDLE and HWMOD_SWSUP_MSTANDBY flags, framework
will take care of configuring to no idle/standby when module is enabled
and force idle/standby when suspended.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   98 ++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8ecfbcd..76bbf8a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -89,6 +89,16 @@ static struct omap_hwmod omap2430_uart3_hwmod;
 static struct omap_hwmod omap2430_i2c1_hwmod;
 static struct omap_hwmod omap2430_i2c2_hwmod;
 
+static struct omap_hwmod omap2430_usbhsotg_hwmod;
+
+/* l3_core -> usbhsotg  interface */
+static struct omap_hwmod_ocp_if omap2430_usbhsotg__l3 = {
+	.master		= &omap2430_usbhsotg_hwmod,
+	.slave		= &omap2430_l3_main_hwmod,
+	.clk		= "core_l3_ck",
+	.user		= OCP_USER_MPU,
+};
+
 /* I2C IP block address space length (in bytes) */
 #define OMAP2_I2C_AS_LEN		128
 
@@ -189,6 +199,35 @@ static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/*
+* usbhsotg interface data
+*/
+static struct omap_hwmod_addr_space omap2430_usbhsotg_addrs[] = {
+	{
+		.pa_start	= OMAP243X_HS_BASE,
+		.pa_end		= OMAP243X_HS_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/*  l4_core ->usbhsotg  interface */
+static struct omap_hwmod_ocp_if omap2430_l4_core__usbhsotg = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_usbhsotg_hwmod,
+	.clk		= "usb_l4_ick",
+	.addr		= omap2430_usbhsotg_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_usbhsotg_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_usbhsotg_masters[] = {
+	&omap2430_usbhsotg__l3,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_usbhsotg_slaves[] = {
+	&omap2430_l4_core__usbhsotg,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 	&omap2430_l3_main__l4_core,
@@ -919,6 +958,62 @@ static struct omap_hwmod omap2430_dma_system_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/*
+ * usbhsotg
+ */
+static struct omap_hwmod_class_sysconfig omap2430_usbhsotg_sysc = {
+	.rev_offs	= 0x0400,
+	.sysc_offs	= 0x0404,
+	.syss_offs	= 0x0408,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
+			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			  SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			  MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class usbotg_class = {
+	.name = "usbotg",
+	.sysc = &omap2430_usbhsotg_sysc,
+};
+
+/* usb_otg_hs */
+static struct omap_hwmod_irq_info omap2430_usbhsotg_mpu_irqs[] = {
+
+	{ .name = "mc", .irq = 92 },
+	{ .name = "dma", .irq = 93 },
+};
+
+static struct omap_hwmod omap2430_usbhsotg_hwmod = {
+	.name		= "usb_otg_hs",
+	.mpu_irqs	= omap2430_usbhsotg_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_usbhsotg_mpu_irqs),
+	.main_clk	= "usbhs_ick",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2430_EN_USBHS_MASK,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP2430_ST_USBHS_SHIFT,
+		},
+	},
+	.masters	= omap2430_usbhsotg_masters,
+	.masters_cnt	= ARRAY_SIZE(omap2430_usbhsotg_masters),
+	.slaves		= omap2430_usbhsotg_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_usbhsotg_slaves),
+	.class		= &usbotg_class,
+	/*
+	 * Erratum ID: i479  idle_req / idle_ack mechanism potentially
+	 * broken when autoidle is enabled
+	 * workaround is to disable the autoidle bit at module level.
+	 */
+	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
+				| HWMOD_SWSUP_MSTANDBY,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -941,6 +1036,9 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 
 	/* dma_system class*/
 	&omap2430_dma_system_hwmod,
+
+	/* usbotg class*/
+	&omap2430_usbhsotg_hwmod,
 	NULL,
 };
 
-- 
1.7.4.rc2

