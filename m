From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/5 v6] OMAP2430: hwmod data: Add USBOTG
Date: Thu, 10 Feb 2011 19:37:57 +0530
Message-ID: <1297346881-13438-2-git-send-email-hemahk@ti.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297346881-13438-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP2430 hwmod data structures are populated with base address, L3 and L4
interface clocks, IRQs and sysconfig register details.

As per OMAP USBOTG specification, need to configure the USBOTG
to smart idle/standby or no idle/standby during data transfer and
force idle/standby when not in use to support retention and off-mode.
By setting HWMOD_SWSUP_SIDLE and HWMOD_SWSUP_MSTANDBY flags, framework
will take care of configuring to no idle/standby when module is enabled
and force idle/standby when suspended.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   98 +++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/omap_hwmod_2430_data.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ linux-2.6/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -89,6 +89,16 @@ static struct omap_hwmod omap2430_uart3_
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
 
@@ -189,6 +199,35 @@ static struct omap_hwmod_ocp_if omap2_l4
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
@@ -919,6 +958,62 @@ static struct omap_hwmod omap2430_dma_sy
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
@@ -941,6 +1036,9 @@ static __initdata struct omap_hwmod *oma
 
 	/* dma_system class*/
 	&omap2430_dma_system_hwmod,
+
+	/* usbotg class*/
+	&omap2430_usbhsotg_hwmod,
 	NULL,
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
