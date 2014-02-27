From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP3: Fix pinctrl interrupts for core2
Date: Thu, 27 Feb 2014 13:49:21 -0800
Message-ID: <20140227214921.GO11654@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42250 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbaB0Vtd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Feb 2014 16:49:33 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

After splitting padconf core into two parts to avoid exposing
unaccessable registers, the new padconf core2 domain was left
without a wake-up interrupt.

Fix the issue by passing the shared wake-up interrupt in
platform data like we do for padconf core and wkup domains
already.

Fixes: 3d49538364 (ARM: dts: Split omap3 pinmux core device)

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -239,6 +239,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #endif
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap3-padconf", 0x480025a0, "480025a0.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
 	/* Only on am3517 */
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
