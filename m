From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 7/7] musb: set 'extvbus' for OMAP3EVM Rev >=E
Date: Sun, 15 Nov 2009 14:29:38 +0530
Message-ID: <1258275578-1773-8-git-send-email-ajay.gupta@ti.com>
References: <1258275578-1773-1-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-2-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-3-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-4-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-5-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-6-git-send-email-ajay.gupta@ti.com>
 <1258275578-1773-7-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52214 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbZKOI7q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 03:59:46 -0500
In-Reply-To: <1258275578-1773-7-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: felipe.balbi@nokia.com, khilman@deeprootsystems.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

MUSB interface can source 500mA on OMAP3EVM Rev >= E while Rev < E
supports only 100mA so setting 'extvbus' flag to '1' for OMAP3EVM
Rev >= E.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 0bcf909..a3c8344 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -428,6 +428,8 @@ static void __init omap3_evm_init(void)
 		omap_cfg_reg(AH14_34XX_GPIO21);
 		ehci_pdata.reset_gpio_port[1] = 21;
 
+		/* set flag to program ULPI_BUSCONTROL */
+		musb_bdata.extvbus = 1;
 	} else {
 		/* setup EHCI phy reset on MDC */
 		omap_cfg_reg(AF4_34XX_GPIO135_OUT);
-- 
1.6.2.4

