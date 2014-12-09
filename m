From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 7/7] arm: omap: hwmod: 43xx: remove sysc and class data
Date: Tue, 9 Dec 2014 16:27:52 -0600
Message-ID: <1418164072-19087-8-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39836 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387AbaLIW2b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 17:28:31 -0500
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

now that this data comes from DT, we can safely
remove them from this file.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 61 ------------------------------
 1 file changed, 61 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 5c6c841..f990782 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -95,22 +95,10 @@ static struct omap_hwmod am43xx_gpio0_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 };
 
-static struct omap_hwmod_class_sysconfig am43xx_synctimer_sysc = {
-	.rev_offs	= 0x0,
-	.sysc_offs	= 0x4,
-	.sysc_flags	= SYSC_HAS_SIDLEMODE,
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
 
-static struct omap_hwmod_class am43xx_synctimer_hwmod_class = {
-	.name	= "synctimer",
-	.sysc	= &am43xx_synctimer_sysc,
-};
 
 static struct omap_hwmod am43xx_synctimer_hwmod = {
 	.name		= "counter_32k",
-	.class		= &am43xx_synctimer_hwmod_class,
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
 	.main_clk	= "synctimer_32kclk",
@@ -318,13 +306,9 @@ static struct omap_hwmod am43xx_gpio5_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 };
 
-static struct omap_hwmod_class am43xx_ocp2scp_hwmod_class = {
-	.name	= "ocp2scp",
-};
 
 static struct omap_hwmod am43xx_ocp2scp0_hwmod = {
 	.name		= "ocp2scp0",
-	.class		= &am43xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.main_clk	= "l4ls_gclk",
 	.prcm = {
@@ -337,7 +321,6 @@ static struct omap_hwmod am43xx_ocp2scp0_hwmod = {
 
 static struct omap_hwmod am43xx_ocp2scp1_hwmod = {
 	.name		= "ocp2scp1",
-	.class		= &am43xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.main_clk	= "l4ls_gclk",
 	.prcm = {
@@ -348,26 +331,8 @@ static struct omap_hwmod am43xx_ocp2scp1_hwmod = {
 	},
 };
 
-static struct omap_hwmod_class_sysconfig am43xx_usb_otg_ss_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.sysc_flags	= (SYSC_HAS_DMADISABLE | SYSC_HAS_MIDLEMODE |
-				SYSC_HAS_SIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-				SIDLE_SMART_WKUP | MSTANDBY_FORCE |
-				MSTANDBY_NO | MSTANDBY_SMART |
-				MSTANDBY_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type2,
-};
-
-static struct omap_hwmod_class am43xx_usb_otg_ss_hwmod_class = {
-	.name	= "usb_otg_ss",
-	.sysc	= &am43xx_usb_otg_ss_sysc,
-};
-
 static struct omap_hwmod am43xx_usb_otg_ss0_hwmod = {
 	.name		= "usb_otg_ss0",
-	.class		= &am43xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
 	.main_clk	= "l3s_gclk",
 	.prcm = {
@@ -380,7 +345,6 @@ static struct omap_hwmod am43xx_usb_otg_ss0_hwmod = {
 
 static struct omap_hwmod am43xx_usb_otg_ss1_hwmod = {
 	.name		= "usb_otg_ss1",
-	.class		= &am43xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
 	.main_clk	= "l3s_gclk",
 	.prcm = {
@@ -391,22 +355,10 @@ static struct omap_hwmod am43xx_usb_otg_ss1_hwmod = {
 	},
 };
 
-static struct omap_hwmod_class_sysconfig am43xx_qspi_sysc = {
-	.sysc_offs      = 0x0010,
-	.sysc_flags     = SYSC_HAS_SIDLEMODE,
-	.idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-				SIDLE_SMART_WKUP),
-	.sysc_fields    = &omap_hwmod_sysc_type2,
-};
 
-static struct omap_hwmod_class am43xx_qspi_hwmod_class = {
-	.name   = "qspi",
-	.sysc   = &am43xx_qspi_sysc,
-};
 
 static struct omap_hwmod am43xx_qspi_hwmod = {
 	.name           = "qspi",
-	.class          = &am43xx_qspi_hwmod_class,
 	.clkdm_name     = "l3s_clkdm",
 	.main_clk       = "l3s_gclk",
 	.prcm = {
@@ -421,23 +373,10 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
  * 'adc/tsc' class
  * TouchScreen Controller (Analog-To-Digital Converter)
  */
-static struct omap_hwmod_class_sysconfig am43xx_adc_tsc_sysc = {
-	.rev_offs	= 0x00,
-	.sysc_offs	= 0x10,
-	.sysc_flags	= SYSC_HAS_SIDLEMODE,
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			  SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type2,
-};
 
-static struct omap_hwmod_class am43xx_adc_tsc_hwmod_class = {
-	.name		= "adc_tsc",
-	.sysc		= &am43xx_adc_tsc_sysc,
-};
 
 static struct omap_hwmod am43xx_adc_tsc_hwmod = {
 	.name		= "adc_tsc",
-	.class		= &am43xx_adc_tsc_hwmod_class,
 	.clkdm_name	= "l3s_tsc_clkdm",
 	.main_clk	= "adc_tsc_fck",
 	.prcm		= {
-- 
2.2.0

