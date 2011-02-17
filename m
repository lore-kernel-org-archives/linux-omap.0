From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 19:37:49 +0530
Message-ID: <99889a7c6e6df0d50ff668f8bd2e9957@mail.gmail.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
 <1297946466-9565-7-git-send-email-balbi@ti.com> <4D5D25F9.8030907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46284 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750733Ab1BQOHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 09:07:52 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so3413844fxm.15
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 06:07:50 -0800 (PST)
In-Reply-To: <4D5D25F9.8030907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

Benoit,

>-----Original Message-----
>From: Cousson, Benoit [mailto:b-cousson@ti.com]
>Sent: Thursday, February 17, 2011 7:13 PM
>To: Balbi, Felipe
>Cc: Tony Lindgren; Linux OMAP Mailing List; Linux ARM Kernel
>Mailing List; Kalliguddi, Hema; Kevin Hilman; Paul Walmsley
>Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
>
>Hi Felipe and Hema,
>
>Sorry for this late review, but I have a couple of comments on
>this one.
:-)....

>
>Since I was planning to send usb hwmod data file to Tony
>directly like I
>did for the other drivers, I can handle the update myself if you want.
>

I was not aware that you are sending the Hwmod patches for OMAP4
for all the drivers. Anyway I am OK with you sending the patch or
required I can also send it.

>
>On 2/17/2011 1:41 PM, Balbi, Felipe wrote:
>> From: Hema HK<hemahk@ti.com>
>
>The authorship is not correct. It should be me.
>
Yes. I agree. It is a mistake.
>[...]
>
>> +static struct omap_hwmod_class_sysconfig
>omap44xx_usb_otg_hs_sysc = {
>> +	.rev_offs	= 0x0400,
>> +	.sysc_offs	= 0x0404,
>> +	.syss_offs	= 0x0408,
>> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE|
>> +			  SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
>> +			  SYSC_HAS_AUTOIDLE),
>
>These flags does not contains the latest reset flag
>(SYSS_HAS_RESET_STATUS) introduced in 2.6.37.
OK.
>
>[...]
>
>> +static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
>> +	{
>> +		.pa_start	= OMAP44XX_HSUSB_OTG_BASE,
>> +		.pa_end		= OMAP44XX_HSUSB_OTG_BASE + SZ_4K - 1,
>
>You should not use the defines anymore, since the only user of the
>physical address should be this file.

Then we shlould be removing these defines right?
>
>[...]
>
>> +static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
>> +	{ .role = "xclk", .clk = "otg_60m_gfclk_ck" },
>
>That optional clock does not exist anymore, it should be
>"usb_otg_hs_xclk".
>
Since this clock is not enabled for musb as 60Mhz clock is external,
I did not notice this.

In your updated patch  below still the optional clock name is not changed.

>[...]
>
>> @@ -2068,6 +2159,8 @@ static __initdata struct omap_hwmod
>*omap44xx_hwmods[] = {
>>   	&omap44xx_wd_timer2_hwmod,
>>   	&omap44xx_wd_timer3_hwmod,
>>
>> +	/* hsusb otg class */
>> +	&omap44xx_usb_otg_hs_hwmod,
>
>"usb_otb_hs" should be before "wd_timer2".

Is this because of the automated scripts which generates the hwmod?
>
>For information, the updated version is below. It is based on rc5 +
>for_2.6.39/omap4_hwmod_data series I've just sent.

Regards,
Hema
>
>Regards,
>Benoit
>
>
>---
> From 5c2017f9405588127bf0b41f718409411d01abf8 Mon Sep 17 00:00:00 2001
>From: Benoit Cousson <b-cousson@ti.com>
>Date: Thu, 17 Feb 2011 12:41:05 +0000
>Subject: [PATCH] OMAP4430: hwmod data: Add USBOTG
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
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>Cc: Paul Walmsley <paul@pwsan.com>
>Signed-off-by: Felipe Balbi <balbi@ti.com>
>[b-cousson@ti.com: Fix position, opt_clk, and author]
>---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   95
>++++++++++++++++++++++++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>index 989bc96..b27e1e3 100644
>--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>@@ -62,6 +62,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod;
>  static struct omap_hwmod omap44xx_mmc2_hwmod;
>  static struct omap_hwmod omap44xx_mpu_hwmod;
>  static struct omap_hwmod omap44xx_mpu_private_hwmod;
>+static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
>
>  /*
>   * Interconnects omap_hwmod structures
>@@ -344,6 +345,14 @@ static struct omap_hwmod_ocp_if
>omap44xx_l4_cfg__l3_main_2 = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>
>+/* usb_otg_hs -> l3_main_2 */
>+static struct omap_hwmod_ocp_if omap44xx_usb_otg_hs__l3_main_2 = {
>+	.master		= &omap44xx_usb_otg_hs_hwmod,
>+	.slave		= &omap44xx_l3_main_2_hwmod,
>+	.clk		= "l3_div_ck",
>+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>+};
>+
>  /* l3_main_2 slave ports */
>  static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
>  	&omap44xx_dma_system__l3_main_2,
>@@ -353,6 +362,7 @@ static struct omap_hwmod_ocp_if
>*omap44xx_l3_main_2_slaves[] = {
>  	&omap44xx_iva__l3_main_2,
>  	&omap44xx_l3_main_1__l3_main_2,
>  	&omap44xx_l4_cfg__l3_main_2,
>+	&omap44xx_usb_otg_hs__l3_main_2,
>  };
>
>  static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
>@@ -4725,6 +4735,88 @@ static struct omap_hwmod
>omap44xx_uart4_hwmod = {
>  };
>
>  /*
>+ * 'usb_otg_hs' class
>+ * high-speed on-the-go universal serial bus (usb_otg_hs) controller
>+ */
>+
>+static struct omap_hwmod_class_sysconfig omap44xx_usb_otg_hs_sysc = {
>+	.rev_offs	= 0x0400,
>+	.sysc_offs	= 0x0404,
>+	.syss_offs	= 0x0408,
>+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
>+			   SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
>+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
>+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
>+			   SIDLE_SMART_WKUP | MSTANDBY_FORCE |
>MSTANDBY_NO |
>+			   MSTANDBY_SMART),
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
>+		.pa_start	= 0x4a0ab000,
>+		.pa_end		= 0x4a0ab003,
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
>+/*
>   * 'wd_timer' class
>   * 32-bit watchdog upward counter that generates a pulse on
>the reset
>pin on
>   * overflow condition
>@@ -4995,6 +5087,9 @@ static __initdata struct omap_hwmod
>*omap44xx_hwmods[] = {
>  	&omap44xx_uart3_hwmod,
>  	&omap44xx_uart4_hwmod,
>
>+	/* usb_otg_hs class */
>+	&omap44xx_usb_otg_hs_hwmod,
>+
>  	/* wd_timer class */
>  	&omap44xx_wd_timer2_hwmod,
>  	&omap44xx_wd_timer3_hwmod,
>--
>1.7.0.4
>
>
