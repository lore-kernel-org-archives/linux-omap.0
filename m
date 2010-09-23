From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/9 v3] usb: musb: HWMOD database structures addition for OMAP3
Date: Wed, 22 Sep 2010 20:28:40 -0400
Message-ID: <1285201720-26355-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP3 hwmod data stuctures are populated with base address, L3 and L4
interface clocks, IRQs,and sysconfig register details.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -82,6 +82,16 @@ static struct omap_hwmod omap3xxx_l3_mai
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
@@ -90,6 +100,37 @@ static struct omap_hwmod_ocp_if omap3xxx
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
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
@@ -197,6 +238,69 @@ static struct omap_hwmod omap3xxx_iva_hw
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/*
+ * USBHSOTG (USBHS)
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
+	 *
+	 * As per OMAP USBOTG specification, need to configure the USBOTG
+	 *  to smart idle/standby or no idle/standby during data transfer and
+	 * force idle/standby when not in use to support retention and offmode.
+	 */
+	.flags		= HWMOD_NO_OCP_AUTOIDLE | HWMOD_SWSUP_SIDLE
+				| HWMOD_SWSUP_MSTANDBY,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +308,7 @@ static __initdata struct omap_hwmod *oma
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_usbhsotg_hwmod,
 	NULL,
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
