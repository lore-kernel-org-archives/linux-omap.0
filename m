From: Igor Mazanov <i.mazanov@gmail.com>
Subject: AM335x: Beaglebone stops to boot with current git kernel
Date: Wed, 14 Nov 2012 19:28:45 +0400
Message-ID: <k80da6$61d$1@ger.gmane.org>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36828 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932736Ab2KNP2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 10:28:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TYet9-0003lc-DL
	for linux-omap@vger.kernel.org; Wed, 14 Nov 2012 16:28:27 +0100
Received: from 77.232.56.122 ([77.232.56.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 16:28:27 +0100
Received: from i.mazanov by 77.232.56.122 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 16:28:27 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Beaglebone boot process is broken with the current git kernel. I use 
omap2plus_defconfig for tests.

It looks like the boot process stops due to the last changes in the AM33xx clock 
sysbsystem. A following patch resolves this issue:

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c 
b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index ad8d43b..858e180 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -586,7 +586,7 @@ static struct omap_hwmod am33xx_smartreflex0_hwmod = {
         .class          = &am33xx_smartreflex_hwmod_class,
         .clkdm_name     = "l4_wkup_clkdm",
         .mpu_irqs       = am33xx_smartreflex0_irqs,
-       .main_clk       = "smartreflex0_fck",
+       .main_clk       = "smartreflex_mpu_fck",
         .prcm           = {
                 .omap4  = {
                         .clkctrl_offs   = 
AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET,
@@ -606,7 +606,7 @@ static struct omap_hwmod am33xx_smartreflex1_hwmod = {
         .class          = &am33xx_smartreflex_hwmod_class,
         .clkdm_name     = "l4_wkup_clkdm",
         .mpu_irqs       = am33xx_smartreflex1_irqs,
-       .main_clk       = "smartreflex1_fck",
+       .main_clk       = "smartreflex_core_fck",
         .prcm           = {
                 .omap4  = {
                         .clkctrl_offs   = 
AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET,


Regards,
Igor.

