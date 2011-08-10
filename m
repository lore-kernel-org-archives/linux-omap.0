From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Fix linking error in twl-common.c for OMAP2/3/4
 only builds
Date: Wed, 10 Aug 2011 02:15:19 -0700
Message-ID: <20110810091519.GB1939@atomide.com>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
 <1312893410-3968-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:56487 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922Ab1HJJPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 05:15:30 -0400
Content-Disposition: inline
In-Reply-To: <1312893410-3968-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [110809 05:31]:
> Avoid compiling code for OMAP arch which is not selected by the
> config.
> 
> Fixes issues like:
> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
> 
> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Hi Russel, Tony,
> 
> This patch fixes the linking error caused by the twl-common.c file,
> when the kernel is built for OMAP2/3/4 only.

Thanks, I'll queue this one as a fix with updated comments as below.

Regards,

Tony


From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 9 Aug 2011 15:36:50 +0300
Subject: [PATCH] OMAP: Fix linking error in twl-common.c for OMAP2/3/4 only builds

Commit b22f954 (OMAP4: Move common twl6030 configuration to twl-common)
caused compile failures for code for OMAP arch which is not selected by
the config.

Fixes issues like:
With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:

arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'

Fix the problem by moving the code to ifdef sections for omap3 and omap4.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
[tony@atomide.com: updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 2543342..daa056e 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -48,14 +48,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
-static struct twl4030_usb_data omap4_usb_pdata = {
-	.phy_init	= omap4430_phy_init,
-	.phy_exit	= omap4430_phy_exit,
-	.phy_power	= omap4430_phy_power,
-	.phy_set_clock	= omap4430_phy_set_clk,
-	.phy_suspend	= omap4430_phy_suspend,
-};
-
+#if defined(CONFIG_ARCH_OMAP3)
 static struct twl4030_usb_data omap3_usb_pdata = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -122,6 +115,45 @@ static struct regulator_init_data omap3_vpll2_idata = {
 	.consumer_supplies		= omap3_vpll2_supplies,
 };
 
+void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
+				  u32 pdata_flags, u32 regulators_flags)
+{
+	if (!pmic_data->irq_base)
+		pmic_data->irq_base = TWL4030_IRQ_BASE;
+	if (!pmic_data->irq_end)
+		pmic_data->irq_end = TWL4030_IRQ_END;
+
+	/* Common platform data configurations */
+	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
+		pmic_data->usb = &omap3_usb_pdata;
+
+	if (pdata_flags & TWL_COMMON_PDATA_BCI && !pmic_data->bci)
+		pmic_data->bci = &omap3_bci_pdata;
+
+	if (pdata_flags & TWL_COMMON_PDATA_MADC && !pmic_data->madc)
+		pmic_data->madc = &omap3_madc_pdata;
+
+	if (pdata_flags & TWL_COMMON_PDATA_AUDIO && !pmic_data->audio)
+		pmic_data->audio = &omap3_audio_pdata;
+
+	/* Common regulator configurations */
+	if (regulators_flags & TWL_COMMON_REGULATOR_VDAC && !pmic_data->vdac)
+		pmic_data->vdac = &omap3_vdac_idata;
+
+	if (regulators_flags & TWL_COMMON_REGULATOR_VPLL2 && !pmic_data->vpll2)
+		pmic_data->vpll2 = &omap3_vpll2_idata;
+}
+#endif /* CONFIG_ARCH_OMAP3 */
+
+#if defined(CONFIG_ARCH_OMAP4)
+static struct twl4030_usb_data omap4_usb_pdata = {
+	.phy_init	= omap4430_phy_init,
+	.phy_exit	= omap4430_phy_exit,
+	.phy_power	= omap4430_phy_power,
+	.phy_set_clock	= omap4430_phy_set_clk,
+	.phy_suspend	= omap4430_phy_suspend,
+};
+
 static struct regulator_init_data omap4_vdac_idata = {
 	.constraints = {
 		.min_uV			= 1800000,
@@ -273,32 +305,4 @@ void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 	    !pmic_data->clk32kg)
 		pmic_data->clk32kg = &omap4_clk32kg_idata;
 }
-
-void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
-				  u32 pdata_flags, u32 regulators_flags)
-{
-	if (!pmic_data->irq_base)
-		pmic_data->irq_base = TWL4030_IRQ_BASE;
-	if (!pmic_data->irq_end)
-		pmic_data->irq_end = TWL4030_IRQ_END;
-
-	/* Common platform data configurations */
-	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
-		pmic_data->usb = &omap3_usb_pdata;
-
-	if (pdata_flags & TWL_COMMON_PDATA_BCI && !pmic_data->bci)
-		pmic_data->bci = &omap3_bci_pdata;
-
-	if (pdata_flags & TWL_COMMON_PDATA_MADC && !pmic_data->madc)
-		pmic_data->madc = &omap3_madc_pdata;
-
-	if (pdata_flags & TWL_COMMON_PDATA_AUDIO && !pmic_data->audio)
-		pmic_data->audio = &omap3_audio_pdata;
-
-	/* Common regulator configurations */
-	if (regulators_flags & TWL_COMMON_REGULATOR_VDAC && !pmic_data->vdac)
-		pmic_data->vdac = &omap3_vdac_idata;
-
-	if (regulators_flags & TWL_COMMON_REGULATOR_VPLL2 && !pmic_data->vpll2)
-		pmic_data->vpll2 = &omap3_vpll2_idata;
-}
+#endif /* CONFIG_ARCH_OMAP4 */
