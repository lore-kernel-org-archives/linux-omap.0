From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 1/7] OMAP4-HSMMC: FIX for MMC5 Controller IRQ Base
Date: Wed, 21 Apr 2010 23:49:37 +0530 (IST)
Message-ID: <63397.10.24.255.18.1271873977.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990Ab0DUSTv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 14:19:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

This patch fixes HSMMC Controller5 IRQ Base.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 23e4d77..2271b9b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -726,7 +726,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data
 			if (!cpu_is_omap44xx())
 				return;
 			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
-			irq = OMAP44XX_IRQ_MMC4;
+			irq = OMAP44XX_IRQ_MMC5;
 			break;
 		default:
 			continue;
-- 
1.6.3.3


