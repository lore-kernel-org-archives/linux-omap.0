From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Omap3630:Configure HSMMC1 to 4-bit
Date: Thu, 22 Oct 2009 23:11:10 +0530 (IST)
Message-ID: <63223.192.168.10.89.1256233270.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56877 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbZJVRlI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Oct 2009 13:41:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

>From 69189aa64954eded29921f3c248a9c1c0f5214e5 Mon Sep 17 00:00:00 2001
From: Madhu <madhu.cr@ti.com>
Date: Wed, 21 Oct 2009 16:32:49 -0400
Subject: [PATCH] Omap3630: Configure HSMMC1 to 4-bit.

The HSMMC1 controller on omap3630 supprts only 4-bit mode. If cpu
is 3630 configure HSMMC1 wires to 4-bit.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 3403914..7bef170 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -489,6 +489,12 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info
*controllers)
 			/* on-chip level shifting via PBIAS0/PBIAS1 */
 			mmc->slots[0].set_power = twl_mmc1_set_power;
 			mmc->slots[0].set_sleep = twl_mmc1_set_sleep;
+
+			/* Omap3630 HSMMC1 supports only 4-bit */
+			if (cpu_is_omap3630() && c->wires > 4) {
+				c->wires = 4;
+				mmc->slots[0].wires = c->wires;
+			}
 			break;
 		case 2:
 			if (c->ext_clock)
-- 
1.6.0.4



