From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/5 v8] arm: omap: usb: ehci and ohci hwmod structures for omap3
Date: Thu, 25 Aug 2011 12:31:34 +0530
Message-ID: <1314255697-15411-3-git-send-email-keshava_mgowda@ti.com>
References: <1314255697-15411-1-git-send-email-keshava_mgowda@ti.com>
 <1314255697-15411-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314255697-15411-2-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Following 4 hwmod structure are added:
UHH hwmod of usbhs with uhh base address and functional clock,
EHCI hwmod with irq and base address,
OHCI hwmod with irq and base address,
TLL hwmod of usbhs with the TLL base address and irq.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  281 ++++++++++++++++++++++++++++
 1 files changed, 281 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 59fdb9f..8a5600f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -84,6 +84,10 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
 static struct omap_hwmod omap3xxx_mcbsp5_hwmod;
 static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
 static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
+static struct omap_hwmod omap34xx_usb_host_hs_hwmod;
+static struct omap_hwmod omap34xx_usbhs_ohci_hwmod;
+static struct omap_hwmod omap34xx_usbhs_ehci_hwmod;
+static struct omap_hwmod omap34xx_usb_tll_hs_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -3196,6 +3200,278 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * 'usb_host_hs' class
+ * high-speed multi-port usb host controller
+ */
+static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__l3_main_2 = {
+	.master		= &omap34xx_usb_host_hs_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class_sysconfig omap34xx_usb_host_hs_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap34xx_usb_host_hs_hwmod_class = {
+	.name = "usbhs_uhh",
+	.sysc = &omap34xx_usb_host_hs_sysc,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_masters[] = {
+	&omap34xx_usb_host_hs__l3_main_2,
+};
+
+static struct omap_hwmod_addr_space omap34xx_usb_host_hs_addrs[] = {
+	{
+		.name		= "uhh",
+		.pa_start	= 0x48064000,
+		.pa_end		= 0x480643ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{} /* Terminating Entry */
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_usb_host_hs_hwmod,
+	.clk		= "l4_ick",
+	.addr		= omap34xx_usb_host_hs_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if omap34xx_f128m_cfg__usb_host_hs = {
+	.clk		= "usbhost_120m_fck",
+	.user		= OCP_USER_MPU,
+	.flags		= OCPIF_SWSUP_IDLE,
+};
+
+static struct omap_hwmod_ocp_if omap34xx_f48m_cfg__usb_host_hs = {
+	.clk		= "usbhost_48m_fck",
+	.user		= OCP_USER_MPU,
+	.flags		= OCPIF_SWSUP_IDLE,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_usb_host_hs_slaves[] = {
+	&omap34xx_l4_cfg__usb_host_hs,
+	&omap34xx_f128m_cfg__usb_host_hs,
+	&omap34xx_f48m_cfg__usb_host_hs,
+};
+
+static struct omap_hwmod omap34xx_usb_host_hs_hwmod = {
+	.name		= "usbhs_uhh",
+	.class		= &omap34xx_usb_host_hs_hwmod_class,
+	.main_clk	= "usbhost_ick",
+	.prcm = {
+		.omap2 = {
+			.module_offs = OMAP3430ES2_USBHOST_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = 0,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = 1,
+			.idlest_stdby_bit = 0,
+		},
+	},
+	.slaves		= omap34xx_usb_host_hs_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_usb_host_hs_slaves),
+	.masters	= omap34xx_usb_host_hs_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_usb_host_hs_masters),
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* 'usbhs_ohci' class  */
+static struct omap_hwmod_ocp_if omap34xx_usbhs_ohci__l3_main_2 = {
+	.master		= &omap34xx_usbhs_ohci_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class omap34xx_usbhs_ohci_hwmod_class = {
+	.name = "usbhs_ohci",
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_usbhs_ohci_masters[] = {
+	&omap34xx_usbhs_ohci__l3_main_2,
+};
+
+static struct omap_hwmod_irq_info omap34xx_usbhs_ohci_irqs[] = {
+	{ .name = "ohci-irq", .irq = 76 },
+	{ .irq = -1 } /* Terminating IRQ */
+};
+
+static struct omap_hwmod_addr_space omap34xx_usbhs_ohci_addrs[] = {
+	{
+		.name		= "ohci",
+		.pa_start	= 0x48064400,
+		.pa_end		= 0x480647FF,
+		.flags		= ADDR_MAP_ON_INIT
+	},
+	{} /* Terminating Entry */
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usbhs_ohci = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_usbhs_ohci_hwmod,
+	.clk		= "l4_ick",
+	.addr		= omap34xx_usbhs_ohci_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_usbhs_ohci_slaves[] = {
+	&omap34xx_l4_cfg__usbhs_ohci,
+};
+
+static struct omap_hwmod omap34xx_usbhs_ohci_hwmod = {
+	.name		= "usbhs_ohci",
+	.class		= &omap34xx_usbhs_ohci_hwmod_class,
+	.mpu_irqs	= omap34xx_usbhs_ohci_irqs,
+	.slaves		= omap34xx_usbhs_ohci_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_usbhs_ohci_slaves),
+	.masters	= omap34xx_usbhs_ohci_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_usbhs_ohci_masters),
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* 'usbhs_ehci' class  */
+static struct omap_hwmod_ocp_if omap34xx_usbhs_ehci__l3_main_2 = {
+	.master		= &omap34xx_usbhs_ehci_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_class omap34xx_usbhs_ehci_hwmod_class = {
+	.name = "usbhs_ehci",
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_usbhs_ehci_masters[] = {
+	&omap34xx_usbhs_ehci__l3_main_2,
+};
+
+static struct omap_hwmod_irq_info omap34xx_usbhs_ehci_irqs[] = {
+	{ .name = "ehci-irq", .irq = 77 },
+	{ .irq = -1 } /* Terminating IRQ */
+};
+
+static struct omap_hwmod_addr_space omap34xx_usbhs_ehci_addrs[] = {
+	{
+		.name		= "ehci",
+		.pa_start	= 0x48064800,
+		.pa_end		= 0x48064CFF,
+		.flags		= ADDR_MAP_ON_INIT
+	},
+	{} /* Terminating Entry */
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usbhs_ehci = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_usbhs_ehci_hwmod,
+	.clk		= "l4_ick",
+	.addr		= omap34xx_usbhs_ehci_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_usbhs_ehci_slaves[] = {
+	&omap34xx_l4_cfg__usbhs_ehci,
+};
+
+static struct omap_hwmod omap34xx_usbhs_ehci_hwmod = {
+	.name		= "usbhs_ehci",
+	.class		= &omap34xx_usbhs_ehci_hwmod_class,
+	.mpu_irqs	= omap34xx_usbhs_ehci_irqs,
+	.slaves		= omap34xx_usbhs_ehci_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_usbhs_ehci_slaves),
+	.masters	= omap34xx_usbhs_ehci_masters,
+	.masters_cnt	= ARRAY_SIZE(omap34xx_usbhs_ehci_masters),
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/*
+ * 'usb_tll_hs' class
+ * usb_tll_hs module is the adapter on the usb_host_hs ports
+ */
+static struct omap_hwmod_class_sysconfig omap34xx_usb_tll_hs_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_SOFTRESET | SYSC_HAS_ENAWAKEUP	|
+				SYSC_HAS_CLOCKACTIVITY),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap34xx_usb_tll_hs_hwmod_class = {
+	.name = "usbhs_tll",
+	.sysc = &omap34xx_usb_tll_hs_sysc,
+};
+
+static struct omap_hwmod_irq_info omap34xx_usb_tll_hs_irqs[] = {
+	{ .name = "tll-irq", .irq = 78 },
+	{ .irq = -1 } /* Terminating IRQ */
+};
+
+static struct omap_hwmod_addr_space omap34xx_usb_tll_hs_addrs[] = {
+	{
+		.name		= "tll",
+		.pa_start	= 0x48062000,
+		.pa_end		= 0x48062fff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{} /* Terminating Entry */
+};
+
+static struct omap_hwmod_ocp_if omap34xx_f_cfg__usb_tll_hs = {
+	.clk		= "usbtll_fck",
+	.user		= OCP_USER_MPU,
+	.flags		= OCPIF_SWSUP_IDLE,
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_tll_hs = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_usb_tll_hs_hwmod,
+	.clk		= "l4_ick",
+	.addr		= omap34xx_usb_tll_hs_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_usb_tll_hs_slaves[] = {
+	&omap34xx_l4_cfg__usb_tll_hs,
+	&omap34xx_f_cfg__usb_tll_hs,
+};
+
+static struct omap_hwmod omap34xx_usb_tll_hs_hwmod = {
+	.name		= "usbhs_tll",
+	.class		= &omap34xx_usb_tll_hs_hwmod_class,
+	.mpu_irqs	= omap34xx_usb_tll_hs_irqs,
+	.main_clk	= "usbtll_ick",
+	.prcm = {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 3,
+			.module_bit = 2,
+			.idlest_reg_id = 3,
+			.idlest_idle_bit = 2,
+		},
+	},
+	.slaves		= omap34xx_usb_tll_hs_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_usb_tll_hs_slaves),
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -3278,6 +3554,11 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	/* usbotg for am35x */
 	&am35xx_usbhsotg_hwmod,
 
+	&omap34xx_usb_host_hs_hwmod,
+	&omap34xx_usbhs_ohci_hwmod,
+	&omap34xx_usbhs_ehci_hwmod,
+	&omap34xx_usb_tll_hs_hwmod,
+
 	NULL,
 };
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
