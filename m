From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [PATCH 3/5 v5] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 3 Feb 2011 11:25:42 +0530
Message-ID: <cdf356a102d5f52fce139c5e89e32ef9@mail.gmail.com>
References: <1291991739-21705-1-git-send-email-hemahk@ti.com> <1291991739-21705-4-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49481 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797Ab1BCFzo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 00:55:44 -0500
In-Reply-To: <1291991739-21705-4-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema Kalliguddi <hemahk@ti.com>, linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

Hi,

>-----Original Message-----
>From: Hema HK [mailto:hemahk@ti.com]
>Sent: Friday, December 10, 2010 8:06 PM
>To: linux-usb@vger.kernel.org
>Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Hema HK;
>Felipe Balbi; Tony Lindgren; Kevin Hilman; Paul Walmsley
>Subject: [PATCH 3/5 v5] OMAP4430: hwmod data: Adding USBOTG
>
>From: Cousson, Benoit <b-cousson@ti.com>
>
>OMAP4 hwmod data structures are populated with base address, L3 and L4
>interface clocks, IRQs and sysconfig register details.
>
>As per OMAP USBOTG specification, need to configure the USBOTG
>to smart idle/standby or no idle/standby during data transfer and
>force idle/standby when not in use to support retention and offmode.
>By setting HWMOD_SWSUP_SIDLE and HWMOD_SWSUP_MSTANDBY flags,framework
>will take care of configuring to no idle/standby when module is enabled
>and force idle/standby when idled.
>
>Signed-off-by: Cousson, Benoit <b-cousson@ti.com>
>Signed-off-by: Hema HK <hemahk@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>Cc: Cousson, Benoit <b-cousson@ti.com>
>Cc: Paul Walmsley <paul@pwsan.com>
>---
> arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   94
>+++++++++++++++++++++++++++++
> 1 file changed, 94 insertions(+)
>
>Index: usb/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>===================================================================
>--- usb.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>+++ usb/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>@@ -47,6 +47,7 @@ static struct omap_hwmod omap44xx_l4_per
> static struct omap_hwmod omap44xx_l4_wkup_hwmod;
> static struct omap_hwmod omap44xx_mpu_hwmod;
> static struct omap_hwmod omap44xx_mpu_private_hwmod;
>+static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
>
> /*
>  * Interconnects omap_hwmod structures
>@@ -223,10 +224,19 @@ static struct omap_hwmod_ocp_if omap44xx
> 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> };
>
>+/* usb_otg_hs -> l3_main_2 */
>+static struct omap_hwmod_ocp_if omap44xx_usb_otg_hs__l3_main_2 = {
>+	.master		= &omap44xx_usb_otg_hs_hwmod,
>+	.slave		= &omap44xx_l3_main_2_hwmod,
>+	.clk		= "l3_div_ck",
>+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>+};
>+
> /* l3_main_2 slave ports */
> static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
> 	&omap44xx_l3_main_1__l3_main_2,
> 	&omap44xx_l4_cfg__l3_main_2,
>+	&omap44xx_usb_otg_hs__l3_main_2,
> };
>
> static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
>@@ -811,6 +821,87 @@ static struct omap_hwmod omap44xx_uart4_
> 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> };
>
>+/*
>+ * 'usb_otg_hs' class
>+ * high-speed on-the-go universal serial bus (usb_otg_hs) controller
>+ */
>+
>+static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
>+	.rev_offs	= 0x0400,
>+	.sysc_offs	= 0x0404,
>+	.syss_offs	= 0x0408,
>+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
>+			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
>+			  SYSC_HAS_AUTOIDLE),
>+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>+			  MSTANDBY_FORCE | MSTANDBY_NO |
>MSTANDBY_SMART),
>+	.sysc_fields	= &omap_hwmod_sysc_type1,
>+};
>+
>+static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
>+	.name = "usb_otg_hs",
>+	.sysc = &omap44xx_usb_otg_hs_sysc,
>+};
>+
>+/* usb_otg_hs */
>+static struct omap_hwmod_irq_info omap44xx_usb_otg_hs_irqs[] = {
>+	{ .name = "mc", .irq = 92 + OMAP44XX_IRQ_GIC_START },
>+	{ .name = "dma", .irq = 93 + OMAP44XX_IRQ_GIC_START },
>+};
>+
>+/* usb_otg_hs master ports */
>+static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_masters[] = {
>+	&omap44xx_usb_otg_hs__l3_main_2,
>+};
>+
>+static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
>+	{
>+		.pa_start	= OMAP44XX_HSUSB_OTG_BASE,
>+		.pa_end		= OMAP44XX_HSUSB_OTG_BASE + SZ_4K - 1,
>+		.flags		= ADDR_TYPE_RT
>+	},
>+};
>+
>+/* l4_cfg -> usb_otg_hs */
>+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_otg_hs = {
>+	.master		= &omap44xx_l4_cfg_hwmod,
>+	.slave		= &omap44xx_usb_otg_hs_hwmod,
>+	.clk		= "l4_div_ck",
>+	.addr		= omap44xx_usb_otg_hs_addrs,
>+	.addr_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_addrs),
>+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>+};
>+
>+/* usb_otg_hs slave ports */
>+static struct omap_hwmod_ocp_if *omap44xx_usb_otg_hs_slaves[] = {
>+	&omap44xx_l4_cfg__usb_otg_hs,
>+};
>+
>+static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
>+	{ .role = "xclk", .clk = "otg_60m_gfclk_ck" },
>+};
>+
>+static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
>+	.name		= "usb_otg_hs",
>+	.class		= &omap44xx_usb_otg_hs_hwmod_class,
>+	.mpu_irqs	= omap44xx_usb_otg_hs_irqs,
>+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_irqs),
>+	.main_clk	= "usb_otg_hs_ick",
>+	.prcm = {
>+		.omap4 = {
>+			.clkctrl_reg =
>OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
>+		},
>+	},
>+	.opt_clks	= usb_otg_hs_opt_clks,
>+	.opt_clks_cnt = ARRAY_SIZE(usb_otg_hs_opt_clks),
>+	.slaves		= omap44xx_usb_otg_hs_slaves,
>+	.slaves_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_slaves),
>+	.masters	= omap44xx_usb_otg_hs_masters,
>+	.masters_cnt	= ARRAY_SIZE(omap44xx_usb_otg_hs_masters),
>+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
>+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>+};
>+
> static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
> 	/* dmm class */
> 	&omap44xx_dmm_hwmod,
>@@ -840,6 +931,9 @@ static __initdata struct omap_hwmod *oma
> 	&omap44xx_uart2_hwmod,
> 	&omap44xx_uart3_hwmod,
> 	&omap44xx_uart4_hwmod,
>+
>+	/* hsusb otg class */
>+	&omap44xx_usb_otg_hs_hwmod,
> 	NULL,
> };
>
>

Any comments?

Regards,
Hema
