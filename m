From: Hema HK <hemahk@ti.com>
Subject: [PATCH 3/8 v2] usb: musb: HWMOD database structures addition for OMAP3
Date: Wed, 18 Aug 2010 19:37:40 +0530
Message-ID: <1282140460-28929-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51623 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab0HROHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 10:07:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

OMAP3 hwmod data stuctures are populated with base address, L3 and L4
interface clocks, IRQs,and sysconfig register details.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  100 ++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..94d5b05 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -82,6 +82,16 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
+static struct omap_hwmod omap3xxx_usbhsotg_hwmod;
+
+/* L3 <- USBHSOTG interface */
+static struct omap_hwmod_ocp_if omap3xxx_usbhsotg__l3 = {
+	.master		= &omap3xxx_usbhsotg_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU,
+};
+
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
@@ -90,6 +100,38 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/*
+* USBHSOTG interface data
+*/
+
+static struct omap_hwmod_addr_space omap3xxx_usbhsotg_addrs[] = {
+	{
+		.pa_start	= OMAP34XX_HSUSB_OTG_BASE,
+		.pa_end		= OMAP34XX_HSUSB_OTG_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* USBHSOTG <- L4_CORE interface */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__usbhsotg = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_usbhsotg_hwmod,
+	.clk		= "l4_ick",
+	.addr		= omap3xxx_usbhsotg_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_usbhsotg_addrs),
+	.user		= OCP_USER_MPU,
+
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_usbhsotg_masters[] = {
+	&omap3xxx_usbhsotg__l3,
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_usbhsotg_slaves[] = {
+	&omap3xxx_l4_core__usbhsotg,
+};
+
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
@@ -197,6 +239,63 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/*
+ * USBHSOTG (USBHS)
+ */
+static struct omap_hwmod_class_sysconfig omap3xxx_usbhsotg_sysc = {
+	.rev_offs	= 0x0400,
+	.sysc_offs	= 0x0404,
+	.syss_offs	= 0x0408,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
+			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			  SYSC_HAS_AUTOIDLE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO | SIDLE_SMART,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class usbotg_class = {
+	.name = "usbotg",
+	.sysc = &omap3xxx_usbhsotg_sysc,
+};
+
+/* usb_otg_hs */
+static struct omap_hwmod_irq_info omap3xxx_usbhsotg_mpu_irqs[] = {
+
+	{ .name = "mc", .irq = 92 },
+	{ .name = "dma", .irq = 93 },
+
+};
+
+static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
+	.name		= "usb_otg_hs",
+	.mpu_irqs	= omap3xxx_usbhsotg_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_usbhsotg_mpu_irqs),
+	.main_clk	= "hsotgusb_ick",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_GRPSEL_HSOTGUSB_MASK,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT,
+			.idlest_stdby_bit = OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT
+		},
+	},
+	.masters	= omap3xxx_usbhsotg_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_usbhsotg_masters),
+	.slaves		= omap3xxx_usbhsotg_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_usbhsotg_slaves),
+	.class		= &usbotg_class,
+
+	/*
+	 * Errata ID: i479  idle_req / idle_ack mechanism potentially
+	 * broken when autoidle is enabled
+	 * workaround is to disable the autodile bit at module level.
+	 */
+	.flags		= HWMOD_NO_OCP_AUTOIDLE,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +303,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_usbhsotg_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4

