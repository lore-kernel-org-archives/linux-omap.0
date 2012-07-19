From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci
 EMAC
Date: Thu, 19 Jul 2012 16:59:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207191649040.14390@utopia.booyaka.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com> <1336770778-23044-3-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1207171814100.28834@utopia.booyaka.com> <20120718213246.GD27904@animalcreek.com> <alpine.DEB.2.00.1207181723120.19048@utopia.booyaka.com>
 <20120719182602.GB24076@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43582 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab2GSW7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 18:59:08 -0400
In-Reply-To: <20120719182602.GB24076@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ilya Yanok <yanok@emcraft.com>

+ Ilya

Hi Mark

Maybe try something like this on top of the patch that disables the 
MPU DPLL autoidle?

I don't know what am35xx_enable_emac_int() is supposed to do.  It seems 
strange to clear the interrupt status bits when one is supposed to enable 
the interrupts.  Maybe Ilya can shed some light on it.


- Paul

---
 arch/arm/mach-omap2/am35xx-emac.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 2c90ac6..231190e 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -23,23 +23,17 @@
 #include "control.h"
 #include "am35xx-emac.h"
 
-static void am35xx_enable_emac_int(void)
-{
-	u32 v;
-
-	v = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	v |= (AM35XX_CPGMAC_C0_RX_PULSE_CLR | AM35XX_CPGMAC_C0_TX_PULSE_CLR |
-	      AM35XX_CPGMAC_C0_MISC_PULSE_CLR | AM35XX_CPGMAC_C0_RX_THRESH_CLR);
-	omap_ctrl_writel(v, AM35XX_CONTROL_LVL_INTR_CLEAR);
-	omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR); /* OCP barrier */
-}
-
 static void am35xx_disable_emac_int(void)
 {
 	u32 v;
 
-	v = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	v |= (AM35XX_CPGMAC_C0_RX_PULSE_CLR | AM35XX_CPGMAC_C0_TX_PULSE_CLR);
+	/* XXX What about the misc interrupts? */
+	/*
+	 * XXX MDIO driver should handle its interrupts through the EMAC
+	 * driver
+	 */
+	v = (AM35XX_CPGMAC_C0_RX_PULSE_CLR | AM35XX_CPGMAC_C0_TX_PULSE_CLR |
+	     AM35XX_CPGMAC_C0_MISC_PULSE_CLR | AM35XX_CPGMAC_C0_RX_THRESH_CLR);
 	omap_ctrl_writel(v, AM35XX_CONTROL_LVL_INTR_CLEAR);
 	omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR); /* OCP barrier */
 }
@@ -51,7 +45,6 @@ static struct emac_platform_data am35xx_emac_pdata = {
 	.ctrl_ram_size		= AM35XX_EMAC_CNTRL_RAM_SIZE,
 	.hw_ram_addr		= AM35XX_EMAC_HW_RAM_ADDR,
 	.version		= EMAC_VERSION_2,
-	.interrupt_enable	= am35xx_enable_emac_int,
 	.interrupt_disable	= am35xx_disable_emac_int,
 };
 
-- 
1.7.10.4

