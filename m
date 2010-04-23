From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/28] OMAP4-HSMMC: FIX for MMC5 Controller IRQ Base
Date: Fri, 23 Apr 2010 16:11:24 -0700
Message-ID: <20100423231124.31953.17833.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61529 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab0DWXLY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:24 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>

From: kishore kadiyala <kishore.kadiyala@ti.com>

This patch fixes HSMMC Controller5 IRQ Base.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 23e4d77..2271b9b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -726,7 +726,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			if (!cpu_is_omap44xx())
 				return;
 			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
-			irq = OMAP44XX_IRQ_MMC4;
+			irq = OMAP44XX_IRQ_MMC5;
 			break;
 		default:
 			continue;

