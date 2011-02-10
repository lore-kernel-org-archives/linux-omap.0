From: Hema HK <hemahk@ti.com>
Subject: [PATCH 2/5 v6] OMAP3xxx: hwmod data: Add USBOTG
Date: Thu, 10 Feb 2011 19:37:58 +0530
Message-ID: <1297346881-13438-3-git-send-email-hemahk@ti.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54679 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754965Ab1BJOIW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 09:08:22 -0500
In-Reply-To: <1297346881-13438-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

OMAP3 hwmod data structures are populated for USBOTG with base address,
L3 and L4 interface clocks, IRQs and sysconfig register details.

As per OMAP USBOTG specification, need to configure the USBOTG
to smart idle/standby or no idle/standby during data transfer and
force idle/standby when not in use to support retention and offmode.
By setting HWMOD_SWSUP_SIDLE and HWMOD_SWSUP_MSTANDBY flags, framework
will take care of configuring to no idle/standby when module is enabled
and force idle/standby when idled.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ linux-2.6/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -107,6 +107,15 @@ static struct omap_hwmod omap3xxx_uart1_
 static struct omap_hwmod omap3xxx_uart2_hwmod;
 static struct omap_hwmod omap3xxx_uart3_hwmod;
 static struct omap_hwmod omap3xxx_uart4_hwmod;
+static struct omap_hwmod omap3xxx_usbhsotg_hwmod;
+
+/* l3_core -> usbhsotg interface */
+static struct omap_hwmod_ocp_if omap3xxx_usbhsotg__l3 = {
+	.master		= &omap3xxx_usbhsotg_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU,
+};
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
@@ -301,6 +310,36 @@ static struct omap_hwmod_ocp_if omap3_l4
 	.user		= OCP_USER_MPU,
 };
 
+/*
+* usbhsotg interface data
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
+/* l4_core -> usbhsotg  */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__usbhsotg = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_usbhsotg_hwmod,
+	.clk		= "l4_ick",
+	.addr		= omap3xxx_usbhsotg_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_usbhsotg_addrs),
+	.user		= OCP_USER_MPU,
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
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
@@ -1356,6 +1395,64 @@ static struct omap_hwmod omap36xx_sr2_hw
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
+/*
+ * usbhsotg
+ */
+static struct omap_hwmod_class_sysconfig omap3xxx_usbhsotg_sysc = {
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
+	.sysc = &omap3xxx_usbhsotg_sysc,
+};
+
+/* usb_otg_hs */
+static struct omap_hwmod_irq_info omap3xxx_usbhsotg_mpu_irqs[] = {
+
+	{ .name = "mc", .irq = 92 },
+	{ .name = "dma", .irq = 93 },
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
+			.module_bit = OMAP3430_EN_HSOTGUSB_SHIFT,
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
+	 * Erratum ID: i479  idle_req / idle_ack mechanism potentially
+	 * broken when autoidle is enabled
+	 * workaround is to disable the autoidle bit at module level.
+	 */
+	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
+				| HWMOD_SWSUP_MSTANDBY,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -1387,6 +1484,10 @@ static __initdata struct omap_hwmod *oma
 
 	/* dma_system class*/
 	&omap3xxx_dma_system_hwmod,
+
+	/* usbotg class */
+	&omap3xxx_usbhsotg_hwmod,
+
 	NULL,
 };
 
