From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/14] omap3630: Configure HSMMC1 to 4-bit
Date: Thu, 12 Nov 2009 16:08:47 -0800
Message-ID: <20091113000847.9034.90009.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58141 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbZKMAIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:08:42 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

From: Madhu <madhu.cr@ti.com>

The HSMMC1 controller on omap3630 supprts only 4-bit mode. If cpu
is 3630 configure HSMMC1 wires to 4-bit.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 3403914..7bef170 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -489,6 +489,12 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
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

