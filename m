From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH] arm: omap3: am35x: Register davinci_mdio before davinci_emac
Date: Thu, 19 Apr 2012 11:19:38 -0700
Message-ID: <1334859578-14446-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:34120 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab2DSSTs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 14:19:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Problem:
--------
When resuming from a Suspend-to-RAM event, the eth0 device
(davinci emac/mdio) on am35xx boards wouldn't work and the
following error message appeared on the console:

"net eth0: could not connect to phy davinci_mdio-0:00"

Cause:
------
When davinci_emac_resume() calls emac_dev_open() which
ultimately calls davinci_mdio_read(), the 'data->suspended'
flag in davinci_mdio.c is still set to 'true'.  This causes
davinci_mdio_read() to fail which ripples back up the call
chain causing davinci_emac_resume() to fail.  The reason
'data->suspended' is still set to 'true' is that
davinci_mdio_resume() hasn't been called yet as it should
have been.  davinci_mdio_resume() must be called before
davinci_emac_resume().

Solution:
---------
Register the "davinci_mdio" platform device before registering
the "davinci_emac" platform device so davinci_mdio_resume()
is called before davinci_emac_resume() and eth0 can resume.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/am35xx-emac.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 1f97e74..d23bd6c 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -97,11 +97,6 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 
 	am35xx_emac_pdata.rmii_en = rmii_en;
 	am35xx_emac_mdio_pdata.bus_freq = mdio_bus_freq;
-	err = platform_device_register(&am35xx_emac_device);
-	if (err) {
-		pr_err("AM35x: failed registering EMAC device: %d\n", err);
-		return;
-	}
 
 	err = platform_device_register(&am35xx_emac_mdio_device);
 	if (err) {
@@ -110,6 +105,12 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 		return;
 	}
 
+	err = platform_device_register(&am35xx_emac_device);
+	if (err) {
+		pr_err("AM35x: failed registering EMAC device: %d\n", err);
+		return;
+	}
+
 	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 	regval = regval & (~(AM35XX_CPGMACSS_SW_RST));
 	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-- 
1.7.9.4

